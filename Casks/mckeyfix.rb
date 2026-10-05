cask "mckeyfix" do
  version "1.0.1"
  sha256 "c443f7a02c857af9d8b1de5984cd977ab410c2ecffa01f0e84f301b22603a314"

  url "https://github.com/gergogyulai/mckeyfix/releases/download/v#{version}/MCKeyFix-#{version}.zip"
  name "MCKeyFix"
  desc "Menu bar app that makes the MacBook keyboard behave in Minecraft"
  homepage "https://github.com/gergogyulai/mckeyfix"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :big_sur

  app "MCKeyFix.app"

  # The app isn't notarized (no paid Apple developer account). Without this, Gatekeeper blocks the first
  # launch and the user has to allow it in System Settings → Privacy & Security.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/MCKeyFix.app"],
        writable_paths: ["MCKeyFix.app"],
        writable_base:  :appdir
  end

  uninstall quit:       "dev.mckeyfix.app",
            login_item: "MCKeyFix"

  zap trash: "~/Library/Application Support/MCKeyFix"
end
