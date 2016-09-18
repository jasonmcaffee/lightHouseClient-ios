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
    var bri :Int = 0;          //1
    var hue :Int = 0;          //3271
    var sat :Int = 0;          //244
    var effect :String?;    //none
    var xy : Array<Double>?; // [0.6397, 0.3482]
    var ct :Int = 0;           //153
    var alert :String?;     //none
    var colormode: String?; //hs
    var reachable: Bool = false;// true
    
    required init(){}
}