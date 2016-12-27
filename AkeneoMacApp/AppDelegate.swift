//
//  AppDelegate.swift
//  AkeneoMacApp
//
//  Created by Ananas-Mac on 27/12/2016.
//  Copyright © 2016 Ananas-Mac. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var statusMenu: NSMenu!
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let icon = NSImage(named: "StatusBarButtonImage")
        statusItem.image = icon
        statusItem.menu = statusMenu
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        statusItem.menu = statusMenu
    }
}

