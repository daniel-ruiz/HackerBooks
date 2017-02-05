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
        let libraryViewController = LibraryViewController(library: library)
        let libraryNavigationController = UINavigationController(rootViewController: libraryViewController)
        
        let initialBook = fetchInitialBook(library: library)
        let bookViewController = BookViewController(book: initialBook)
        let bookNavigationController = UINavigationController(rootViewController: bookViewController)
        
        let splitViewController = UISplitViewController(nibName: nil, bundle: nil)
        splitViewController.viewControllers = [libraryNavigationController, bookNavigationController]
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            libraryViewController.delegate = libraryViewController
        case .pad:
            libraryViewController.delegate = bookViewController
        default:
            fatalError("The application is trying to run in an unsopported device")
        }
        
        self.window?.rootViewController = splitViewController
        self.window?.makeKeyAndVisible()
        return true
    }

    //MARK: - Utils
    
    func fetchInitialBook(library: Library) -> Book {
        return library.book(forTag: library.tags.first!, at: 0)!
    }
    
    func downloadBookCollection() -> [Book] {
        
        let jsonData = fetchBookData()
        
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
            
            let book = Book(title: title, authors: authors, tags: tags, coverStringUrl: coverUrl, pdfStringUrl: pdfUrl)
            
            let userDefaults = UserDefaults.standard
            let isBookFavorite = userDefaults.bool(forKey: String(book.hashValue))
            
            if isBookFavorite {
                book.toggleFavoriteState()
            }
            
            return book
        })
    }
    
    func fetchBookData() -> Data {
        let bookDataKey = "BookDataKey"
        let userDefaults = UserDefaults.standard
        
        guard let bookData: Data = userDefaults.data(forKey: bookDataKey) else {
            
            guard let jsonUrl = URL(string: "https://t.co/K9ziV0z3SJ") else {
                fatalError("Error in book collection URL")
            }
            
            guard let jsonData = try? Data(contentsOf: jsonUrl) else {
                fatalError("Error in book collection endpoint")
            }
            
            userDefaults.set(jsonData, forKey: bookDataKey)
            
            return jsonData
        }
        
        return bookData
    }


}

