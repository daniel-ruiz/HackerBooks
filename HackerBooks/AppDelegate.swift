//
//  AppDelegate.swift
//  HackerBooks
//
//  Created by Daniel Ruiz on 22/01/2017.
//  Copyright © 2017 Daniel Ruiz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //MARK: - App Lifecycle
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let library = Library(books: downloadBookCollection())
        let libraryController = LibraryViewController(library: library)
        let navigationController = UINavigationController(rootViewController: libraryController)
        
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        return true
    }

    //MARK: - Utils
    
    func downloadBookCollection() -> [Book] {
        
        guard let jsonUrl = URL(string: "https://t.co/K9ziV0z3SJ") else {
            fatalError("Error in book collection URL")
        }
        
        guard let jsonData = try? Data(contentsOf: jsonUrl) else {
            fatalError("Error in book collection endpoint")
        }
        
        guard let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableLeaves) as? [[String: String]],
            let bookCollection = jsonObject else {
            fatalError("Error while decoding book collection JSON")
        }
        
        return bookCollection.flatMap({ (dict: [String : String]) -> Book? in
            guard let title: String = dict["title"],
                let authors: String = dict["authors"],
                let tags: String = dict["tags"],
                let coverUrl: String = dict["image_url"],
                let pdfUrl: String = dict["pdf_url"] else {
                    return nil
            }
            
            return Book(title: title, authors: authors, tags: tags, coverStringUrl: coverUrl, pdfStringUrl: pdfUrl)
        })
    }


}

