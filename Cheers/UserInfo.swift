//
//  UserInfo.swift
//  Cheers
//
//  Created by Minna Xiao on 3/14/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

import Foundation
import MapKit

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
            return defaults.object(forKey: "MyBitmoji") as? String ?? "carousel-bitmoji-beer"
        }
        set {
            defaults.set(newValue, forKey: "MyBitmoji")
        }
    }
    
    static var latitudeToView: Double {
        get {
            return defaults.object(forKey: "LatitudeToLocate") as? Double ?? 37.789819
        }
        set {
            defaults.set(newValue, forKey: "LatitudeToLocate")
        }
    }
    
    static var longitudeToView: Double {
        get {
            return defaults.object(forKey: "LongitudeToLocate") as? Double ?? -122.420716
        }
        set {
            defaults.set(newValue, forKey: "LongitudeToLocate")
        }
    }
    
    static func clearData() {
        numDrinks = 0
        drinkLimit = 0
        myBitmoji = "carousel-bitmoji-beer"
        latitudeToView = 37.789819
        longitudeToView = -122.420716
    }
    
    // MARK: Public API
    static private let defaults = UserDefaults.standard
}
