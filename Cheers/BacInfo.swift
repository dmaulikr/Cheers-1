//
//  BacInfo.swift
//  Cheers
//
//  Created by Minna Xiao on 3/15/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

import Foundation

struct BacInfo {
    static var drinkToBACDict: Dictionary<Int, String> = [
        0:"0.00",
        1:"0.04",
        2:"0.07",
        3:"0.10",
        4:"0.13",
        5:"0.16",
        6:"0.19",
        7:"0.23",
        8:"0.27",
        9:"0.3",
        10:"0.33"
    ]
    
    static var BACToColorDict: Dictionary<String, String> = [
    "0.00":"9AD145",
    "0.04":"9AD145",
    "0.07":"E7B90B",
    "0.10":"E7B90B",
    "0.13":"FF871D",
    "0.16":"FF871D",
    "0.19":"CC0F0F",
    "0.23":"CC0F0F",
    "0.27":"CC0F0F",
    "0.3":"CC0F0F",
    "0.33":"CC0F0F"
    ]
    
    static var BACToEffectDict: Dictionary<String, String> = [
    "0.00":"SOBER",
    "0.04":"TIPSY",
    "0.07":"BUZZED",
    "0.10":"LEGALLY DRUNK",
    "0.13":"SLOPPY DRUNK",
    "0.16":"SLOPPY DRUNK",
    "0.19":"WASTED",
    "0.23":"WASTED",
    "0.27":"BLACKOUT",
    "0.3":"BLACKOUT",
    "0.33":"UNCONSCIOUS"
    ]
    
    static var ColorToGradientDict: Dictionary<String, String> = [
        "9AD145": "gradient-green",
        "E7B90B": "gradient-yellow",
        "FF871D": "gradient-orange",
        "CC0F0F": "gradient-red"
    ]
}
