//
//  ViewController.swift
//  LightHouse
//
//  Created by Jason McAffee on 9/17/16.
//  Copyright © 2016 Jason McAffee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //@IBOutlet weak var getStateButton: UIButton!
    //@IBOutlet weak var debugTextView: UITextView!
    
    //displays state of all lights
    var lightSwitchesScrollView: LightSwitchesScrollView?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        //self.debugTextView.text = "";
       // self.view.userInteractionEnabled = false;
        //getSystemStateAndDrawUI();
        //showModal();
        EventBus.singleton.register("jsonData", callback: self.handleJsonDataEvent);
        EventBus.singleton.register("light model changed", callback: self.handleLightModelChangeEvent);
    }
    
    override func viewDidAppear(animated: Bool) {
        showModal();
    }
    
    /**
     * asynchronously calls the Hue Bridge to get the state of all bulbs, groups, etc.
     * Once system state is retrieved, paints the screen.
    */
    func getSystemStateAndDrawUI(){
        //view.userInteractionEnabled = true;
        var testView = TestView(frame: view.frame);
        
        self.view.addSubview(testView);
        //self.view.bringSubviewToFront(testView);
//        HueBridgeService.singleton.getSystemState({ (systemState: SystemState) in
//            self.createLightSwitchesScrollView(systemState.lightArray);
//        });
    }
    
    /**
     * Creates and attaches a LightSwitchesScrollView view which displays state of all lights.
    */
    func createLightSwitchesScrollView(lights:Array<Light>){
        dispatch_sync(dispatch_get_main_queue(), {
            self.lightSwitchesScrollView = LightSwitchesScrollView(lights: lights, frame: self.view.bounds);
            self.view.addSubview(self.lightSwitchesScrollView!);
            
        });
    }
    
    func lightSwitchAction(){
        
    }

    /**
     * Gets the state from the Hue Bridge (/api endpoint)
    */
//    @IBAction func getStateButtonTouched(sender: UIButton) {
//        HueBridgeService.singleton.getSystemState({ (systemState: SystemState) in
//            
//        });
//    }
    
    /**
     * for debugging purposes. displays received json data in a text view.
    */
    func handleJsonDataEvent(data: AnyObject){
        if let jsonString = data as AnyObject? as? String?{
            dispatch_sync(dispatch_get_main_queue(), {
                //self.debugTextView.text = self.debugTextView.text + "\n" + jsonString!;
            });
            
        }
    }
    
    /**
     * When a light model changes (e.g. turned off, color change) we need to call the bridge service, sending it
     * the desired state, so that state can be reflected in the real world.
    */
    func handleLightModelChangeEvent(data: AnyObject){
        if let lightModel = data as AnyObject? as? Light?{
            HueBridgeService.singleton.setLightState(lightModel!, callback: { (light: Light) in
                
            });
        }
    }
    
    func showModal(){
        let modalView = UIView(frame: CGRect(
            x: 0,
            y: 0,
            width: 200,
            height: 200
            ));
        modalView.backgroundColor = UIColor(hue: CGFloat(2), saturation: CGFloat(100), brightness: CGFloat(100), alpha: CGFloat(1));
        
        let modalViewController = ModalViewController()
        modalViewController.setTheModalView(modalView);
        
        modalViewController.modalPresentationStyle = .OverCurrentContext
        presentViewController(modalViewController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

