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
    var coverImage: UIImage
    var pdfUrl: URL
    
    //MARK: - Initialization
    
    init(title: Title, authors: [Author],
         tags: [Tag], coverImage: UIImage, pdfUrl: URL) {
        self.title = title
        self.authors = authors
        self.tags = tags
        self.coverImage = coverImage
        self.pdfUrl = pdfUrl
    }
    
    convenience init(title: Title, authors: [Author],
                     tags: [Tag], coverStringUrl: String, pdfUrl: URL) {
        let coverImage: UIImage
        
        if let coverUrl = URL(string: coverStringUrl),
            let coverData = try? Data(contentsOf: coverUrl) {
            coverImage = UIImage(data: coverData) ?? UIImage(assetIdentifier: .DefaultBookCover)
        } else {
            coverImage = UIImage(assetIdentifier: .DefaultBookCover)
        }
        
            
        self.init(title: title, authors: authors,
                  tags: tags, coverImage: coverImage, pdfUrl: pdfUrl)
         
    }
    
}
