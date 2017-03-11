//
//  FriendCollectionViewCell.swift
//  Cheers
//
//  Created by Minna Xiao on 3/10/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

import UIKit

class FriendCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var friendName: UILabel!
    
    @IBOutlet weak var friendImage: UIImageView!
    
    var name: String? {
        didSet {
            friendName?.text = name
        }
    }
}
