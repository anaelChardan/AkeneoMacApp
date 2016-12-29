//
//  ContainersUtils.swift
//  AkeneoMacApp
//
//  Created by Ananas-Mac on 29/12/2016.
//  Copyright © 2016 Ananas-Mac. All rights reserved.
//

import Cocoa

class ContainersUtils: NSObject {

    static func partition(containers: [Container], folders: [String]) -> (containersRunning: [Container], containersNotRunning: [String])
    {
        let containerNotRunning = folders.filter({ (currentPath: String) -> Bool in
            return !containers.contains(where: { (runningContainer: Container) -> Bool in
                return runningContainer.getTerminalFolder() == currentPath
            })
        })
        
        return (containers, containerNotRunning)
    }
}
