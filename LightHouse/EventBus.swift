//
//  EventBus.swift
//  lightHouse
//
//  Created by Jason McAffee on 9/11/16.
//  Copyright © 2016 Jason McAffee. All rights reserved.
///

import Foundation

//callbacks passed to register should follow this method signature
typealias Callback = (data: AnyObject) -> Void;

//contains the unique id for the callback, as well as the callback itself.
typealias CallbackContainer = (id:Int, callback:Callback);

enum EventNames : String{
    case HsbColorPickerColorSelected = "HsbColorPickerColorSelected"
}
/**
 * The primary means of communication between classes/modules is an event bus, where modules can register callbacks
 */
class EventBus: NSObject{
    //dictionary key:value where key is event name string
    //and value is array of callbacks.
    var registeredEvents = [String: Array<CallbackContainer>]();
    
    //unique id returned from register function, so that it can later be passed to unregister.
    var callbackId = 0;
    
    //We only need one instance accessible via EventBus.singleton
    static let singleton = EventBus();
    
    //This prevents others from using the default '()' initializer for this class.
    override init(){}
    
    /**
     * Register the passed in callback so that when notify 'eventName' is called, the passed in callback 
     * will be executed, passing the data associated with the event.
     * @param eventName - unique name of event you wish to subscribe to
     * @param callback - function to be executed when notify('eventName', data) is called
    */
    func register(eventName: String, callback: Callback) -> Int{
        var callbackContainers = registeredEvents[eventName] ?? []
        callbackId += 1;
        callbackContainers.append( (id: callbackId, callback: callback) );
        registeredEvents[eventName] = callbackContainers;
        return callbackId;
    }
    
    /**
     * Prevent callback being fired any longer.
     * @param callbackId - unique id for the callback. returned from register('eventName', ...)
    */
    func unregister(callbackId: Int){
        for (eventName, var callbackContainers) in registeredEvents{
            let matches = callbackContainers.filter({ (cbContainer: CallbackContainer) -> Bool in
                return cbContainer.id == callbackId;
            });
            for match in matches{
                let index = callbackContainers.indexOf({$0.id == match.id}) ?? -1;
                callbackContainers.removeAtIndex(index);
            }
            registeredEvents[eventName] = callbackContainers;
        }
    }
    
    /**
     * all registered callbacks for the eventName will be executed, passing the supplied data.
     * @param eventName - the name of the event to trigger.
     * @param data - data to be passed to registered callbacks for the eventName.
    */
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
