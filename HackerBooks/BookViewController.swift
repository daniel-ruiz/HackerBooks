//
//  BookViewController.swift
//  HackerBooks
//
//  Created by Daniel Ruiz on 03/02/2017.
//  Copyright © 2017 Daniel Ruiz. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {
    
    //MARK: - Static Properties
    
    private static let DefaultCover = UIImage(named: "book_detail_placeholder")!
    
    
    //MARK: - Properties
    
    var book: Book
    fileprivate var bookCoverData: AsyncData
    weak var delegate: BookViewControllerDelegate? = nil
    
    @IBOutlet weak var bookCover: UIImageView!
    @IBOutlet weak var favoriteIcon: UIBarButtonItem!
    
    
    //MARK: - Initialization
    
    init(book: Book) {
        self.book = book
        bookCoverData = AsyncData(url: book.coverImageUrl, defaultData: UIImagePNGRepresentation(BookViewController.DefaultCover)!)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncViewWithBook()
    }
    

    //MARK: - Actions
    
    @IBAction func showPdf(_ sender: UIBarButtonItem) {
        let pdfViewController = PdfViewController(pdfUrl: book.pdfUrl)
        navigationController?.pushViewController(pdfViewController, animated: true)
    }

    @IBAction func toggleFavorite(_ sender: UIBarButtonItem) {
        book.toggleFavoriteState()
        syncFavoriteIcon()
        delegate?.bookDidToggleFavoriteState(book: book, isNowFavorite: book.isFavorite)
        persistBookfavoriteState()
    }
    
    
    //MARK: - View Synchronization
    
    func syncViewWithBook() {
        syncBookCoverData()
        syncFavoriteIcon()
    }
    
    func syncFavoriteIcon() {
        favoriteIcon.image = book.isFavorite ? UIImage(named: "ic_favorite") : UIImage(named: "ic_favorite_border")
    }
    
    
    //MARK: - Favorite handling
    
    func persistBookfavoriteState() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(book.isFavorite, forKey: String(book.hashValue))
    }
    
    
    //MARK: - AsyncData Handling
    
    func syncBookCoverData() {
        bookCoverData = AsyncData(url: book.coverImageUrl, defaultData: UIImagePNGRepresentation(BookViewController.DefaultCover)!)
        bookCoverData.delegate = self
        bookCover.image = UIImage(data: bookCoverData.data)
    }
    
}


//MARK: - Protocols

protocol BookViewControllerDelegate: class {
    func bookDidToggleFavoriteState(book: Book, isNowFavorite: Bool)
}


//MARK: - AsyncDataDelegate

extension BookViewController: AsyncDataDelegate {
    func asyncData(_ sender: AsyncData, didEndLoadingFrom url: URL) {
        UIView.transition(with: bookCover,
                          duration: 0.7,
                          options: [.transitionCrossDissolve],
                          animations: {
                            self.bookCover.image = UIImage(data: sender.data)
                            
        }, completion: nil)
    }
}

//MARK: - LibraryViewControllerDelegate

extension BookViewController: LibraryViewControllerDelegate {
    func libraryViewController(_ sender: LibraryViewController, didSelectBook book: Book) {
        self.book = book
        syncViewWithBook()
    }
}

