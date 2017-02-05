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
    
    @IBOutlet weak var coverView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
}
