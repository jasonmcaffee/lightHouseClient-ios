//
//  Light.swift
//  LightHouse
//
//  Created by Jason McAffee on 9/17/16.
//  Copyright © 2016 Jason McAffee. All rights reserved.
//

import Foundation
import SwiftyJSON

class Light : NSObject{
    var name: String?;
    var uniqueid: String?;
    var type: String?;
    var state: State?;
    
    init(key: String, json: JSON){
        super.init();
        populateFromJSON(key, json: json);
    }
    
    func populateFromJSON(key: String, json: JSON){
        self.name = key;
        self.uniqueid = json["uniqueid"].string;
        self.type = json["type"].string;
        
        self.state = State(json: json["state"]);
        
    }
}