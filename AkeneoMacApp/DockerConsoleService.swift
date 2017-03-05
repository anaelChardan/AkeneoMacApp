//
//  DockerConsoleService.swift
//  AkeneoMacApp
//
//  Created by Anaël CHARDAN on 05/03/2017.
//  Copyright © 2017 Ananas-Mac. All rights reserved.
//

import Cocoa

class DockerConsoleService: NSObject {
    static func dockerExec(containerId: String, command: String, addText: @escaping (_ text: String) -> ()) {
        var args = ["exec"]
        args.append(containerId)
        args.append(command)
        ConsoleManager.runCommand(addText: addText, cmd: "/usr/local/bin/docker", args: args)
    }
    
    static func dockerComposeExecUpDaemon(path: String, addText: @escaping (_ text: String) -> ()) {
        var args = ["-f"]
        args.append(path)
        args.append("up")
        args.append("-d")
        ConsoleManager.runCommand(addText: addText, cmd: "/usr/local/bin/docker-compose", args: args)
    }
    
    static func dockerComposeExecStop(path: String, addText: @escaping (_ text: String) -> ()) {
        var args = ["-f"]
        args.append(path)
        args.append("stop")
        ConsoleManager.runCommand(addText: addText, cmd: "/usr/local/bin/docker-compose", args: args)
    }

}
