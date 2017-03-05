//
//  RunningOperation.swift
//  AkeneoMacApp
//
//  Created by Ananas-Mac on 29/12/2016.
//  Copyright © 2016 Ananas-Mac. All rights reserved.
//

import Foundation

enum ClusterOperation {
    case openInBrowser(cluster: PimEnvironmentCluster)
    
    //TODO To do that, must create a cluster containing the behat container (so by folder)
    case openBehatBrowser(cluster: PimEnvironmentCluster)
    
    case pimInitialize(cluster: PimEnvironmentCluster)
    
    case pimInitializeBehat(cluster: PimEnvironmentCluster)
    
    case boot(cluster: PimEnvironmentCluster)
    
    case shutdown(cluster: PimEnvironmentCluster)
    
    func process() {
        switch self {
            case let .openInBrowser(cluster):
                cluster.open()
            case let .openBehatBrowser(cluster):
                cluster.openBehat()
            case let .boot(cluster):
                cluster.boot()
            case let .pimInitialize(cluster):
                cluster.initialize()
            case let .shutdown(cluster):
                cluster.shutdown()
            case let.pimInitializeBehat(cluster):
                cluster.initializeBehat()
        }
    }
}
