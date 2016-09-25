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
        
        self.backgroundColor = UIColor.brownColor()
        //self.userInteractionEnabled = false;
        var label = UILabel(frame: CGRectMake(
            0,
            0,
            CGFloat(Style.LightSwitch.labelWidth),
            CGFloat(Style.LightSwitch.labelHeight)))
        //label.center = CGPointMake(160, 284)
        label.textAlignment = NSTextAlignment.Left
        label.text = light.name!;
        label.backgroundColor = UIColor.whiteColor();
        label.sizeToFit();
        addSubview(label);
        
        
//        var lightSwitch = UISwitch(frame: CGRect(
//            x: Style.LightSwitch.labelWidth,
//            y: 0,
//            width: Style.LightSwitch.switchWidth,
//            height: Style.LightSwitch.switchHeight));
        var lightSwitch = UISwitch();
        lightSwitch.frame.origin.x = CGFloat(Style.LightSwitch.labelWidth);
        lightSwitch.frame.origin.y = self.bounds.origin.y;
        //lightSwitch.frame.width = self.frame.width;
//        var bounds = CGRect(
//                        x: 0,//CGFloat(Style.LightSwitch.labelWidth),//self.frame.origin.x,
//                        y: 0,//self.frame.origin.y,
//                        width: 210, //CGFloat(Style.LightSwitch.switchWidth),
//                        height: 50 )//CGFloat(Style.LightSwitch.switchHeight))
        //lightSwitch.bounds = bounds;
        //lightSwitch.bounds = self.frame;
        lightSwitch.sizeToFit()
        let x = String(self.frame.origin.x);
        let y = String(self.frame.origin.y);
        print("LightSwitchUIView x: " + x + "  y: " + y)
        
        lightSwitch.backgroundColor = .blueColor();
        
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
        print("Switch tapped")
        self.light.state?.on = sender.on;
        EventBus.singleton.notify(EventNames.LightModelChanged.rawValue, data: self.light);
    }
    
//        override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
//            print("lightswitch pointInside called")
//    
//            for subview in self.subviews {
//                if (subview.hitTest(point, withEvent: event) != nil){
//                    return true;
//                }
//            }
//            return false
//        }
    

}
