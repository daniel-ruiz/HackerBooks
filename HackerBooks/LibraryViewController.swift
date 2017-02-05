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
    weak var delegate: LibraryViewControllerDelegate? = nil
    
    //MARK: - Computed Properties
    
    var defaultBookCoverData: Data {
        get {
            let defaultCoverUrl = Bundle.main.url(forResource: "book_icon", withExtension: "png")!
            return try! Data(contentsOf: defaultCoverUrl)
        }
    }
    
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
        let bookCellNib = UINib(nibName: "BookViewCell", bundle: nil)
        tableView.register(bookCellNib, forCellReuseIdentifier: BookViewCell.cellId)
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
        let book = library.book(forTag: tag(inSection: indexPath.section), at: indexPath.row)
        let cell: BookViewCell = tableView.dequeueReusableCell(withIdentifier: BookViewCell.cellId) as? BookViewCell ?? BookViewCell()
        
        cell.setCoverViewData(with: AsyncData(url: (book?.coverImageUrl)!, defaultData: defaultBookCoverData))
        cell.titleLabel?.text = book?.title
        cell.authorsLabel?.text = book?.authorsDescription
        cell.tagsLabel?.text = book?.tagsDescription
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedBook = library.book(forTag: tag(inSection: indexPath.section), at: indexPath.row) else {
            return
        }
        
        delegate?.libraryViewController(self, didSelectBook: selectedBook)
        notify(bookDidChange: selectedBook)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BookViewCell.cellHeight
    }

    
    //MARK: - Utils
    
    func tag(inSection section: Int) -> Tag {
        return library.tags[section]
    }
}

//MARK: - Protocols

protocol LibraryViewControllerDelegate: class {
    func libraryViewController(_ sender: LibraryViewController, didSelectBook book: Book)
}


//MARK: - LibraryViewControllerDelegate

extension LibraryViewController: LibraryViewControllerDelegate {
    func libraryViewController(_ sender: LibraryViewController, didSelectBook book: Book) {
        let bookController = BookViewController(book: book)
        bookController.delegate = self
        navigationController?.pushViewController(bookController, animated: true)
    }
}


//MARK: - BookViewControllerDelegate

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

//MARK: - Notifications

extension LibraryViewController {
    
    static let NotificationName = Notification.Name(rawValue: "LibraryViewControllerBookDidChange")
    static let BookKey = "LibraryViewControllerBookKey"
    
    func notify(bookDidChange book: Book) {
        let notificationCenter = NotificationCenter.default
        let notification = Notification(name: LibraryViewController.NotificationName, object: self, userInfo: [LibraryViewController.BookKey : book])
        
        notificationCenter.post(notification)
    }
}
