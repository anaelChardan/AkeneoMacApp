//
//  PlistManager.swift
//  AkeneoMacApp
//
//  Created by Clément GARBAY on 03/01/2017.
//  Copyright © 2017 Ananas-Mac. All rights reserved.
//

import Cocoa

class PlistManager {
    
    let SETTING_PATH = "Settings"
    
    var appSettings: [String: Any]? {
        return self.loadDataFromPlist(fileName: SETTING_PATH)
    }
    
    private func loadDataFromPlist(fileName: String) -> [String: Any]? {
        if let path = Bundle.main.path(forResource: fileName, ofType: "plist") {
            return NSDictionary(contentsOfFile: path) as? [String: Any]
        } else {
            print("\(fileName) file not found.")
            return .none
        }
    }
}
