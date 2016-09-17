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

typealias ServiceResponse = (JSON, NSError?) -> Void

class HueBridgeService: NSObject {
    
    let bridgeUrl: String;
    let userName: String = "J6sizwN7qJz7lDNGXKOschliq2ft-7Q85A-sq35Z";
    
    static let singleton = HueBridgeService();
    
    override init(){
        self.bridgeUrl = "192.168.1.118";
        super.init();
    }
    
    init(bridgeUrl: String){
        self.bridgeUrl = bridgeUrl;
        super.init();
    }
    
    func getSystemState(callback: (JSON, NSError?) -> ()){
        //let url = String(format: "%@/api/%@", bridgeUrl, userName);
        let url:String = "https://jsonplaceholder.typicode.com/posts";
        makeHTTPGetRequest(url, callback: callback);
    }
    
    
    func makeHTTPGetRequest(path: String, callback:ServiceResponse){
        let url = NSURL(string: "http://express.heartrails.com/api/json?method=getPrefectures")
        let request = NSURLRequest(URL: url!)
        do{
            let data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: nil)
            let hoge = JSON(data: data)
            print(hoge)
        }catch {
            print(error);
            print("error!!!!!JFJFJFJFJF");
        }
        
    }
    
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
