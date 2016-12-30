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
    
    func addTitle(title: String, color: NSColor, size: Int = 15) {
        let item = NSMenuItem(title: title, action: nil, keyEquivalent: NSString() as String)
        item.attributedTitle = NSAttributedString(string: title, attributes: [NSFontAttributeName: NSFont.systemFont(ofSize: CGFloat(size)), NSForegroundColorAttributeName: color])
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
