//
//  Akeneo.swift
//  AkeneoMacApp
//
//  Created by Ananas-Mac on 28/12/2016.
//  Copyright © 2016 Ananas-Mac. All rights reserved.
//

import Cocoa

class Akeneo: NSObject {
    //TODO: Must be parametrable
    private static let akeneoPimsPath = "/Users/clementgarbay/dev/Akeneo/PIM/installed_pims"
    private static let akeneoMobyVMPath = "/Workspace/Akeneo/PIM/installed_pims"
    private static let akeneoContainsImage = "carcel/akeneo"
    private static let akeneoDoesNotContainsImage = "behat"
     
    static func doOnRunningAkeneoContainers(doOnRunningContainer: @escaping (([Container]) -> ())) {
        DockerService.fetchContainers(
            success: { containers in
                doOnRunningContainer(self.filterAkeneoWorkingContainer(containers: containers))
            }
        )
    }
    
    static func getAllPIMsInstalled() -> [String]
    {
        var fileList = try! FileManager.default.contentsOfDirectory(atPath: self.akeneoPimsPath)
        
        return fileList.remove(object: ".DS_Store")
    }
    
    
    static func filterAkeneoWorkingContainer(containers: [Container]) -> [Container]
    {
        return containers.filter({ (container: Container) in
            return container.image!.hasPrefix(self.akeneoContainsImage) && !container.image!.contains(self.akeneoDoesNotContainsImage)
        })
    }
}
