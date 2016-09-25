//
//  LightSwitchesScrollView.swift
//  LightHouse
//
//  Created by Jason McAffee on 9/18/16.
//  Copyright © 2016 Jason McAffee. All rights reserved.
//

import UIKit

/**
 * Container for LightSwitch components, where each LightSwitch represents a real world light.
 * Allows for scrolling the LightSwitch components.
 */
class LightSwitchesScrollView: UIView {

    //all subviews of this view will be contained inside this scrollview.
    var scrollView: UIScrollView?;
    var scrollViewSubView: UIView?;
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    init(lights: Array<Light>, frame: CGRect){
        super.init(frame: frame);
        //self.userInteractionEnabled = false;
        self.createScrollView();
        self.createUILightSwitches(lights);
    }
    
    
    /**
     * Creates a UIScrollView component which takes up the entire area of this view.
     * All ui components for this view should be contained in the scrollview.
    */
    func createScrollView(){
        self.scrollView = UIScrollView(frame: self.bounds);
        self.scrollView!.backgroundColor = UIColor(patternImage: UIImage(named: "bg.jpg")!)//UIColor.blackColor();
        self.scrollView!.autoresizingMask = [.FlexibleWidth, .FlexibleHeight];

       
//        var singleTap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture));
//        singleTap.cancelsTouchesInView = false;
        //self.scrollView?.addGestureRecognizer(singleTap);
        //self.scrollView!.canCancelContentTouches = false;
        
        self.addSubview(self.scrollView!);
    }
    
    func handleTapGesture(){
        print("scrollviewTap");
    }
    
    /**
     * In order to get dynamic content size for the scrollview (ie how large it thinks it is in total),
     * we must add the heights of all subviews together.
    */
    func resizeScrollViewContentSize(){
        var contentRect = CGRectZero;
        for view in (self.scrollView?.subviews)! {
            contentRect = CGRectUnion(contentRect, view.frame);
        }
        self.scrollView!.contentSize = contentRect.size;
    }
    
    /**
     * Iterates over the passed in lights array, creating a LightSwitch component for each, and adds it to the scrollview.
    */
    func createUILightSwitches(lights:Array<Light>){
        var lastYForLightSwitch = 10 + Int(self.scrollView!.bounds.origin.y); //+ Int(self.bounds.origin.y);
            
            for light:Light in lights{
//                let lightSwitch = LightSwitch(light: light, frame: CGRect(
//                    x: 0,
//                    y: lastYForLightSwitch,
//                    width: 200,
//                    height: 50));
                let lightSwitch = LightSwitch(light: light, frame: CGRect(
                    x: 0,
                    y: lastYForLightSwitch,
                    width: Int(self.bounds.width),
                    height: 100));
                
                //lightSwitch.addTarget(self, #selector(handleLightSwitchTouch), forControlEvents: .TouchUpInside);
                self.scrollView!.addSubview(lightSwitch);
                
                lastYForLightSwitch += Style.LightSwitch.switchHeight;
            }
        
        //var button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 25));
        //button.backgroundColor = UIColor.blueColor()
        //button.addTarget(self, action: #selector(handleTapGesture), forControlEvents: .TouchUpInside);
        
        //scrollView!.addSubview(button);
        
        self.resizeScrollViewContentSize();
    }
    func handleLightSwitchTouch(){
        print("light switch touch");
    }
    
//    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
//        print("LightSwitchesScrollView.pointInside called: " + event.debugDescription)
//        
//        for subview in self.subviews {
//            if (subview.hitTest(point, withEvent: event) != nil){
//                return true;
//            }
//        }
//        return false
//    }

}




//dispatch_sync(dispatch_get_main_queue(), {
//let imageView = UIImageView(image: UIImage(named: "bg.jpg"));
//imageView.contentMode = .ScaleToFill;//.ScaleAspectFill;
//self.scrollView!.contentSize = imageView.bounds.size;
