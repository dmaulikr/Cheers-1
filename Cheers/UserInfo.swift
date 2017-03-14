//
//  UserInfo.swift
//  Cheers
//
//  Created by Minna Xiao on 3/14/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

import Foundation

struct UserInfo {
    
    // MARK: Public API
    static var numDrinks: Int {
        get {
            return defaults.object(forKey: "DrinkCount") as? Int ?? 0
        }
        set {
            defaults.set(newValue, forKey: "DrinkCount")
        }
    }
    
    // MARK: Public API
    static private let defaults = UserDefaults.standard
}
