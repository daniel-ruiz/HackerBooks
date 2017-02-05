//
//  BookViewCell.swift
//  HackerBooks
//
//  Created by Daniel Ruiz on 05/02/2017.
//  Copyright © 2017 Daniel Ruiz. All rights reserved.
//

import UIKit

class BookViewCell: UITableViewCell {
    
    //MARK: - Class Properties
    
    static var cellId: String {
        get {
            return "BookViewCell"
        }
    }
    
    static var cellHeight: CGFloat {
        get {
            return 95.0
        }
    }

    //MARK: - Properties
    
    var coverViewData: AsyncData? = nil
    
    @IBOutlet weak fileprivate var coverView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!

}

//MARK: - AsyncDataDelegate

extension BookViewCell: AsyncDataDelegate {
    
    func asyncData(_ sender: AsyncData, didEndLoadingFrom url: URL) {
        UIView.transition(with: coverView,
                          duration: 0.7,
                          options: [.transitionCrossDissolve],
                          animations: {
                            self.coverView.image = UIImage(data: sender.data)
                            
        }, completion: nil)
    }
    
    //MARK: Utils
    
    func setCoverViewData(with data: AsyncData) {
        coverViewData = data
        coverViewData!.delegate = self
        coverView.image = UIImage(data: coverViewData!.data)
    }
    
}
