// SetDefaultBrowserToSafari.swift

import Foundation

let safariBundleID = "com.apple.Safari"

setDefaultBrowser(to: safariBundleID)

func setDefaultBrowser(to bundleID: String) {
    let httpFlag = URL(string: "http:")! as CFURL
    guard let urls = LSCopyApplicationURLsForURL(httpFlag, .all)?.takeRetainedValue() as? [URL],
          let _ = urls.first(where: { Bundle(url: $0)?.bundleIdentifier == bundleID }) else {
        print("Safari is not installed or couldn't be found.")
        exit(EXIT_FAILURE)
    }

    LSSetDefaultHandlerForURLScheme("http" as CFString, bundleID as CFString)
    LSSetDefaultHandlerForURLScheme("https" as CFString, bundleID as CFString)
    print("Safari is now set as the default browser.")
}

