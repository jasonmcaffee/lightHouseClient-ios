//
//  HueBridgeService.swift
//  lightHouse
//
//  Created by Jason McAffee on 9/10/16.
//  Copyright © 2016 Jason McAffee. All rights reserved.
//

import SwiftyJSON
import Foundation

//Response from generic performHttpRequestWithJSONResponse, etc.
typealias ServiceResponse = (JSON, ErrorType?) -> Void

typealias RequestAndSession = (request: NSMutableURLRequest, session: NSURLSession);

/**
 * All communication with the Hue Bridge API are done through this service.
 * 
 * TODO: handle error json
 * [
    {
        "error": {
            "type": 7,
            "address": "/lights/12/state/bri",
            "description": "invalid value, 2543 }, for parameter, bri"
        }
    },
    {
        "success": {
            "/lights/12/state/on": true
        }
    }
 ]
 *
 */
class HueBridgeService: NSObject {
    
    let bridgeUrl: String; //http://192.168.1.118
    let userName: String = "J6sizwN7qJz7lDNGXKOschliq2ft-7Q85A-sq35Z";
    
    static let singleton = HueBridgeService();
    
    override init(){
        self.bridgeUrl = "http://192.168.1.118";
        super.init();
    }
    
    init(bridgeUrl: String){
        self.bridgeUrl = bridgeUrl;
        super.init();
    }
    
    func buildApiUrl(path: String) -> String{
        let url = String(format: "%@/api/%@/%@", bridgeUrl, userName, path);
        return url;
    }
    
    /**
     * Calls GET on the /api endpoint, retrieving the state of lights, groups, schedules, etc
     *
    */
    func getSystemState(callback: (SystemState) -> ()){
        //let url = String(format: "%@/api/%@", bridgeUrl, userName);
        let url = buildApiUrl("");
        let systemState = SystemState();
        
        let requestAndSession = createRequestAndSession(url);
        setRequestAsJson(requestAndSession.request);
        performHttpRequestWithJSONResponse(requestAndSession.request, session: requestAndSession.session, callback: { (json:JSON, error:ErrorType?) in
            systemState.populateFromJson(json);
            callback(systemState);
            let systemStateJson = systemState.toJsonString();
            EventBus.singleton.notify(EventNames.JsonData.rawValue, data: systemStateJson);
        });
    }
    
    /**
     * Sends the light json via PUT, so whatever state values this has should be reflected in reality after this
     * call completes.
    */
    func setLightState(light:Light, callback: (Light)->()){
        //{{hueBridgeUrl}}/api/{{bridgeUserName}}/lights/12/state
        let path = String(format: "lights/%@/state", light.key!);
        let url = buildApiUrl(path);
        
        let requestAndSession = createRequestAndSession(url);
        setRequestAsJson(requestAndSession.request);
        requestAndSession.request.HTTPMethod = "PUT";
        
        let jsonRequestBody = light.state?.toSetStateJsonFormat();//light.state?.toJsonString();
        setRequestBody(requestAndSession.request, body: jsonRequestBody!);
        
        performHttpRequestWithJSONResponse(requestAndSession.request, session: requestAndSession.session) { (jsonResponse, error) in
            EventBus.singleton.notify(EventNames.JsonData.rawValue, data: jsonResponse.rawString()!);
        }
        
    }
    
    /**
     * Creates request and session objects used to perform http requests.
    */
    func createRequestAndSession(path: String) -> RequestAndSession{
        let request = NSMutableURLRequest(URL: NSURL(string: path)!);
        let session = NSURLSession.sharedSession();
        return (request: request, session: session);
    }
    
    func setRequestBody(request: NSMutableURLRequest, body:String){
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding);
    }
    
    /**
     * Adds headers to accept and send JSON data.
    */
    func setRequestAsJson(request: NSMutableURLRequest){
        request.addValue("application/json", forHTTPHeaderField: "Content-Type");
        request.addValue("application/json", forHTTPHeaderField: "Accept");
    }
    
    /**
     Converts response into a Swifty JSON object
    */
    func performHttpRequestWithJSONResponse(request: NSMutableURLRequest, session: NSURLSession, callback: ServiceResponse){
        
        performHttpRequest(request, session: session) { (data, response, error) in
            let jsonResponse = JSON(data: data!);
            callback(jsonResponse, error);
        }
    }
    
    /**
     * asynchronously performs the http request, calling the responseHandler param once completed.
    */
    func performHttpRequest (request: NSMutableURLRequest, session: NSURLSession, responseHandler: (NSData?, NSURLResponse?, NSError?) ->()){
        let task = session.dataTaskWithRequest(request, completionHandler: responseHandler);
        task.resume()
    }
}







//
//func makeHTTPGetRequest(path: String, callback:ServiceResponse){
//    let request = NSMutableURLRequest(URL: NSURL(string: path)!)
//    let session = NSURLSession.sharedSession()
//    
//    //request.HTTPMethod = "GET"
//    
//    //let params = ["username":"username", "password":"password"] as Dictionary<String, String>
//    
//    //request.HTTPBody = try? NSJSONSerialization.dataWithJSONObject(params, options: [])
//    
//    // request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//    //request.addValue("application/json", forHTTPHeaderField: "Accept")
//    let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
//        print("Response: \(response)");
//        let jsonResponse = JSON(data: data!);
//        callback(jsonResponse, error);
//    });
//    
//    task.resume()
//}



