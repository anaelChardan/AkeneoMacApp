//
//  StatusMenuController.swift
//  AkeneoMacApp
//
//  Created by Ananas-Mac on 27/12/2016.
//  Copyright © 2016 Ananas-Mac. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {
    @IBOutlet weak var statusMenu: NSMenu!
    
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    override func awakeFromNib() {
        let icon = NSImage(named: "StatusBarButtonImage")
        statusItem.image = icon
        statusItem.menu = statusMenu
        addDynamicItems()
    }
    
    @IBAction func quitClicked(sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }
    
    func addDynamicItems() {
        let titleItem = NSMenuItem(title: "Akeneo Mac", action: nil, keyEquivalent: NSString() as String)
        titleItem.attributedTitle = NSAttributedString(string: "Akeneo Mac", attributes: [NSFontAttributeName: NSFont.systemFont(ofSize: 20), NSForegroundColorAttributeName: NSColor.purple])
        statusMenu.insertItem(titleItem, at: 0)
        statusMenu.insertItem(NSMenuItem.separator(), at: 1)
        statusMenu.insertItem(NSMenuItem(title: "Test", action: nil, keyEquivalent: NSString() as String), at: 2)
    }
}
