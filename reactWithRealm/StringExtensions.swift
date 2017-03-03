//
//  StringExtensions.swift
//  reactWithRealm
//
//  Created by Nikita Rodin on 3/3/17.
//  Copyright © 2017 Nikita Rodin. All rights reserved.
//

import Foundation

/**
 * Shortcut methods for String
 *
 * - author: Nikita Rodin
 * - version: 1.0
 */
extension String {
    /**
     Checks if string contains given substring
     
     - parameter substring:     the search string
     - parameter caseSensitive: flag: true - search is case sensitive, false - else
     
     - returns: true - if the string contains given substring, false - else
     */
    func contains(_ substring: String, caseSensitive: Bool = true) -> Bool {
        if let _ = self.range(of: substring,
                              options: caseSensitive ? NSString.CompareOptions(rawValue: 0) : .caseInsensitive) {
            return true
        }
        return false
    }
    
    /**
     Get string without spaces at the end and at the start.
     
     - returns: trimmed string
     */
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /// percent escaped for URL query
    var percentEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }
}
