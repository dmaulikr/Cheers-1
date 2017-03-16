//
//  DrinkingBuddy.swift
//  Cheers
//
//  Created by Minna Xiao on 3/9/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

import Foundation
import MapKit

class DrinkingBuddy: NSObject, MKAnnotation {
    // MKAnnotation
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    var name: String
    var status: Status
    var phone: String
    var image: String
    var count: Int
    var limit: Int
    // maybe location? address?
    
    init(name: String, status: Status, title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D, phone: String, image: String, count: Int, limit: Int) {
        self.name = name
        self.status = status
        self.title = title ?? name
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.phone = phone
        self.image = image
        self.count = count
        self.limit = limit
    }
    
    // Person's night status
    enum Status {
        case dangerZone
        case fine
        case left
    }
    
    func updateStatus(newStatus: Status) {
        self.status = newStatus
    }
    
    // add functions to update coordinates
}
