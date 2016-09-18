//
//  State.swift
//  LightHouse
//
//  Created by Jason McAffee on 9/17/16.
//  Copyright © 2016 Jason McAffee. All rights reserved.
//

import Foundation
import SwiftyJSON
import EVReflection

class State : EVObject{
    
//    "on": true,
//    "bri": 1,
//    "hue": 3271,
//    "sat": 244,
//    "effect": "none",
//    "xy": [
//    0.6307,
//    0.3482
//    ],
//    "ct": 153,
//    "alert": "none",
//    "colormode": "hs",
//    "reachable": true
    var on  :Bool?;         //true
    var bri :Int?;          //1
    var hue :Int?;          //3271
    var sat :Int?;          //244
    var effect :String?;    //none
    var xy : Array<Double>?; // [0.6397, 0.3482]
    var ct :Int?;           //153
    var alert :String?;     //none
    var colormode: String?; //hs
    
    init(json:JSON){
        super.init();
        popluateFromJSON(json);
    }
    required init(){
        
    }
    
    func popluateFromJSON(json:JSON){
        self.on = json["on"].bool;
        self.bri = json["bri"].int;
        self.hue = json["hue"].int;
        self.sat = json["sat"].int;
        self.effect = json["effect"].string;
        self.xy = json["xy"].arrayValue.map { $0.double!}
        self.ct = json["ct"].int;
        self.alert = json["alert"].string;
        self.colormode = json["colormode"].string;
    }
}