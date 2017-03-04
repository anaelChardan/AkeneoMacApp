//
//  Akeneo.swift
//  AkeneoMacApp
//
//  Created by Ananas-Mac on 28/12/2016.
//  Copyright © 2016 Ananas-Mac. All rights reserved.
//

import Cocoa

class Akeneo: NSObject {
    static func doOnAkeneoRelatedContainers(doOnRunningContainer: @escaping (([Container]) -> ())) {
        DockerService.fetchContainers(
            success: { containers in
                if let akeneoWorkingContainer = filterAkeneoWorkingContainer(containers: containers) {
                    doOnRunningContainer(akeneoWorkingContainer)
                }
            }
        )
    }
    
    static func getAllPIMsInstalled() -> [String]? {
        guard let akeneoPimsPath = SettingsManager.get(key: "akeneoPimsPath") as? String else { return .none }
        
        var fileList = try! FileManager.default.contentsOfDirectory(atPath: akeneoPimsPath)
        
        return fileList.remove(object: ".DS_Store")
    }
    
    
    private static func filterAkeneoWorkingContainer(containers: [Container]) -> [Container]? {
        return containers.filter({ (container: Container) in
            return container.networkSettings!.networks.exists(condition: { (element: ContainerNetwork) -> Bool in
                return element.name!.hasSuffix("akeneo") || element.name!.hasSuffix("behat")
            })
        })
    }
}
