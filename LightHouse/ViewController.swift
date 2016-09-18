//
//  ViewController.swift
//  LightHouse
//
//  Created by Jason McAffee on 9/17/16.
//  Copyright © 2016 Jason McAffee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Properties
    
    @IBOutlet weak var getStateButton: UIButton!
    
    @IBOutlet weak var debugTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.debugTextView.text = "";
        EventBus.singleton.register("jsonData", callback: self.handleJsonDataEvent);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Actions

    @IBAction func getStateButtonTouched(sender: UIButton) {
        print("BUTTON PRESSED");
        HueBridgeService.singleton.getSystemState({ (lightArray: Array<Light>) in
            
        });
        
    }
    
    
    func handleJsonDataEvent(data: AnyObject){
        if let jsonString = data as AnyObject? as? String?{
            dispatch_sync(dispatch_get_main_queue(), {
                self.debugTextView.text = self.debugTextView.text + "\n" + jsonString!;
            });
            
        }
    }
}

