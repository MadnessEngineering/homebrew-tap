cask "madness-desktop" do
  version "0.1.4"
  sha256 "a346fbb940124118ff5c728f00c135aa056761a5198ac14c3192ca7c0b6006b3"

  url "https://github.com/MadnessEngineering/madnessDesktop/releases/download/v#{version}/MadnessDesktop-#{version}-darwin-arm64.zip"
  name "Madness Desktop"
  desc "GitHub Desktop fork with hook loadouts, submodule tooling and MQTT"
  homepage "https://github.com/MadnessEngineering/madnessDesktop"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Madness Desktop.app"
  binary "#{appdir}/Madness Desktop.app/Contents/Resources/app/static/madhub.sh", target: "madhub"

  zap trash: [
    "~/Library/Application Support/Madness Desktop",
    "~/Library/Caches/cc.madnessinteractive.MadnessDesktop",
    "~/Library/Caches/cc.madnessinteractive.MadnessDesktop.ShipIt",
    "~/Library/Logs/Madness Desktop",
    "~/Library/Preferences/cc.madnessinteractive.MadnessDesktop.plist",
  ]

  caveats <<~EOS
    Madness Desktop is not signed or notarized, so macOS blocks the first launch.
    Either clear the quarantine flag:

      xattr -dr com.apple.quarantine "#{appdir}/Madness Desktop.app"

    or try to open it once, then go to System Settings -> Privacy & Security
    and click "Open Anyway".

    Update with `brew upgrade --cask madness-desktop`, not `madhub upgrade`:
    madhub swaps the app behind Homebrew's back.
  EOS
end
