//
//  Tag.swift
//  HackerBooks
//
//  Created by Daniel Ruiz on 04/02/2017.
//  Copyright © 2017 Daniel Ruiz. All rights reserved.
//

import Foundation

struct Tag {
    
    //MARK: - Static Properties
    
    private static var favoriteRawValue: String {
        get {
            return "favorites"
        }
    }
    
    private static var favoriteTagInstance: Tag?
    
    static var favoriteTag: Tag {
        get {
            if (favoriteTagInstance == nil) {
                favoriteTagInstance = Tag(rawValue: favoriteRawValue)
            }
            return favoriteTagInstance ?? Tag(rawValue: favoriteRawValue)
        }
    }
    
    //MARK: - Properties
    
    var rawValue: String
    var isFavoriteTag: Bool {
        get {
            return rawValue == Tag.favoriteRawValue
        }
    }
    
    
    //MARK: - Initialization
    
    init(rawValue: String) {
        self.rawValue = rawValue
    }
    
}

//MARK: - Protocols

extension Tag: CustomStringConvertible {
    var description: String {
        get {
            return rawValue
        }
    }
}

extension Tag: Equatable {
    static func ==(lhs: Tag, rhs: Tag) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

extension Tag: Comparable {
    static func <(lhs: Tag, rhs: Tag) -> Bool {
        
        if lhs.isFavoriteTag  {
            return true
        }
        
        if rhs.isFavoriteTag {
            return false
        }
        
        return lhs.rawValue < rhs.rawValue
        
    }
}

extension Tag: Hashable {
    var hashValue: Int {
        get {
            return rawValue.hashValue
        }
    }
}
