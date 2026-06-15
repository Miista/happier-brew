class Happier < Formula
  desc "Mobile and Web client for Claude Code and Codex"
  homepage "https://github.com/happier-dev/happier"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/happier-dev/happier/releases/download/cli-v#{version}/happier-v#{version}-darwin-arm64.tar.gz"
      sha256 "49be2e4079c4cec9b4e22a703ff3da54c1d0a53af8a6b0649ede019f5fbf7ec8" # arm64
    end

    on_intel do
      url "https://github.com/happier-dev/happier/releases/download/cli-v#{version}/happier-v#{version}-darwin-x64.tar.gz"
      sha256 "ca668ab55698ba93d39971eb4f2bb3277e1feb69249a7957132b65251e427d4e" # x64
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"happier"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/happier --version 2>&1")
  end
end
