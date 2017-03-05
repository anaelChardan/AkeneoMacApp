//
//  ClusterFactory.swift
//  AkeneoMacApp
//
//  Created by Ananas-Mac on 30/12/2016.
//  Copyright © 2016 Ananas-Mac. All rights reserved.
//

import Cocoa
import Dollar

//TODO ALL
class ClusterFactory: NSObject {
    static func createClusters(containers: [Container], allPimsInstalled: [String]) -> [PimEnvironmentCluster]
    {
        let clusterNotRunning: [PimEnvironmentCluster] = allPimsInstalled.filter({ (currentPath: String) -> Bool in
            return !containers.contains(where: { (runningContainer: Container) -> Bool in
                return runningContainer.pimFolder == currentPath
            })
        }).map { (element: String) -> PimEnvironmentCluster in
            PimEnvironmentCluster(folder: element, containersAkeneo: [], containersBehat: [])
        }
        
        if (containers.isEmpty) {
            return clusterNotRunning
        }
        
        let runningClusters: [PimEnvironmentCluster] = $.groupBy(containers) { (element: Container) -> String in
            element.getMainNetwork()!.components(separatedBy: "_")[0]
            }.values.map { (containers: [Container]) -> PimEnvironmentCluster in
                
                let akeneoContainers = containers.filter({ (container: Container) -> Bool in
                    return container.getMainNetwork()!.contains("akeneo")
                    
                })
                
                let behatContainers = containers.filter({ (container: Container) -> Bool in
                    return container.getMainNetwork()!.contains("behat")
                })
                
                return PimEnvironmentCluster(folder: self.getFolderByCluster(containers: containers), containersAkeneo: akeneoContainers, containersBehat: behatContainers)
        }
        
        
        
        return clusterNotRunning + runningClusters
        
    }
    
    private static func getFolderByCluster(containers: [Container]) -> String {
        let akeneoContainers = containers.filter { (container: Container) -> Bool in
            return container.pimFolder != nil
        }
        
        return akeneoContainers[0].pimFolder!
    }
}
