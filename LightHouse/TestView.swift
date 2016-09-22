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
    var selectedUIColor:UIView = UIView();
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        initialize();
    }
    
    override init(frame: CGRect){
        super.init(frame: frame);
        initialize();
    }
    func initialize(){
        EventBus.singleton.register(EventNames.HsbColorPickerColorSelected.rawValue,
                                    callback: self.handleHsbColorPickerChange);
        var lightSwitch = UISwitch(frame: CGRect(
            x: 0,
            y: 10,
            width: Style.LightSwitch.switchWidth,
            height: Style.LightSwitch.switchHeight));
        lightSwitch.backgroundColor = .blueColor();
        
        lightSwitch.addTarget(self, action: #selector(lightSwitchAction), forControlEvents: .AllTouchEvents);
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
        
        selectedUIColor = UIView(frame: CGRect(
            x: 0,
            y: 290,
            width: 200,
            height: 20
            ));
        
        selectedUIColor.backgroundColor = UIColor(hue: CGFloat(2), saturation: CGFloat(100), brightness: CGFloat(100), alpha: CGFloat(1));
        self.addSubview(selectedUIColor);
    }
    
    func lightSwitchAction(sender: UISwitch!) {
        print("Switch tapped")
        
    }
    
    func hsbColorPickerAction(sender: HSBColorPicker!){
        print("hsbColorPickerAction");
    }
    
    func handleHsbColorPickerChange(data:AnyObject){
        print("handleHsbColorPickerChange called");
        let color = data as! UIColor;
        selectedUIColor.backgroundColor = color;
        
    }
}
