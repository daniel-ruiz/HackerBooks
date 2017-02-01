//
//  Book.swift
//  HackerBooks
//
//  Created by Daniel Ruiz on 23/01/2017.
//  Copyright © 2017 Daniel Ruiz. All rights reserved.
//

import Foundation
import UIKit

typealias Title = String
typealias Author = String
typealias Tag = String

class Book {
    
    //MARK: - Attributes
    
    var title: Title
    var authors: [Author]
    var tags: [Tag]
    var coverImageUrl: URL?
    var pdfUrl: URL?
    
    //MARK: - Initialization
    
    init(title: Title, authors: [Author],
         tags: [Tag], coverImageUrl: URL?, pdfUrl: URL?) {
        self.title = title
        self.authors = authors
        self.tags = tags
        self.coverImageUrl = coverImageUrl
        self.pdfUrl = pdfUrl
    }
    
    convenience init(title: String, authors: String,
                     tags: String, coverStringUrl: String, pdfStringUrl: String) {
        self.init(
            title: title as Title,
            authors: authors.components(separatedBy: ", ").flatMap({ $0 as Author }),
            tags: tags.components(separatedBy: ", ").flatMap({ $0 as Tag }),
            coverImageUrl: URL(string: coverStringUrl),
            pdfUrl: URL(string: pdfStringUrl)
        )
         
    }
    
    //MARK: - Proxies
    
    func proxyForEquality() -> String {
        return "\(title)\(authors)\(tags)\(coverImageUrl?.hashValue)\(pdfUrl?.hashValue)"
    }
    
}

//MARK: - Protocols

extension Book: Equatable {
    static func ==(lhs: Book, rhs: Book) -> Bool {
        return lhs.proxyForEquality() == rhs.proxyForEquality()
    }
}

extension Book: Comparable {
    static func <(lhs: Book, rhs: Book) -> Bool {
        return lhs.proxyForEquality() < rhs.proxyForEquality()
    }
}

extension Book: Hashable {
    var hashValue: Int {
        get{
            return proxyForEquality().hashValue
        }
    }
}

extension Book: CustomStringConvertible {
    var description: String {
        get {
            return "<Book title:\(title) authors:\(authors) tags:\(tags) coverImageUrl:\(coverImageUrl?.hashValue) pdfUrl:\(pdfUrl?.hashValue)>"
        }
    }
}
