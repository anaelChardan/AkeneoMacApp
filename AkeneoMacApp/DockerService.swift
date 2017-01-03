//
//  DockerService.swift
//  AkeneoMacApp
//
//  Created by Ananas-Mac on 28/12/2016.
//  Copyright © 2016 Ananas-Mac. All rights reserved.
//

import Cocoa
import Alamofire
import AlamofireJsonToObjects
import EVReflection

class DockerService: NSObject {
    
    static func fetchContainers(success: (([Container]) -> ())? = nil) {
        reachDocker(endpoint: "containers/json", success: success)
    }
    
    static func reachDocker(endpoint: String, success: (([Container]) -> ())? = nil) {
        if let uri = buildURI() {
            Alamofire
                .request("\(uri)\(endpoint)")
                .validate()
                .responseArray { (response: DataResponse<[Container]>) in
                    if let containers = response.result.value {
                        success!(containers)
                    } else {
                        print("Your docker host is not reachable : You must launch docker and use socat to expose the port of docker")
                    }
            }
        }
    }
    
    private static func buildURI() -> String? {
        guard let url = SettingsManager.get(key: "dockerUrl") as? String else { return .none }
        guard let port = SettingsManager.get(key: "dockerPort") as? String else { return .none }
        
        return "\(url):\(port)/"
    }
}
