cask "hridya-foundry" do
  version "1.4.0"
  sha256 "311b3c93086b0cdc3782cec5d6514708f90dbddeeca7f4cb6c1e9db8e9239aaa"

  url "https://github.com/hridaya423/foundry/releases/download/v#{version}/Foundry.dmg"
  name "Foundry"
  desc "Launcher for apps, files, clipboard history, snippets and windows"
  homepage "https://foundry.hridya.tech/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Foundry.app"

  zap trash: [
    "~/.config/foundry",
    "~/.local/share/foundry",
    "~/Library/Preferences/com.hridya.foundry.plist",
  ]
end
