//
//  SystemState.swift
//  LightHouse
//
//  Created by Jason McAffee on 9/17/16.
//  Copyright © 2016 Jason McAffee. All rights reserved.
//

import Foundation
import SwiftyJSON
import EVReflection

/**
 * Represents the state of lights, groups, scenes etc. which is returned from the Hue Bridge /api call.
 */
class SystemState: EVObject{
    
    var lightArray: Array<Light>;
    
    required init(){
        lightArray = Array<Light>();
    }
    
    func populateFromJson(stateJson: JSON){
        if let lightsJson = stateJson["lights"].dictionary{
            for(key, lightJson):(String, JSON) in lightsJson{
                
                let light = Light(key: key, json: lightJson.rawString());
                self.lightArray.append(light);
            }
        }else{
            print("Error getting system state from Hue Bridge: no lights found in json");
        }

    }
}