//
//  LibraryViewController.swift
//  HackerBooks
//
//  Created by Daniel Ruiz on 03/02/2017.
//  Copyright © 2017 Daniel Ruiz. All rights reserved.
//

import UIKit

class LibraryViewController: UITableViewController {
    
    //MARK: - Properties
    
    var library: Library
    
    //MARK: - Initialization
    
    init(library: Library) {
        self.library = library
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Hacker Books"
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return library.tagCount
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return library.bookCount(forTag: tag(inSection: section))
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let tagContent = tag(inSection: section).description
        return tagContent.capitalized
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "BookCell"
        let book = library.book(forTag: tag(inSection: indexPath.section), at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        
        cell.imageView?.image = UIImage(named: "book_icon")
        cell.textLabel?.text = book?.title
        cell.detailTextLabel?.text = book?.authorsDescription
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedBook = library.book(forTag: tag(inSection: indexPath.section), at: indexPath.row) else {
            return
        }
        let bookController = BookViewController(book: selectedBook)
        bookController.delegate = self
        self.navigationController?.pushViewController(bookController, animated: true)
    }
    
    
    //MARK: - Utils
    
    func tag(inSection section: Int) -> Tag {
        return library.tags[section]
    }
}

//MARK: - Protocols

extension LibraryViewController: BookViewControllerDelegate {
    func bookDidToggleFavoriteState(book: Book, isNowFavorite: Bool) {
        if (isNowFavorite) {
            library.addBookToFavorites(book)
        } else {
            library.removeBookFromFavorites(book)
        }
        
        self.tableView.reloadData()
    }
}
