//
//  VersionName.swift
//  ChantLouange
//
//  Created by DAVID KAZAD on 9/23/25.
//

import Foundation

extension Bundle {
    var versionNumber: String {
        infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    }
    var buildNumber: String {
        infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"
    }
}
