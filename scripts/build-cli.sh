#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${1:?Usage: build-cli.sh <happier-repo-dir> <out-dir>}"
OUT_DIR="${2:?Usage: build-cli.sh <happier-repo-dir> <out-dir>}"

mkdir -p "$OUT_DIR"
cd "$REPO_DIR"

echo "==> Installing dependencies"
bun install --ignore-scripts

echo "==> Building workspace packages"
yarn workspace @happier-dev/protocol build
yarn workspace @happier-dev/agents build
yarn workspace @happier-dev/release-runtime build
yarn workspace @happier-dev/connection-supervisor build
yarn workspace @happier-dev/transfers build

echo "==> Building cli-common subpath exports"
CLI_COMMON="packages/cli-common"

# Rebuild all exports declared in package.json from source, bypassing tsc errors
node - <<'EOF'
const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const pkg = JSON.parse(fs.readFileSync('packages/cli-common/package.json', 'utf8').replace(/\/\/.*/g, ''));
const exports_ = pkg.exports || {};

for (const [key, value] of Object.entries(exports_)) {
  const distFile = (typeof value === 'string' ? value : value.default || '').replace(/^\.\//, '');
  if (!distFile) continue;

  const subpath = key.replace(/^\.\//, '') || 'index';
  let srcFile = `packages/cli-common/src/${subpath}`;

  let src = null;
  if (fs.existsSync(`${srcFile}/index.ts`)) src = `${srcFile}/index.ts`;
  else if (fs.existsSync(`${srcFile}.ts`)) src = `${srcFile}.ts`;
  else { console.log(`SKIP ${subpath} (no source)`); continue; }

  const outFile = `packages/cli-common/${distFile}`;
  fs.mkdirSync(path.dirname(outFile), { recursive: true });

  try {
    execSync(`bun build ${src} --outfile ${outFile} --target=node`, { stdio: 'pipe' });
    console.log(`OK   ${subpath}`);
  } catch (e) {
    console.error(`FAIL ${subpath}: ${e.stderr?.toString().split('\n')[0]}`);
  }
}
EOF

echo "==> Compiling binaries"
for target in bun-darwin-arm64 bun-darwin-x64; do
  arch="${target##*-}"
  outfile="$OUT_DIR/happier-darwin-${arch}"
  echo "  -> $target"
  bun build --compile apps/cli/src/index.ts --target="$target" --outfile="$outfile"
  codesign --remove-signature "$outfile" 2>/dev/null || true
  codesign --sign - "$outfile"
  echo "  -> $(${outfile} --version 2>&1) [${arch}]"
done

echo "==> Done. Binaries in $OUT_DIR:"
ls -lh "$OUT_DIR"/happier-darwin-*
