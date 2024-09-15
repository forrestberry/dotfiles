// SetDefaultBrowserToChrome.swift

import Foundation

let chromeBundleID = "com.google.Chrome"

setDefaultBrowser(to: chromeBundleID)

func setDefaultBrowser(to bundleID: String) {
    let httpFlag = URL(string: "http:")! as CFURL
    guard let urls = LSCopyApplicationURLsForURL(httpFlag, .all)?.takeRetainedValue() as? [URL],
          let _ = urls.first(where: { Bundle(url: $0)?.bundleIdentifier == bundleID }) else {
        print("Chrome is not installed or couldn't be found.")
        exit(EXIT_FAILURE)
    }

    LSSetDefaultHandlerForURLScheme("http" as CFString, bundleID as CFString)
    LSSetDefaultHandlerForURLScheme("https" as CFString, bundleID as CFString)
    print("Chrome is now set as the default browser.")
}

