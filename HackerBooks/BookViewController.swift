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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncViewWithBook()
    }
    

    //MARK: - Actions
    
    @IBAction func showPdf(_ sender: UIBarButtonItem) {
    }

    @IBAction func makeFavorite(_ sender: UIBarButtonItem) {
        self.favoriteIcon.image = UIImage(named: "ic_favorite.png")
    }

    
    
    //MARK: - Utils
    
    func syncViewWithBook() {
        bookCover.image = UIImage(named: "book_icon")
    }
    
}
