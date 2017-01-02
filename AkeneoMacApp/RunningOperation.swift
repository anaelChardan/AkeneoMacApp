//
//  RunningOperation.swift
//  AkeneoMacApp
//
//  Created by Ananas-Mac on 29/12/2016.
//  Copyright © 2016 Ananas-Mac. All rights reserved.
//

import Foundation

enum RunningOperation {
    case openBrower(container: Container)
    
    //TODO To do that, must create a cluster containing the behat container (so by folder)
    case openBehatBrowser(container: Container)
    
    func process() {
        switch self {
            case let .openBrower(container):
                AkeneoContainer(container: container).open()
        case let .openBehatBrowser(container):
                AkeneoContainer(container: container).openBehat()
            
        }
    }
}
