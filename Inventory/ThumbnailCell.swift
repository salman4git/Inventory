//
//  ThumbnailCell.swift
//  Inventory
//
//  Created by Apple on 7/6/17.
//  Copyright © 2017 Salman. All rights reserved.
//

import UIKit

class ThumbnailCell: UICollectionViewCell {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    
    override func awakeFromNib() {
        self.productNameLabel.adjustsFontSizeToFitWidth = false
        self.productNameLabel.lineBreakMode = NSLineBreakMode.byTruncatingTail
    }
}
