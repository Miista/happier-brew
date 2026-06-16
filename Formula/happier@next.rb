class HappierATNext < Formula
  desc "Mobile and Web client for Claude Code and Codex (next/preview channel)"
  homepage "https://github.com/happier-dev/happier"
  version "0.2.2-preview.1775586717.26498"

  conflicts_with "happier",
    because: "both install the `happier` binary"
  conflicts_with "happier@dev",
    because: "both install the `happier` binary"

  on_macos do
    on_arm do
      url "https://github.com/happier-dev/happier/releases/download/cli-v#{version}/happier-v#{version}-darwin-arm64.tar.gz"
      sha256 "7813931a87452a4edfbfcaa5a366901098ab7384165c94612d5a22019f05623a"
    end
    on_intel do
      url "https://github.com/happier-dev/happier/releases/download/cli-v#{version}/happier-v#{version}-darwin-x64.tar.gz"
      sha256 "b62035ba5c33dd029cb4a60f690ab4898fdc20683fb3c76efb77be833722cef6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/happier-dev/happier/releases/download/cli-v#{version}/happier-v#{version}-linux-arm64.tar.gz"
      sha256 "4bdb54e1e3600d7e5ee5f11657332c74be153a082d8bf9b9a00ebf2bdbd4cb1e"
    end
    on_intel do
      url "https://github.com/happier-dev/happier/releases/download/cli-v#{version}/happier-v#{version}-linux-x64.tar.gz"
      sha256 "013370c08c0ba7d541c496e97cd5922e830fe39dcb8db096cbf7cfc3bef2ce91"
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
