//
//  DockerService.swift
//  AkeneoMacApp
//
//  Created by Ananas-Mac on 28/12/2016.
//  Copyright © 2016 Ananas-Mac. All rights reserved.
//

import Cocoa
import Alamofire

class DockerService: NSObject {
    private static let BASE_URL = "http://localhost"
    
    //TODO: Must be parametrable
    private static let PORT = "2375"
    
    static func fetchContainers(success: (([Container]) -> ())? = nil) {
        reachDocker(endpoint: "containers/json", success: success)
    }
    
    static func reachDocker(endpoint: String, success: (([Container]) -> ())? = nil) {
        Alamofire
            .request("\(self.buildURI())\(endpoint)")
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    success!(((response.result.value as! NSArray) as! [[String: AnyObject]]).map { value in Container(container: value) })
                case .failure(let error):
                    print("Your docker host is not reachable : You must launch docker and use socat to expose the port of docker \(error)")
                }
        }

    }
    
    private static func buildURI() -> String {
        return "\(self.BASE_URL):\(self.PORT)/"
    }
}
