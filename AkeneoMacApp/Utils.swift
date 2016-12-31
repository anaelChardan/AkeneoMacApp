//
//  Utils.swift
//  AkeneoMacApp
//
//  Created by Ananas-Mac on 29/12/2016.
//  Copyright © 2016 Ananas-Mac. All rights reserved.
//

import Cocoa

extension Array where Element: Equatable {
    mutating func remove(object: Element) -> Array {
        if let index = index(of: object) {
            remove(at: index)
        }
        
        return self
    }
}

extension Dictionary where Key: ExpressibleByStringLiteral, Value: AnyObject {
    func toStringString() -> [String: String]
    {
        var returnValue: [String: String] = [:]
        
        for (n, l) in self {
            let key = n as! String
            returnValue[key] = l is NSNull ? "" : String(describing: l)
        }
        
        return returnValue
    }
}

extension Sequence where Iterator.Element == [String:AnyObject] {
    func toStringStringElementArray() -> [[String: String]] {
        return self.map { value in return value.toStringString() }
    }
}

extension NSMenu {
    func addSeparator() {
        self.addItem(NSMenuItem.separator())
    }
    
    func addTitle(title: String, color: NSColor, size: Int = 15, image: NSImage? = nil) {
        let item = NSMenuItem(title: title, action: nil, keyEquivalent: NSString() as String)
        item.attributedTitle = NSAttributedString(string: title, attributes: [NSFontAttributeName: NSFont.systemFont(ofSize: CGFloat(size)), NSForegroundColorAttributeName: color])
        
        if let data = image {
            item.image = data
        }
        
        self.addItem(item)
    }
    
    func addSubMenuAndItems(subMenuTitle: String, subItems: [(title: String, representedObject: Any?)], item: NSMenuItem, target: AnyObject?, action: Selector?) {
        let subMenu = NSMenu(title: subMenuTitle)
        
        subItems.forEach { (title: String, representedObject: Any?) in
            let subMenuItem = NSMenuItem()
            subMenuItem.representedObject = representedObject
            subMenuItem.title = title
            subMenuItem.target = target
            subMenuItem.action = action
            subMenu.addItem(subMenuItem)
        }
        
        item.submenu = subMenu
        self.addItem(item)
    }

    
    func addQuitItem() {
        self.addSeparator()
        self.addItem(NSMenuItem(title: "Quit Akeneo Mac", action: #selector(NSApplication.shared().terminate), keyEquivalent: "q"))
    }
}

extension String {
    func lastPartAfter(separatedBy: String) -> String? {
        return self.components(separatedBy: separatedBy).last
    }
}
