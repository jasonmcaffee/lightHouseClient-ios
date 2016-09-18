//
//  EventBus.swift
//  lightHouse
//
//  Created by Jason McAffee on 9/11/16.
//  Copyright © 2016 Jason McAffee. All rights reserved.
///

import Foundation

typealias Callback = (data: AnyObject) -> Void;
typealias CallbackContainer = (id:Int, callback:Callback);

/**
 * The primary means of communication between classes/modules is an event bus, where modules can register callbacks
 */
class EventBus: NSObject{
    //dictionary key:value where key is event name string
    //and value is array of callbacks.
    var registeredEvents = [String: Array<CallbackContainer>]();
    //private var registeredEvents = [String: Array<Handler( callback: (data:AnyObject) -> Void )>]();
    
    var callbackId = 0;
    //EventBus.bus is how singletons are done in swift.
    static let singleton = EventBus();
    
    //This prevents others from using the default '()' initializer for this class.
    override init(){}
    
    func register(eventName: String, callback: Callback) -> Int{
        var callbackContainers = registeredEvents[eventName] ?? []
        //callbacks.append(callback)
        //registeredEvents[eventName] = callbacks
        callbackId += 1;
        callbackContainers.append( (id: callbackId, callback: callback) );
        registeredEvents[eventName] = callbackContainers;
        return callbackId;
    }
    
    func unregister(callbackId: Int){
        for (eventName, var callbackContainers) in registeredEvents{
            let matches = callbackContainers.filter({ (cbContainer: CallbackContainer) -> Bool in
                return cbContainer.id == callbackId;
            });
            for match in matches{
                //callbackContainers.indexOf({$0.id == match.id})
                let index = callbackContainers.indexOf({$0.id == match.id}) ?? -1;
                print("removing at index:");
                print(index);
                //callbackContainers.remove(at: index);
                callbackContainers.removeAtIndex(index);
            }
            registeredEvents[eventName] = callbackContainers;
            
        }
    }
    
    func notify(eventName: String, data: AnyObject){
        if(registeredEvents[eventName] == nil){return}
        guard let callbackContainers = registeredEvents[eventName]! as? Array<CallbackContainer> else{
            return;
        }
        for callbackContainer in callbackContainers{
            print("calling callback for event: " + eventName)
            callbackContainer.callback(data: data);
        }
    }
}
