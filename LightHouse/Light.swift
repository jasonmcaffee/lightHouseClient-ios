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

class Light : EVObject{
    var key: String?; // "1"   "13"
    var name: String?; //Hue color lamp 1
    var modelid: String?; //LCT007
    var uniqueid: String?;//00:17:88:01:10:25:0d:83-0b
    var type: String?; //Extended color light
    var manufacturername: String?; //Philips
    var swversion: String?; //5.38.1.14919
    
    var state: State?;
    

    
    init(key: String, json:String?){
        super.init();
        self.key = key;
        let jsonDict = EVReflection.dictionaryFromJson(json)
        EVReflection.setPropertiesfromDictionary(jsonDict, anyObject: self, conversionOptions: .DefaultDeserialize)
        
    }
    
    
    required init(){
        
    }
    
//    func populateFromJSON(key: String, json: JSON){
//        self.key = key;
//        self.name = json["name"].string;
//        self.uniqueid = json["uniqueid"].string;
//        self.type = json["type"].string;
//        self.manufacturername = json["manufacturername"].string;
//        self.swversion = json["swversion"].string;
//        
//        self.state = State(json: json["state"]);
//    }
    
    //    init(key: String, json: JSON){
    //        super.init();
    //        populateFromJSON(key, json: json);
    //    }
}
