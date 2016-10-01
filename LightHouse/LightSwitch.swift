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
    var selectedUIColor = UIView()
    var light:Light = Light();

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    init(light: Light, frame: CGRect){
        super.init(frame: frame);
        updateUIToReflectLightModel(light);
        //self.userInteractionEnabled = true;
    }
    
    /**
     * Uses the passed in light model parameter to set self.light, and have the light model be reflected in the UI.
    */
    func updateUIToReflectLightModel(light:Light){
        self.light = light;
        
        //self.backgroundColor = UIColor.brownColor()
        //self.userInteractionEnabled = false;
        var label = UILabel(frame: CGRectMake(
            0,
            0,
            CGFloat(Style.LightSwitch.labelWidth),
            CGFloat(Style.LightSwitch.labelHeight)))
        //label.center = CGPointMake(160, 284)
        label.textAlignment = NSTextAlignment.Left
        label.text = light.name!;
        //label.backgroundColor = UIColor.whiteColor();
        label.sizeToFit();
        addSubview(label);
        
        let lightSwitch = UISwitch();
        lightSwitch.frame.origin.x = CGFloat(Style.LightSwitch.labelWidth);
        lightSwitch.frame.origin.y = self.bounds.origin.y;

        lightSwitch.sizeToFit()
        
        //lightSwitch.backgroundColor = .blueColor();
        
        lightSwitch.addTarget(self, action: #selector(lightSwitchAction), forControlEvents: .TouchUpInside);//TouchUpInside
        
        lightSwitch.setOn((light.state?.on)!, animated: true);
        addSubview(lightSwitch)
        
        
        selectedUIColor = UIView(frame: CGRect(
            x: 0,
            y: 290,
            width: 200,
            height: 20
            ));
        
        selectedUIColor.backgroundColor = UIColor(hue: CGFloat(2), saturation: CGFloat(100), brightness: CGFloat(100), alpha: CGFloat(1));
        //self.addSubview(selectedUIColor);
        
    }
    
    func lightSwitchAction(sender: UISwitch!) {
        print("Switch tapped: " + String(sender.on))
        self.light.state?.on = sender.on;
        EventBus.singleton.notify(EventNames.LightModelChanged.rawValue, data: self.light);
    }
    

}
