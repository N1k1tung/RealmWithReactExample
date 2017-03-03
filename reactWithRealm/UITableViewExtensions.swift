//
//  UITableViewExtensions.swift
//  reactWithRealm
//
//  Created by Nikita Rodin on 3/3/17.
//  Copyright © 2017 Nikita Rodin. All rights reserved.
//

import UIKit

/**
 * Shortcut methods for UITableView
 *
 * - author: Nikita Rodin
 * - version: 1.0
 */
extension UITableView {
    
    /**
     Get cell of given class for indexPath
     
     - parameter indexPath: the indexPath
     - parameter cellClass: a cell class
     
     - returns: a reusable cell
     */
    func getCell<T: UITableViewCell>(_ indexPath: IndexPath, ofClass cellClass: T.Type) -> T {
        let className = String(describing: cellClass) 
        return self.dequeueReusableCell(withIdentifier: className, for: indexPath) as! T
    }
}
