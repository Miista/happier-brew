class Happier < Formula
  desc "Mobile and Web client for Claude Code and Codex"
  homepage "https://github.com/happier-dev/happier"
  version "0.2.1"

  conflicts_with "happier@next",
    because: "both install the `happier` binary"
  conflicts_with "happier@dev",
    because: "both install the `happier` binary"

  on_macos do
    on_arm do
      url "https://github.com/happier-dev/happier/releases/download/cli-v#{version}/happier-v#{version}-darwin-arm64.tar.gz"
      sha256 "49be2e4079c4cec9b4e22a703ff3da54c1d0a53af8a6b0649ede019f5fbf7ec8"
    end
    on_intel do
      url "https://github.com/happier-dev/happier/releases/download/cli-v#{version}/happier-v#{version}-darwin-x64.tar.gz"
      sha256 "ca668ab55698ba93d39971eb4f2bb3277e1feb69249a7957132b65251e427d4e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/happier-dev/happier/releases/download/cli-v#{version}/happier-v#{version}-linux-arm64.tar.gz"
      sha256 "8172ca1d312e4f3b94e01957e7abae2f8fc8643a15ce87dcae06e6fc643228a5"
    end
    on_intel do
      url "https://github.com/happier-dev/happier/releases/download/cli-v#{version}/happier-v#{version}-linux-x64.tar.gz"
      sha256 "7c7f049ed52ebe3ea55c6126a86a8d7d89c30be360ee8f2913697919d5a94679"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"happier"
  end

  test do
    system bin/"happier", "--version"
  end
end
