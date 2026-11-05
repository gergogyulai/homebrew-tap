cask "berth" do
  version "1.1.0"
  sha256 "a70bf6d327ce02921ff2714c6613764f2f620631d6c5664fee6a0438c202e528"

  url "https://github.com/gergogyulai/berth/releases/download/v#{version}/Berth-#{version}.zip"
  name "Berth"
  desc "Menu bar app that keeps SMB shares mounted, at home and over Tailscale"
  homepage "https://github.com/gergogyulai/berth"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :tahoe

  app "Berth.app"
  binary "#{appdir}/Berth.app/Contents/Helpers/berth"

  # The app isn't notarized (no paid Apple developer account). Without this, Gatekeeper blocks the first
  # launch and the user has to allow it in System Settings → Privacy & Security.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Berth.app"],
        writable_paths: ["Berth.app"],
        writable_base:  :appdir
  end

  uninstall quit:       "app.berth.Berth",
            login_item: "Berth"

  zap trash: [
    "~/Library/Application Support/Berth",
    "~/Library/Preferences/app.berth.Berth.plist",
  ]
end
