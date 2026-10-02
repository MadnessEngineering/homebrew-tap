cask "madness-desktop" do
  version "0.1.6"
  sha256 "e970c58940caebcfe45a05bb6aca4c7067c236ed7070ed4f18f7f9163efe86bf"

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

  # The app is ad-hoc signed, not notarized. With the quarantine flag set,
  # Gatekeeper's "Not Opened" dialog defaults to "Move to Trash", which deletes
  # the app and leaves the madhub link dangling. Strip the flag so it just opens.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Madness Desktop.app"],
        writable_paths: ["Madness Desktop.app"],
        writable_base:  :appdir
  end

  zap trash: [
    "~/Library/Application Support/Madness Desktop",
    "~/Library/Caches/cc.madnessinteractive.MadnessDesktop",
    "~/Library/Caches/cc.madnessinteractive.MadnessDesktop.ShipIt",
    "~/Library/Logs/Madness Desktop",
    "~/Library/Preferences/cc.madnessinteractive.MadnessDesktop.plist",
  ]

  caveats <<~EOS
    Madness Desktop is not notarized. This cask clears its quarantine flag on
    install so macOS opens it without a warning. If you still see "Not Opened",
    click Done (NOT "Move to Trash") and run:

      xattr -dr com.apple.quarantine "#{appdir}/Madness Desktop.app"

    Update with `brew upgrade --cask madness-desktop`, not `madhub upgrade`:
    madhub swaps the app behind Homebrew's back.
  EOS
end
