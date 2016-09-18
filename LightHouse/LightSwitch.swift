//
//  LightSwitch.swift
//  LightHouse
//
//  Created by Jason McAffee on 9/18/16.
//  Copyright © 2016 Jason McAffee. All rights reserved.
//

import UIKit

/**
 https://developer.apple.com/library/content/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Lesson5.html
 */
class LightSwitch: UIView {

    var light:Light = Light();
    
    var uiSwitchWidth = 100;
    var uiSwitchHeight = 50;
    var uiLabelWidth = 100;
    var uiLabelHeight = 50;
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    init(light: Light, frame: CGRect){
        super.init(frame: frame);
        setLightState(light);
    }
    
    func setLightState(light:Light){
        self.light = light;
        
        var lightSwitch = UISwitch(frame: CGRect(x: uiLabelWidth, y: 0, width: uiSwitchWidth, height: uiSwitchHeight));
        lightSwitch.backgroundColor = .blueColor();
        lightSwitch.addTarget(self, action: #selector(lightSwitchAction), forControlEvents: .TouchUpInside);
        
        addSubview(lightSwitch)
        
        var label = UILabel(frame: CGRectMake(0, 0, 200, 50))
        label.center = CGPointMake(160, 284)
        label.textAlignment = NSTextAlignment.Center
        label.text = "label " + light.name!;
        
        addSubview(label);

    }
    
    func lightSwitchAction(sender: UISwitch!) {
        print("Switch tapped")
    }

}
