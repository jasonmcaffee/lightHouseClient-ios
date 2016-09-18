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
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.debugTextView.text = "";
        
        //debugging
        EventBus.singleton.register("jsonData", callback: self.handleJsonDataEvent);
    }

    /**
     * Gets the state from the Hue Bridge (/api endpoint)
    */
    @IBAction func getStateButtonTouched(sender: UIButton) {
        HueBridgeService.singleton.getSystemState({ (systemState: SystemState) in
        });
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

