//
//  LookHeaderCollectionViewCell.swift
//  Diwi
//
//  Created by Shane Work on 12/16/20.
//  Copyright © 2020 Trim Agency. All rights reserved.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backgroundImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundImage.contentMode = .scaleAspectFill
    }

}
