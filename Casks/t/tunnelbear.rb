cask "tunnelbear" do
  on_catalina :or_older do
    version "4.1.8"
    sha256 "60c332511b91b794405249132ceb0c88e999b070c087b5f70f1cf09a84e5e5e9"

    livecheck do
      skip "Legacy version"
    end

    depends_on macos: ">= :sierra"
  end
  on_big_sur :or_newer do
    version "5.3.0"
    sha256 "0007bf00e55e9fd517a52a1127943ebef02d62423845707108923d1345a6760d"

    # Older versions may have a more recent `pubDate` than newer versions, so we
    # have to check all the items in the appcast.
    livecheck do
      url "https://s3.amazonaws.com/tunnelbear/downloads/mac/appcast.xml"
      strategy :sparkle do |items|
        items.map(&:short_version)
      end
    end

    depends_on macos: ">= :big_sur"
  end

  url "https://s3.amazonaws.com/tunnelbear/downloads/mac/TunnelBear-#{version}.zip",
      verified: "s3.amazonaws.com/tunnelbear/downloads/mac/"
  name "TunnelBear"
  desc "VPN client for secure internet access and private browsing"
  homepage "https://www.tunnelbear.com/"

  auto_updates true

  app "TunnelBear.app"

  uninstall launchctl: "com.tunnelbear.mac.tbeard",
            quit:      "com.tunnelbear.mac.TunnelBear",
            delete:    "/Library/PrivilegedHelperTools/com.tunnelbear.mac.tbeard"

  zap trash: [
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.tunnelbear.mac.tunnelbear.sfl*",
    "~/Library/Application Support/com.tunnelbear.mac.TunnelBear",
    "~/Library/Application Support/TunnelBear",
    "~/Library/Caches/com.crashlytics.data/com.tunnelbear.mac.TunnelBear",
    "~/Library/Caches/com.plausiblelabs.crashreporter.data/com.tunnelbear.mac.TunnelBear",
    "~/Library/Caches/com.tunnelbear.*",
    "~/Library/Caches/io.fabric.sdk.mac.data/com.tunnelbear.mac.TunnelBear",
    "~/Library/Cookies/com.tunnelbear.mac.TunnelBear.binarycookies",
    "~/Library/HTTPStorages/com.tunnelbear.mac.TunnelBear",
    "~/Library/LaunchAgents/com.tunnelbear.mac.tbeara.plist",
    "~/Library/Logs/TunnelBear",
    "~/Library/Preferences/*.tunnelbear*.plist",
    "~/Library/WebKit/com.tunnelbear.mac.TunnelBear",
  ]
end
