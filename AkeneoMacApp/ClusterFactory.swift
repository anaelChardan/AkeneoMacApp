//
//  ClusterFactory.swift
//  AkeneoMacApp
//
//  Created by Ananas-Mac on 30/12/2016.
//  Copyright © 2016 Ananas-Mac. All rights reserved.
//

import Cocoa

//TODO ALL
class ClusterFactory: NSObject {
    func createCluster(networkName: String) -> DockerComposeCluster
    {
        return DockerComposeCluster()
    }
    
    func createCluster(terminalFolderName: String) -> DockerComposeCluster
    {
        return DockerComposeCluster()
    }
}
