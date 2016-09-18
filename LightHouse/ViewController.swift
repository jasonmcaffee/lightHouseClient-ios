//
//  ViewController.swift
//  LightHouse
//
//  Created by Jason McAffee on 9/17/16.
//  Copyright © 2016 Jason McAffee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var getStateButton: UIButton!
    @IBOutlet weak var debugTextView: UITextView!
    
    @IBOutlet weak var toggleLightSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.debugTextView.text = "";
        
        getSystemStateAndDrawUI();
        //debugging
        EventBus.singleton.register("jsonData", callback: self.handleJsonDataEvent);
    }
    
    func getSystemStateAndDrawUI(){
        HueBridgeService.singleton.getSystemState({ (systemState: SystemState) in
            self.createUILightSwitches(systemState.lightArray);
        });
    }
    func createUILightSwitches(lights:Array<Light>){
//        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
//        button.backgroundColor = .greenColor()
//        button.setTitle("Test Button", forState: .Normal)
//        button.addTarget(self, action: #selector(lightSwitchAction), forControlEvents: .TouchUpInside)
//        
        var lastYForLightSwitch = 0;
        var lightSwitchHeight = 50;
        
        for light:Light in lights{
//            let lightSwitch = UISwitch(frame: CGRect(x: 100, y: 100, width: 100, height: 50));
//            lightSwitch.backgroundColor = .blueColor();
//            lightSwitch.addTarget(self, action: #selector(lightSwitchAction), forControlEvents: .TouchUpInside);
//            
            let lightSwitch = LightSwitch(light: light, frame: CGRect(x: 0, y: lastYForLightSwitch, width: 200, height: 50));
            
            self.view.addSubview(lightSwitch)
            
            lastYForLightSwitch += lightSwitchHeight;
        }
        
    }
    
    func lightSwitchAction(sender: UIButton!) {
        print("Switch tapped")
    }

    /**
     * Gets the state from the Hue Bridge (/api endpoint)
    */
    @IBAction func getStateButtonTouched(sender: UIButton) {
        HueBridgeService.singleton.getSystemState({ (systemState: SystemState) in
            
        });
    }
    
    @IBAction func toggleLightSwitchChanged(sender: AnyObject) {
        
    }
    
    /**
     * for debugging purposes. displays received json data in a text view.
    */
    func handleJsonDataEvent(data: AnyObject){
        if let jsonString = data as AnyObject? as? String?{
            dispatch_sync(dispatch_get_main_queue(), {
                self.debugTextView.text = self.debugTextView.text + "\n" + jsonString!;
            });
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

