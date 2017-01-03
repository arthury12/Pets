////
////  RestApiManager.swift
////  Pets
////
////  Created by Arthur Yu on 11/20/16.
////  Copyright © 2016 Arthur Yu. All rights reserved.
////
//
//import SwiftyJSON
//
//typealias ServiceResponse = (JSON, NSError?) -> Void
//
//class RestApiManager: NSObject {
//    static let sharedInstance = RestApiManager()
//
//    let baseURL = "http://api.petfinder.com/"
//    let key = "7c77a4361a1a1ada2b67a1300b31e6d3"
//    let defaultLocation = "90069"
//    let jsonFormat = "&format=json"
//    
//    /* Endpoints */
//    let petFind = "pet.find?"
//    
//    
//    func getPet(onCompletion: (JSON) -> Void, location: String?) {
//        let currLocation = location ?? defaultLocation
//        let route = baseURL + petFind + "key=" + key + "&location=" + currLocation + jsonFormat
//        print("route: \(route)")
//        
//        makeHTTPGetRequest(onCompletion: { json in
//            onCompletion (json as JSON)
//        }, path: route)
//    }
//    
//    func makeHTTPGetRequest(onCompletion: (JSON) -> Void, path:String) {
//        let request = NSMutableURLRequest(url: NSURL(string: path) as! URL)
//        request.httpMethod = "GET"
//        
//        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
//            if (data != nil) {
//                let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//                let json = JSON(dataString)
//                //print("@@@@JSON: \(json)")
//            } else {
//                print(error)
//            }
//        })
//        task.resume()
//    }
//}
