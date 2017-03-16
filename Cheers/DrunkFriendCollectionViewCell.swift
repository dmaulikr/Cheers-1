//
//  DrunkFriendCollectionViewCell.swift
//  Cheers
//
//  Created by Minna Xiao on 3/10/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

import UIKit

class DrunkFriendCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendImage: UIImageView!
    
    @IBOutlet weak var exceededLabel: UILabel!
    
    
    // MARK: - Properties
    var name: String? {
        didSet {
            friendName?.text = name
        }
    }
    
    var friend: DrinkingBuddy? {
        didSet {
            friendImage.image = UIImage(named: (friend?.image)!)
        }
    }
}
