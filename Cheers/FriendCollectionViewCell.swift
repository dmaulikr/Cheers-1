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
    
    @IBOutlet weak var gradientView: UIImageView!
    
    
    var name: String? {
        didSet {
            friendName?.text = name
        }
    }
    
    var friend: DrinkingBuddy? {
        didSet {
            friendImage.image = UIImage(named: (friend?.image)!)
            
            if (friend?.status == DrinkingBuddy.Status.left) {
                self.gradientView.isHidden = true
            } else {
                let bac = BacInfo.drinkToBACDict[(friend?.count)!]
                let colorHex = BacInfo.BACToColorDict[bac!]
                let gradientString = BacInfo.ColorToGradientDict[colorHex!]
                self.gradientView.image = UIImage(named: gradientString!)
            }
        }
    }
}
