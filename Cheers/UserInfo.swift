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
    
    static var drinkLimit: Int {
        get {
            return defaults.object(forKey: "DrinkLimit") as? Int ?? 0
        }
        set {
            defaults.set(newValue, forKey: "DrinkLimit")
        }
    }
    
    static var myBitmoji: String {
        get {
            return defaults.object(forKey: "MyBitmoji") as? String ?? "emily2" //replace this with default
        }
        set {
            defaults.set(newValue, forKey: "MyBitmoji")
        }
    }
    
    // MARK: Public API
    static private let defaults = UserDefaults.standard
}
