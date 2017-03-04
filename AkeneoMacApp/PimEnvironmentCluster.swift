import Cocoa

class PimEnvironmentCluster: NSObject {
    var folder: String = ""
    var containersBehatNetwork: [Container] = []
    var containersAkeneoNetwork: [Container] = []
    
    init(folder: String, containersAkeneo: [Container], containersBehat: [Container]) {
        self.folder = folder
        self.containersAkeneoNetwork = containersAkeneo
        self.containersBehatNetwork = containersBehat
    }
    
    func isRunning() -> Bool {
        return !containersAkeneoNetwork.isEmpty || !containersBehatNetwork.isEmpty
    }
    
    func getOperations() -> [(title: String, representedObject: Any?)] {
        if (!isRunning()) {
            return [("Boot", ClusterOperation.boot(cluster: self))]
        }
        
        var operations: [(String, Any?)] = []
        
        if (!containersAkeneoNetwork.isEmpty) {
            operations.append(("Open in Browser", ClusterOperation.openInBrowser(cluster: self)))
        }
        
        if (!containersBehatNetwork.isEmpty) {
            operations.append(("Open behat in browser", ClusterOperation.openBehatBrowser(cluster: self)))
        }
        
        return operations
    }
    
    func boot() {
        print("BOOT");
    }
    
    func open() {
        let akeneoContainer = getAkeneoContainer()
        
        NSWorkspace.shared().open(URL(string: "http://localhost:\(akeneoContainer.getPublicPort(privatePort: 80)!)")!)
    }
    
    func getAkeneoContainer() -> Container {
        return containersAkeneoNetwork.filter { (container: Container) -> Bool in
            return container.image!.contains(SettingsManager.get(key: "akeneoContainsImage")! as! String)
        }[0]
    }
    
    func openBehat() {
//        self.container.getMainNetwork()
    }
    
    func initialize() {
        print("initalize")
    }
    
    func initializeBehat() {
        print("initalize behat")
    }
    
    func shutdown() {
        print("shutdown")
    }

    
    
}
