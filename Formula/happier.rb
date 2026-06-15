class Happier < Formula
  desc "Mobile and Web client for Claude Code and Codex"
  homepage "https://www.npmjs.com/package/@happier-dev/cli"
  url "https://registry.npmjs.org/@happier-dev/cli/-/cli-0.2.1.tgz"
  sha256 "736c04e15fa95edffa9a7a8a9300fd01dcf0af9b6fd68f2d630d8cbbb6479120"
  license "MIT"
  version "0.2.1"

  depends_on "node"

  def install
    libexec.install Dir["*"]

    %w[
      happier
      happier-dev
      happier-mcp
      happier-mcp-remote-bridge
      happier-mcp-stdio-launcher
    ].each do |cmd|
      (bin/cmd).write_env_script libexec/"bin/#{cmd}.mjs",
        PATH: "#{Formula["node"].opt_bin}:$PATH"
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/happier --version 2>&1", 1)
  end
end
