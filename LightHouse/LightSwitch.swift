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
       // self.userInteractionEnabled = false;
        setLightState(light);
    }
    
    func setLightState(light:Light){
        self.light = light;
        
        var lightSwitch = UISwitch(frame: CGRect(
            x: Style.LightSwitch.labelWidth,
            y: 0,
            width: Style.LightSwitch.switchWidth,
            height: Style.LightSwitch.switchHeight));
        
        lightSwitch.backgroundColor = .blueColor();
        
        lightSwitch.addTarget(self, action: #selector(lightSwitchAction), forControlEvents: .TouchUpInside);
        
        lightSwitch.setOn((light.state?.on)!, animated: true);
        addSubview(lightSwitch)
        
        var label = UILabel(frame: CGRectMake(
            0,
            0,
            CGFloat(Style.LightSwitch.labelWidth),
            CGFloat(Style.LightSwitch.labelHeight)))
        //label.center = CGPointMake(160, 284)
        label.textAlignment = NSTextAlignment.Left
        label.text = light.name!;
        
        addSubview(label);

    }
    
    func lightSwitchAction(sender: UISwitch!) {
        print("Switch tapped")
        self.light.state?.on = sender.on;
        EventBus.singleton.notify("light model changed", data: self.light);
        
    }
    
//    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
//        print("LightSwitch.pointInside called.");
//        for subview in self.subviews {
//            let hitTestResult = subview.hitTest(point, withEvent: event);
//            if ( hitTestResult != nil){
//                return true;
//            }
//        }
//        return false
//    }

}
