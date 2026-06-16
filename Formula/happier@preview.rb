class HappierATPreview < Formula
  desc "Mobile and Web client for Claude Code and Codex (preview channel)"
  homepage "https://github.com/happier-dev/happier"
  version "0.2.8-dev.7"

  conflicts_with "happier",
    because: "both install the `happier` binary"

  on_macos do
    on_arm do
      url "https://github.com/happier-dev/happier/releases/download/cli-v#{version}/happier-v#{version}-darwin-arm64.tar.gz"
      sha256 "1b13c656c06e62d744c7e4e00b1e00abde36b52bc7f595a2dad7fc150e74e7a0"
    end
    on_intel do
      url "https://github.com/happier-dev/happier/releases/download/cli-v#{version}/happier-v#{version}-darwin-x64.tar.gz"
      sha256 "ca691197e23b1d2bcee79e3def128426050eb1a6af837d0c790dd3f79f5dcc42"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/happier-dev/happier/releases/download/cli-v#{version}/happier-v#{version}-linux-arm64.tar.gz"
      sha256 "5c56a3d7eac0a699e7f0ab14801bb2e8590726b9a839915560b530fa85e57bfe"
    end
    on_intel do
      url "https://github.com/happier-dev/happier/releases/download/cli-v#{version}/happier-v#{version}-linux-x64.tar.gz"
      sha256 "7dcbedd3eef0274c6c6e26e661df83ebb52f2a2b98616fa0df6db0e58146b276"
    end
  end

  def install
    libexec.install Dir["happier-v#{version}-*/*"]
    bin.install_symlink libexec/"happier"
  end

  test do
    system bin/"happier", "--version"
  end
end
