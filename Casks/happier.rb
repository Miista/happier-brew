cask "happier" do
  version "0.2.8"

  on_arm do
    url "https://github.com/happier-dev/homebrew-happier/releases/download/v#{version}/happier-darwin-arm64"
    sha256 :no_check
  end

  on_intel do
    url "https://github.com/happier-dev/homebrew-happier/releases/download/v#{version}/happier-darwin-x64"
    sha256 :no_check
  end

  desc "Mobile and Web client for Claude Code and Codex"
  homepage "https://github.com/happier-dev/happier"

  binary "happier-darwin-arm64", target: "happier" if Hardware::CPU.arm?
  binary "happier-darwin-x64",   target: "happier" if Hardware::CPU.intel?

  zap trash: [
    "~/.happier",
    "~/.config/happier",
  ]
end
