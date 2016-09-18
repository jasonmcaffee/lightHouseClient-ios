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
    var on  :Bool?;         //true
    var bri :Int?;          //1
    var hue :Int?;          //3271
    var sat :Int?;          //244
    var effect :String?;    //none
    var xy : Array<Double>?; // [0.6397, 0.3482]
    var ct :Int?;           //153
    var alert :String?;     //none
    var colormode: String?; //hs
    var reachable: Bool?;// true
    
    required init(){}
}