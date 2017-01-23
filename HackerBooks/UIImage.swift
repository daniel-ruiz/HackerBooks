//
//  UIImage.swift
//  HackerBooks
//
//  Created by Daniel Ruiz on 23/01/2017.
//  Copyright © 2017 Daniel Ruiz. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    enum AssetIdentifier: String {
        case DefaultBookCover = "book_icon.png"
    }
    
    convenience init!(assetIdentifier: AssetIdentifier) {
        self.init(named: assetIdentifier.rawValue)
    }
    
}
