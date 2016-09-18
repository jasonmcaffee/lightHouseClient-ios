//
//  HueBridgeService.swift
//  lightHouse
//
//  Created by Jason McAffee on 9/10/16.
//  Copyright © 2016 Jason McAffee. All rights reserved.
//

//import Foundation
import SwiftyJSON
import Foundation
//Response from generic makeHttpGetCall, etc.
typealias ServiceResponse = (JSON, ErrorType?) -> Void

/**
 * All communication with the Hue Bridge API are done through this service.
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
        return self.bridgeUrl + path;
    }
    
    
    func getSystemState(callback: (SystemState) -> ()){
        let url = String(format: "%@/api/%@", bridgeUrl, userName);
        let systemState = SystemState();
        
        makeHTTPGetRequest(url) { (json: JSON, error: ErrorType?) in
            if let lightsJson = json["lights"].dictionary{
                for(key, lightJson):(String, JSON) in lightsJson{
                    
                    let light = Light(key: key, json: lightJson.rawString());
                    systemState.lightArray.append(light);
                    
                    let lightToJson = light.toJsonString();
                    EventBus.singleton.notify("jsonData", data: lightToJson);
                    
                }
            }else{
                print("Error getting system state from Hue Bridge: " + error.debugDescription);
            }
            
            callback(systemState);
            
        }
    }
    
    func makeHTTPGetRequest(path: String, callback:ServiceResponse){
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        let session = NSURLSession.sharedSession()
        //request.HTTPMethod = "GET"
        
        //let params = ["username":"username", "password":"password"] as Dictionary<String, String>
        
        //request.HTTPBody = try? NSJSONSerialization.dataWithJSONObject(params, options: [])
        
       // request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            print("Response: \(response)");
            let jsonResponse = JSON(data: data!);
            callback(jsonResponse, error);
        });
        
        task.resume()
        
    }
    
//    func makeHTTPGetRequest(path: String, callback:ServiceResponse){
//        let url = NSURL(string: "http://express.heartrails.com/api/json?method=getPrefectures")
//        let request = NSURLRequest(URL: url!)
//        let jsonResponse: JSON;
//        do{
//            let data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: nil)
//            jsonResponse = JSON(data: data)
//            print(jsonResponse)
//            callback(jsonResponse, nil);
//        }catch {
//            print(error);
//            print("error!!!!!JFJFJFJFJF");
//            callback(nil, error);
//        }
//        
//    }
    
//    func makeHTTPGetRequest(path: String, callback: ServiceResponse) {
//        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
//        
//        let session = NSURLSession.sharedSession()
//        
//        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
//            let json:JSON = JSON(data: data!)
//            callback(json, error)
//        })
//        task.resume()
//    }
    
}
