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

/**
 * State of a Hue Light (bulb, go, etc)
 */
class State : EVObject{
    var on  :Bool = false;         //true
    
    //brightness, in range 0 - 254. 0 is not off
    var bri :Int = 0;          //1
    
    //hue, in range 0 - 65535
    var hue :Int = 0;          //3271
    
    //saturation, in range 0 - 254
    var sat :Int = 0;          //244
    
    //
    var effect :String?;    //none
    
    //color as array of xy-coordinates.
    var xy : Array<Double>?; // [0.6397, 0.3482]
    
    //white color temperature, 154 (cold) - 500 (warm)
    var ct :Int = 0;           //153
    
    //select flashes light once, lselect flashes repeatedly for 10 seconds
    var alert :String?;     //none
    var colormode: String?; //hs
    var reachable: Bool = false;// true
    
    //time for transition in centiseconds.
    var transitiontime: Int = 0;
    
    required init(){}
    
    func toSetStateJsonFormat() -> String{
        ConversionOptions.DefaultNSCoding = [.PropertyMapping];
        //self.state?.toJsonString()
        return self.toJsonString();
    }
    
    override public func propertyMapping() -> [(String?, String?)] {
        return [
            ("xy",nil),
            ("colormode", nil),
            ("reachable", nil)
        ]
    }
}