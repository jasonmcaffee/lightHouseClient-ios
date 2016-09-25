//
//  ColorPickerModal.swift
//  LightHouse
//
//  Created by Jason McAffee on 9/21/16.
//  Copyright © 2016 Jason McAffee. All rights reserved.
//

import Foundation
import UIKit

class ColorPickerModal: UIView{
    
    var selectedUIColor = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func initialize(){
        EventBus.singleton.register(EventNames.HsbColorPickerColorSelected.rawValue,
                                    callback: self.handleHsbColorPickerChange);
        
        var closeButton = UIButton(frame: CGRect(
            x: 0,
            y: 100,
            width: 100,
            height: 100
        ));
        closeButton.addTarget(self, action: #selector(handleCloseButtonTouch), forControlEvents: .TouchDown)
        
        addSubview(closeButton);
        
        
    }
    
    func handleCloseButtonTouch(sender:UIButton!){
        
    }
    
    func handleHsbColorPickerChange(data:AnyObject){
        print("ColorPickerModal.handleHsbColorPickerChange called");
        let color = data as! UIColor;
        selectedUIColor.backgroundColor = color;
    }
}