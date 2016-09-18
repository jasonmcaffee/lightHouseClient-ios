//
//  SystemState.swift
//  LightHouse
//
//  Created by Jason McAffee on 9/17/16.
//  Copyright © 2016 Jason McAffee. All rights reserved.
//

import Foundation

/**
 * Represents the state of lights, groups, scenes etc. which is returned from the Hue Bridge /api call.
 */
class SystemState: NSObject{
    
    var lightArray: Array<Light>;
    
    override init(){
        lightArray = Array<Light>();
    }
}