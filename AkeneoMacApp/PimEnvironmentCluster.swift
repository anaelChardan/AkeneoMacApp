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
            operations.append(("PIM Initialize", ClusterOperation.pimInitialize(cluster: self)))
        }
        
        if (!containersBehatNetwork.isEmpty) {
            operations.append(("Open behat in browser", ClusterOperation.openBehatBrowser(cluster: self)))
            operations.append(("Pim Initialize (Behat)", ClusterOperation.pimInitializeBehat(cluster: self)))
        }
        
        operations.append(("Shutdown", ClusterOperation.shutdown(cluster: self)))

        return operations
    }
    
    func boot() {
        let path = self.getDockerComposeFilePath()
        DockerConsoleService.dockerComposeExecUpDaemon(path: path, addText: {
            (line: String) in
            print(line)
        })
    }
    
    func shutdown() {
        let path = self.getDockerComposeFilePath()
        DockerConsoleService.dockerComposeExecStop(path: path, addText: {
            (line: String) in
            print(line)
        })
    }
    
    func open() {
        let akeneoContainer = getAkeneoContainer()
        
        NSWorkspace.shared().open(URL(string: "http://localhost:\(akeneoContainer.getPublicPort(privatePort: 80)!)")!)
    }
    
    func openBehat() {
        let akeneoContainer = getAkeneoBehatContainer()
        
        NSWorkspace.shared().open(URL(string: "http://localhost:\(akeneoContainer.getPublicPort(privatePort: 80)!)")!)
    }
    
    func initialize() {
        let akeneoContainer = getAkeneoContainer()
        DockerConsoleService.dockerExec(containerId: akeneoContainer.id!, command: "pim-initialize", addText: {
            (line: String) in
                print(line)
        })
    }
    
    func initializeBehat() {
        let akeneoContainer = getAkeneoBehatContainer()
        
        DockerConsoleService.dockerExec(containerId: akeneoContainer.id!, command: "pim-initialize", addText: {
            (line: String) in
            print(line)
        })
    }
    
    private func getAkeneoContainer() -> Container {
        return containersAkeneoNetwork.filter { (container: Container) -> Bool in
            return container.image!.contains(SettingsManager.get(key: "akeneoContainsImage")! as! String)
            }[0]
    }
    
    private func getAkeneoBehatContainer() -> Container {
        return containersBehatNetwork.filter { (container: Container) -> Bool in
            return container.image!.contains(SettingsManager.get(key: "akeneoContainsImage")! as! String)
            }[0]
    }
    
    private func getDockerComposeFilePath() -> String {
        return "\(self.getFullPath())/\(SettingsManager.get(key: "dockerComposeFile")!)"
    }
    
    private func getFullPath() -> String {
        return "\(SettingsManager.get(key: "akeneoPimsPath")!)/\(self.folder)"
    }
}
