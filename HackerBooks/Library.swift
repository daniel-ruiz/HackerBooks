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
    
    //MARK: - Initiaization
    init(books: [Book]) {
        for book in books {
            for tag in book.tags {
                self.books.insert(value: book, forKey: tag)
            }
        }
    }
    
}
