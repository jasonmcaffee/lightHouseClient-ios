//
//  ModalViewController.swift
//  LightHouse
//
//  Created by Jason McAffee on 9/21/16.
//  Copyright © 2016 Jason McAffee. All rights reserved.
//

import Foundation
import UIKit

class ModalViewController: UIViewController {
    var modalView = UIView();
    
    func setTheModalView(modalView:UIView){
        self.modalView = modalView;
    }
    override func viewDidLoad() {
        view.backgroundColor = UIColor.blueColor()//UIColor.clearColor()
        //view.opaque = false
        
        self.view.addSubview(self.modalView);
    }
}