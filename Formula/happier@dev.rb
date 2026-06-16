class HappierATDev < Formula
  desc "Mobile and Web client for Claude Code and Codex (dev channel)"
  homepage "https://github.com/happier-dev/happier"
  version "0.2.6-dev.1778098335.1"

  conflicts_with "happier",
    because: "both install the `happier` binary"
  conflicts_with "happier@next",
    because: "both install the `happier` binary"

  on_macos do
    on_arm do
      url "https://github.com/happier-dev/happier/releases/download/cli-v#{version}/happier-v#{version}-darwin-arm64.tar.gz"
      sha256 "772b39c86d6ed38b88180a9e50c223d0e6924efe855239e15cfa48a9c7ef5285"
    end
    on_intel do
      url "https://github.com/happier-dev/happier/releases/download/cli-v#{version}/happier-v#{version}-darwin-x64.tar.gz"
      sha256 "9f02f9a4494c503d8b22c87a8fc5d29725a422f35c98c695250fcb7d063c7be8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/happier-dev/happier/releases/download/cli-v#{version}/happier-v#{version}-linux-arm64.tar.gz"
      sha256 "93abdaec23363eb9d980561ecd8c93a7400b41f44f94f8e0e193c1aa1da9b02d"
    end
    on_intel do
      url "https://github.com/happier-dev/happier/releases/download/cli-v#{version}/happier-v#{version}-linux-x64.tar.gz"
      sha256 "e184918ddba30741f7f381722ada786628db044d9f0b082620ced7b06df7dd63"
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
