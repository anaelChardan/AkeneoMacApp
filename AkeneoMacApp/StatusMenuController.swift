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
        addSubMenuAndItems(
            subMenuTitle: "SubMenuRunning_\(container.description)",
            subItems: ["Open in browser": nil, "Initialize": nil, "Shutdown": nil],
            item: NSMenuItem(title: container.description, action: nil, keyEquivalent: NSString() as String)
        )
        runningContainers[container.description] = container
    }
    
    func addNotRunningContainer(container: String) {
        addSubMenuAndItems(
            subMenuTitle: "SubMenuNotRunning_\(container.description)",
            subItems: ["Boot" : nil],
            item: NSMenuItem(title: container, action: nil, keyEquivalent: NSString() as String)
        )
        notRunningContainers.append(container)
    }
    
    func addSubMenuAndItems(subMenuTitle: String, subItems: [String: Selector?], item: NSMenuItem) {
        let subMenu = NSMenu(title: subMenuTitle)
        
        subItems.forEach { (key: String, value: Selector?) in
            subMenu.addItem(NSMenuItem(title: key, action: value, keyEquivalent: NSString() as String))
        }
        
        item.submenu = subMenu
        statusMenu.addItem(item)
    }
    
    func addQuitItem()
    {
        addSeparator()
        statusMenu.addItem(NSMenuItem(title: "Quit Akeneo Mac", action: #selector(NSApplication.shared().terminate), keyEquivalent: "q"))
    }
}
