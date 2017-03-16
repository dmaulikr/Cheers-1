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

extension DrinkingBuddy {
    
    static func getFriends() -> [DrinkingBuddy] {
        let minna_coord = CLLocationCoordinate2D(latitude: 37.789450, longitude: -122.420665)
        let emily_coord = CLLocationCoordinate2D(latitude: 37.789819, longitude: -122.420716)
        let cat_coord = CLLocationCoordinate2D(latitude: 37.789395, longitude: -122.420337)
        let jeremy_coord = CLLocationCoordinate2D(latitude: 37.789529, longitude: -122.420602)
        let oc_coord = CLLocationCoordinate2D(latitude: 37.430986, longitude: -122.190008)
        
        let minna = DrinkingBuddy(name: "minna", status: DrinkingBuddy.Status.dangerZone, title: nil, subtitle: "Playland Bar", coordinate: minna_coord, phone: "6073791277", image: "minna-bitmoji", count: 7, limit: 6)
        let catherine = DrinkingBuddy(name: "catherine", status: DrinkingBuddy.Status.fine, title: nil, subtitle: "Playland Bar", coordinate: cat_coord, phone: "9492417906", image: "cat-profile-bitmoji", count: 4, limit: 7)
        let me = DrinkingBuddy(name: "me", status: DrinkingBuddy.Status.fine, title: nil, subtitle: "Victor's Pizza", coordinate: emily_coord, phone: "9492417906", image: "carousel-bitmoji-beer", count: UserInfo.numDrinks, limit: UserInfo.drinkLimit) //emily
        let jeremy = DrinkingBuddy(name: "jeremy", status: DrinkingBuddy.Status.fine, title: nil, subtitle: "Playland Bar", coordinate: jeremy_coord, phone: "5038676659", image: "jeremy-profile-bitmoji", count: 0, limit: 0)
        let shubha = DrinkingBuddy(name: "shubha", status: DrinkingBuddy.Status.left, title: nil, subtitle: "Home", coordinate: oc_coord, phone: "4085945805", image: "shubha-sleeping-bitmoji", count: 1, limit: 4)
        let nick = DrinkingBuddy(name: "nick", status: DrinkingBuddy.Status.left, title: nil, subtitle: "Home", coordinate: oc_coord, phone: "4085945805", image: "nick-sleeping-bitmoji", count: 3, limit: 8)
        let raven = DrinkingBuddy(name: "raven", status: DrinkingBuddy.Status.left, title: nil, subtitle: "Home", coordinate: oc_coord, phone: "4085945805", image: "raven-sleeping-bitmoji", count: 2, limit: 5)
        
        return [minna, catherine, me, jeremy, shubha, nick, raven]
    }
}
