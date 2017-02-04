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

class Book {
    
    //MARK: - Attributes
    
    var title: Title
    var authors: [Author]
    var tags: [Tag]
    var coverImageUrl: URL?
    var pdfUrl: URL?
    private var favorite: Bool = false
    
    //MARK: - Computed Properties
    
    var authorsDescription: String {
        get {
            return authors.map({ $0 as String }).joined(separator: ", ")
        }
    }
    
    var tagsDescription: String {
        get {
            return tags.map({ $0.description }).joined(separator: ", ")
        }
    }
    
    var isFavorite: Bool {
        get {
            return favorite
        }
    }
    
    //MARK: - Initialization
    
    init(title: Title, authors: [Author],
         tags: [Tag], coverImageUrl: URL?,
         pdfUrl: URL?, isFavorite: Bool) {
        self.title = title
        self.authors = authors
        self.tags = tags
        self.coverImageUrl = coverImageUrl
        self.pdfUrl = pdfUrl
        self.favorite = isFavorite
    }
    
    convenience init(title: Title, authors: [Author],
         tags: [Tag], coverImageUrl: URL?, pdfUrl: URL?) {
        self.init(title: title, authors: authors, tags: tags, coverImageUrl: coverImageUrl, pdfUrl: pdfUrl, isFavorite: false)
    }
    
    convenience init(title: String, authors: String,
                     tags: String, coverStringUrl: String, pdfStringUrl: String) {
        self.init(
            title: title as Title,
            authors: authors.components(separatedBy: ", ").flatMap({ $0 as Author }),
            tags: tags.components(separatedBy: ", ").flatMap({ Tag(rawValue: $0) }),
            coverImageUrl: URL(string: coverStringUrl),
            pdfUrl: URL(string: pdfStringUrl)
        )
         
    }
    
    //MARK: - Utils
    
    func toggleFavoriteState() {
        favorite = !favorite
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
