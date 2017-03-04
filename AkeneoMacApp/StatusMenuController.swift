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
        Akeneo.doOnAkeneoRelatedContainers(
            doOnRunningContainer : { (runningContainers: [Container]) in
                
                guard let allPimsInstalled = Akeneo.getAllPIMsInstalled() else {
                    return
                }
                
                let clusters: [PimEnvironmentCluster] = ClusterFactory.createClusters(containers: runningContainers, allPimsInstalled: allPimsInstalled)
                
                self.statusMenu.addTitle(title: "Running PIMs", color: NSColor.green)
                
                clusters.filter({ (cluster: PimEnvironmentCluster) -> Bool in
                    return cluster.isRunning()
                }).forEach({ (cluster: PimEnvironmentCluster) in
                    self.addRunningItem(cluster: cluster)
                })
                    
                self.statusMenu.addSeparator()
                self.statusMenu.addTitle(title: "Not running PIMs", color: NSColor.red)
                    
                clusters.filter({ (cluster: PimEnvironmentCluster) -> Bool in
                    return !cluster.isRunning()
                }).forEach({ (cluster: PimEnvironmentCluster) in
                    self.addNotRunningItem(cluster: cluster)
                })
                    
                self.statusMenu.addQuitItem()
            }
        )
    }
    
    func addRunningItem(cluster: PimEnvironmentCluster) {
        addSubMenuAndItems(
            subMenuTitle: "SubMenuRunning_\(cluster.folder)",
            cluster: cluster
        )
    }
    
    func addNotRunningItem(cluster: PimEnvironmentCluster) {
        addSubMenuAndItems(
            subMenuTitle: "SubMenuNotRunning_\(cluster.folder)",
            cluster: cluster
        )
    }
    
    func addSubMenuAndItems(subMenuTitle: String, cluster: PimEnvironmentCluster)
    {
        statusMenu.addSubMenuAndItems(
            subMenuTitle: subMenuTitle,
            subItems: cluster.getOperations(),
            item: NSMenuItem(title: cluster.folder, action: nil, keyEquivalent: NSString() as String),
            target: self,
            action: #selector(self.handleRunningOperation(_:))
        )
    }
    
    func handleRunningOperation(_ sender: NSMenuItem) {
        (sender.representedObject as! ClusterOperation).process()
    }
}
