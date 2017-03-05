//
//  ConsoleManager.swift
//  AkeneoMacApp
//
//  Created by Anaël CHARDAN on 05/03/2017.
//  Copyright © 2017 Ananas-Mac. All rights reserved.
//

import Cocoa

class ConsoleManager: NSObject {
    static func runCommand(addText: @escaping (_ newText: String) -> Void, cmd : String, args : [String]? = nil) {
        
        var output : [String] = []
        var error : [String] = []
        
        let task = Process()
        task.launchPath = cmd
        task.arguments = args
        
        let pipe = Pipe()
        task.standardOutput = pipe
        
        let outHandle = pipe.fileHandleForReading
        outHandle.waitForDataInBackgroundAndNotify()
        
        outHandle.readabilityHandler = { pipe in
            if let line = String(data: pipe.availableData, encoding: String.Encoding.utf8) {
                addText(line)
            } else {
                print("Error decoding data: \(pipe.availableData)")
            }
        }
        
        task.launch()
        
        task.terminationHandler = { (process: Process) in
            if (process.isRunning) {
                print("IS RUNNNING")
            } else {
                print("FINISH MAGGLE")
            }
        }
    }
    
}
