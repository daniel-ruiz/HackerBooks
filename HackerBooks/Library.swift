//
//  Library.swift
//  HackerBooks
//
//  Created by Daniel Ruiz on 02/02/2017.
//  Copyright © 2017 Daniel Ruiz. All rights reserved.
//

import Foundation

class Library {
    
    //MARK: - Properties
    
    var books = MultiDictionary<Tag, Book>()
    
    
    //MARK: - Computed Properties
    
    var bookCount: Int {
        get {
            return books.countUnique
        }
    }
    
    var tags: [Tag] {
        get {
            var tags: [Tag] = []
            for tag in books.keys.sorted() {
                tags.append(tag)
            }
            return tags
        }
    }
    
    var tagCount: Int {
        get {
            return books.keys.count
        }
    }
    
    
    //MARK: - Initialization
    
    init(books: [Book]) {
        for book in books {
            for tag in book.tags {
                self.books.insert(value: book, forKey: tag)
            }
        }
    }
    
    
    //MARK: - Data Retrieval
    
    func books(forTag tag: Tag) -> [Book]? {
        if let bookCollection = books[tag] {
            return Array(bookCollection)
        } else {
            return nil
        }
    }
    
    func bookCount(forTag tag: Tag) -> Int {
        return books(forTag: tag)?.count ?? 0
    }
    
    func book(forTag tag: Tag, at: Int) -> Book? {
        if let bookCollection = books(forTag: tag) {
            return bookCollection[at]
        } else {
            return nil
        }
    }
}
