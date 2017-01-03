//
//  SettingsManager.swift
//  AkeneoMacApp
//
//  Created by Clément GARBAY on 03/01/2017.
//  Copyright © 2017 Ananas-Mac. All rights reserved.
//

import Cocoa

class SettingsManager {
    private static let appSettings = PlistManager().appSettings
    
    static func get(key: String) -> Any? {
        return self.appSettings?[key]
    }
}
