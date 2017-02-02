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
    var booksCount: Int {
        get {
            return books.countUnique
        }
    }
    
    //MARK: - Initiaization
    
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
