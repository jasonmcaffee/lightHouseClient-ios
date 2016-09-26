//
//  Light.swift
//  LightHouse
//
//  Created by Jason McAffee on 9/17/16.
//  Copyright © 2016 Jason McAffee. All rights reserved.
//

import Foundation
import SwiftyJSON
import EVReflection

/**
 * Represents a hue light of some kind (bulb, led strip, go, etc)
 * http://www.burgestrand.se/hue-api/api/lights/
 */
class Light : EVObject{
    var key: String?; // "1"   "13"
    var name: String?; //Hue color lamp 1
    var modelid: String?; //LCT007
    var uniqueid: String?;//00:17:88:01:10:25:0d:83-0b
    var type: String?; //Extended color light
    var manufacturername: String?; //Philips
    var swversion: String?; //5.38.1.14919
    
    //the current state of the light (on, coordinates, etc)
    var state: State?;
    
    /**
     * @param key - id given by the hue bridge. sent when creating groups.
     * @param json - the json string representing the light. all json keys should match property names
     */
    init(key: String, json:String?){
        super.init();
        self.key = key;
        let jsonDict = EVReflection.dictionaryFromJson(json)
        EVReflection.setPropertiesfromDictionary(jsonDict, anyObject: self, conversionOptions: .DefaultDeserialize)
    }
    
    required init(){}
    
    func toSetStateJsonFormat() -> String{
        ConversionOptions.DefaultNSCoding = [.PropertyMapping];
        //self.state?.toJsonString()
        return self.toJsonString();
    }
}
