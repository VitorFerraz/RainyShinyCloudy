//
//  Location.swift
//  RainyShinyCloudy
//
//  Created by Vitor Ferraz on 20/01/17.
//  Copyright © 2017 Vitor Ferraz. All rights reserved.
//

import CoreLocation


class Location{
    //singleton class
    static var sharedInstance = Location()
    private init(){}
    
    var latitude:Double!
    var longitude: Double!
    
    
}
