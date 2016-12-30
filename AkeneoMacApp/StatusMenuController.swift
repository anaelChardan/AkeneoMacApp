//
//  StatusMenuController.swift
//  AkeneoMacApp
//
//  Created by Ananas-Mac on 27/12/2016.
//  Copyright © 2016 Ananas-Mac. All rights reserved.
//

import Cocoa
import Alamofire



class StatusMenuController: NSObject, NSApplicationDelegate {
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
        
        statusMenu.addTitle(title: "Akeneo Mac", color: NSColor.purple, size: 20)
        statusMenu.addSeparator()
        
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
                
                self.statusMenu.addTitle(title: "Running PIMs", color: NSColor.green)
                
                partition.0.forEach({ (container: Container) in
                    self.addRunningItem(container: container)
                })
                
                self.statusMenu.addSeparator()
                self.statusMenu.addTitle(title: "Not running PIMs", color: NSColor.red)
                
                partition.1.forEach({ (container: String) in
                    self.addNotRunningContainer(container: container)
                })
                
                self.statusMenu.addQuitItem()
            }
        )
    }
    
    func addRunningItem(container: Container) {
        addSubMenuAndItems(
            subMenuTitle: "SubMenuRunning_\(container.description)",
            subItems: [
                ("Open in browser", RunningOperation.openBrower(container: container)),
                ("Initialize", nil),
                ("Shutdown", nil)
            ],
            item: NSMenuItem(title: container.description, action: nil, keyEquivalent: NSString() as String)
        )
        runningContainers[container.description] = container
    }
    
    func addNotRunningContainer(container: String) {
        addSubMenuAndItems(
            subMenuTitle: "SubMenuNotRunning_\(container.description)",
            subItems: [("Boot", nil)],
            item: NSMenuItem(title: container, action: nil, keyEquivalent: NSString() as String)
        )
        notRunningContainers.append(container)
    }
    
    func addSubMenuAndItems(subMenuTitle: String, subItems: [(title: String, representedObject: Any?)], item: NSMenuItem) {
        let subMenu = NSMenu(title: subMenuTitle)
        
        subItems.forEach { (title: String, representedObject: Any?) in
            let subMenuItem = NSMenuItem()
            subMenuItem.representedObject = representedObject
            subMenuItem.title = title
            subMenuItem.target = self
            subMenuItem.action = #selector(self.handleRunningOperation(_:))
            subMenu.addItem(subMenuItem)
        }
        
        item.submenu = subMenu
        statusMenu.addItem(item)
    }
    
    func handleRunningOperation(_ sender: NSMenuItem) {
        (sender.representedObject as! RunningOperation).process()
    }
}
