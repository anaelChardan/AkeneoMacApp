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
    
    var runningContainers: [String: Container] = [:]
    var notRunningContainers: [String] = []
    
    override func awakeFromNib() {
        let icon = NSImage(named: "StatusBarButtonImage")
        statusItem.image = icon
        statusItem.menu = statusMenu
        
        fillMenu()
    }
    
    func fillMenu() {
        clear()
        
        addTitle(title: "Akeneo Mac", color: NSColor.purple, size: 20)
        addSeparator()
        
        analysePIMs()
    }
    
    
    func clear() {
        statusMenu.removeAllItems()
        runningContainers.removeAll()
        notRunningContainers.removeAll()
    }
    
    
    func analysePIMs() {
        Akeneo.doOnRunningAkeneoContainers(
            doOnRunningContainer : { (runningContainers: [Container]) in
                
                let partition = ContainersUtils.partition(containers: runningContainers, folders: Akeneo.getAllPIMsInstalled())
                
                self.addTitle(title: "Running PIMs", color: NSColor.green)
                
                partition.0.forEach({ (container: Container) in
                    self.addRunningItem(container: container)
                })
                
                self.statusMenu.addItem(NSMenuItem.separator())
                self.addTitle(title: "Not running PIMs", color: NSColor.red)
                
                partition.1.forEach({ (container: String) in
                    self.addNotRunningContainer(container: container)
                })
                
                self.addQuitItem()
            }
        )
    }
    
    func addSeparator()
    {
        statusMenu.addItem(NSMenuItem.separator())
    }
    
    func addTitle(title: String, color: NSColor, size: Int = 15)
    {
        let item = NSMenuItem(title: title, action: nil, keyEquivalent: NSString() as String)
        item.attributedTitle = NSAttributedString(string: title, attributes: [NSFontAttributeName: NSFont.systemFont(ofSize: CGFloat(size)), NSForegroundColorAttributeName: color])
        
        statusMenu.addItem(item)
    }
    
    func addRunningItem(container: Container) {
        let subMenu = NSMenu(title: "SubMenuRunning_\(container.description)")
        
        subMenu.addItem(NSMenuItem(title: "Open in browser", action: nil, keyEquivalent: NSString() as String))
        subMenu.addItem(NSMenuItem(title: "Initialize", action: nil, keyEquivalent: NSString() as String))
        subMenu.addItem(NSMenuItem(title: "Shutdown", action: nil, keyEquivalent: NSString() as String))
        
        let item = NSMenuItem(title: container.description, action: nil, keyEquivalent: NSString() as String)
        
        item.submenu = subMenu
        statusMenu.addItem(item)
        runningContainers[container.description] = container
    }
    
    func addNotRunningContainer(container: String) {
        let subMenu = NSMenu(title: "SubMenuNotRunning_\(container.description)")
        
        subMenu.addItem(NSMenuItem(title: "Boot", action: nil, keyEquivalent: NSString() as String))
        
        let item = NSMenuItem(title: container, action: nil, keyEquivalent: NSString() as String)
        
        item.submenu = subMenu
        statusMenu.addItem(item)
        notRunningContainers.append(container)
    }
    
    func addQuitItem()
    {
        addSeparator()
        statusMenu.addItem(NSMenuItem(title: "Quit Akeneo Mac", action: #selector(NSApplication.shared().terminate), keyEquivalent: "q"))
    }
}
