//
//  TestView.swift
//  LightHouse
//
//  Created by Jason McAffee on 9/19/16.
//  Copyright © 2016 Jason McAffee. All rights reserved.
//

import Foundation
import UIKit

class TestView : UIView{
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override init(frame: CGRect){
        super.init(frame: frame);
        var lightSwitch = UISwitch(frame: CGRect(
            x: 0,
            y: 10,
            width: Style.LightSwitch.switchWidth,
            height: Style.LightSwitch.switchHeight));
        lightSwitch.backgroundColor = .blueColor();
        
        lightSwitch.addTarget(self, action: #selector(lightSwitchAction), forControlEvents: .TouchUpInside);
        self.bringSubviewToFront(lightSwitch);
        self.addSubview(lightSwitch);
        
        var hsbColorPicker = HSBColorPicker(frame: CGRect(
            x: 0,
            y: 40,
            width: 200,
            height: 200
            ));
        
        hsbColorPicker.addTarget(self, action: #selector(hsbColorPickerAction), forControlEvents: .TouchDown);
        self.addSubview(hsbColorPicker);
        
    }
    
    func lightSwitchAction(sender: UISwitch!) {
        print("Switch tapped")
        
    }
    
    func hsbColorPickerAction(){
        print("hsbColorPickerAction");
    }
}
