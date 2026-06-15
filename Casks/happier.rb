cask "happier" do
  version "0.2.1"

  on_arm do
    url "https://github.com/happier-dev/happier/releases/download/cli-v#{version}/happier-v#{version}-darwin-arm64.tar.gz"
    sha256 "49be2e4079c4cec9b4e22a703ff3da54c1d0a53af8a6b0649ede019f5fbf7ec8" # arm64
  end

  on_intel do
    url "https://github.com/happier-dev/happier/releases/download/cli-v#{version}/happier-v#{version}-darwin-x64.tar.gz"
    sha256 "ca668ab55698ba93d39971eb4f2bb3277e1feb69249a7957132b65251e427d4e" # x64
  end

  desc "Mobile and Web client for Claude Code and Codex"
  homepage "https://github.com/happier-dev/happier"

  preflight do
    Dir["#{staged_path}/happier-v#{version}-darwin-*"].each do |dir|
      FileUtils.mv(dir, "#{staged_path}/happier")
    end
  end

  binary "happier/happier"

  zap trash: [
    "~/.happier",
    "~/.config/happier",
  ]
end
