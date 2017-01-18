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
                
                guard let allPimsInstalled = Akeneo.getAllPIMsInstalled() else {
                    
                }
                
               
                    let partition = ContainersUtils.partition(containers: runningContainers, folders: allPIMsInstalled)
                    
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
            itemTitle: container.description,
            subItems: [
                ("Open in browser", RunningOperation.openBrower(container: container)),
                ("Initialize", nil),
                ("Shutdown", nil)
            ]
        )
    }
    
    func addNotRunningContainer(container: String) {
        addSubMenuAndItems(
            subMenuTitle: "SubMenuNotRunning_\(container.description)",
            itemTitle: container,
            subItems: [("Boot", nil)]
        )
        notRunningContainers.append(container)
    }
    
    func addSubMenuAndItems(subMenuTitle: String, itemTitle: String, subItems: [(title: String, representedObject: Any?)])
    {
        statusMenu.addSubMenuAndItems(
            subMenuTitle: subMenuTitle,
            subItems: subItems,
            item: NSMenuItem(title: itemTitle, action: nil, keyEquivalent: NSString() as String),
            target: self,
            action: #selector(self.handleRunningOperation(_:))
        )
    }
    
    func handleRunningOperation(_ sender: NSMenuItem) {
        (sender.representedObject as! RunningOperation).process()
    }
}
