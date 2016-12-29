//
//  StatusMenuController.swift
//  AkeneoMacApp
//
//  Created by Ananas-Mac on 27/12/2016.
//  Copyright © 2016 Ananas-Mac. All rights reserved.
//

import Cocoa
import Alamofire

class StatusMenuController: NSObject {
    @IBOutlet weak var statusMenu: NSMenu!
    
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    override func awakeFromNib() {
        let icon = NSImage(named: "StatusBarButtonImage")
        statusItem.image = icon
        statusItem.menu = statusMenu
        addDynamicItems()
    }
    
    func addDynamicItems() {
        let titleItem = NSMenuItem(title: "Akeneo Mac", action: nil, keyEquivalent: NSString() as String)
        titleItem.attributedTitle = NSAttributedString(string: "Akeneo Mac", attributes: [NSFontAttributeName: NSFont.systemFont(ofSize: 20), NSForegroundColorAttributeName: NSColor.purple])
        statusMenu.insertItem(titleItem, at: 0)
        statusMenu.insertItem(NSMenuItem.separator(), at: 1)
        testInteractDocker()
    }
    
    
    
    func testInteractDocker() {
        Akeneo.doOnRunningAkeneoContainers(
            doOnRunningContainer : { (runningContainers: [Container]) in
                
                let partition = ContainersUtils.partition(containers: runningContainers, folders: Akeneo.getAllPIMsInstalled())
                
                self.addTitle(title: "Running PIMs", color: NSColor.green)
                
                partition.0.forEach({ (container: Container) in
                    self.statusMenu.addItem(NSMenuItem(title: container.description, action: nil, keyEquivalent: NSString() as String))
                })
                
                self.statusMenu.addItem(NSMenuItem.separator())
                self.addTitle(title: "Not running PIMs", color: NSColor.red)
                
                partition.1.forEach({ (container: String) in
                    self.statusMenu.addItem(NSMenuItem(title: container, action: nil, keyEquivalent: NSString() as String))
                })
                
                self.addQuitItem()
            }
        )
    }
    
    func addSeparator()
    {
        statusMenu.addItem(NSMenuItem.separator())
    }
    
    func addTitle(title: String, color: NSColor)
    {
        let item = NSMenuItem(title: title, action: nil, keyEquivalent: NSString() as String)
        item.attributedTitle = NSAttributedString(string: title, attributes: [NSFontAttributeName: NSFont.systemFont(ofSize: 18), NSForegroundColorAttributeName: color])
        statusMenu.addItem(item)
    }
    
    func addQuitItem()
    {
        addSeparator()
        statusMenu.addItem(NSMenuItem(title: "Quit Akeneo Mac", action: #selector(NSApplication.shared().terminate), keyEquivalent: "q"))
    }
}
