//
//  BookViewController.swift
//  HackerBooks
//
//  Created by Daniel Ruiz on 03/02/2017.
//  Copyright © 2017 Daniel Ruiz. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {
    
    //MARK: - Properties
    
    var book: Book
    weak var delegate: BookViewControllerDelegate? = nil
    
    @IBOutlet weak var bookCover: UIImageView!
    @IBOutlet weak var favoriteIcon: UIBarButtonItem!
    
    //MARK: - Initialization
    
    init(book: Book) {
        self.book = book
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
    }

    @IBAction func toggleFavorite(_ sender: UIBarButtonItem) {
        book.toggleFavoriteState()
        syncFavoriteIcon()
        delegate?.bookDidToggleFavoriteState(isNowFavorite: book.isFavorite)
    }
    
    
    //MARK: - Utils
    
    func syncViewWithBook() {
        bookCover.image = UIImage(named: "book_icon")
        syncFavoriteIcon()
    }
    
    func syncFavoriteIcon() {
        favoriteIcon.image = book.isFavorite ? UIImage(named: "ic_favorite.png") : UIImage(named: "ic_favorite_border.png")
    }
    
}

//MARK: - Protocols

protocol BookViewControllerDelegate: class {
    func bookDidToggleFavoriteState(isNowFavorite: Bool)
}
