//
//  AFWrapper.swift
//
//
//  Created by Salman on 14/03/17.
//  Copyright © 2017 Salman. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

class AFWrapper: NSObject {
    class func startNetworkReachabilityObserver(isRechable: @escaping (Bool)->(Void))->(Void) {
        let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
         
        reachabilityManager?.listener = { status in
            
            switch status {
                
            case .notReachable:
                print("The network is not reachable")
                isRechable(false)
                break
            case .unknown :
                print("It is unknown whether the network is reachable")
                isRechable(false)
                break
            case .reachable(.ethernetOrWiFi):
                print("The network is reachable over the WiFi connection")
                isRechable(true)
                break
            case .reachable(.wwan):
                print("The network is reachable over the WWAN connection")
                isRechable(true)
                break
            }
        }
        
        if Connectivity.isConnectedToInternet {
            print("Yes! internet is available.")
            // do some tasks..
            // start listening
            reachabilityManager?.startListening()
        }
        else {
            isRechable(false)
        }
    }
    
    class func requestGETURL(_ strURL: String, params:[String : AnyObject]?, headers : [String : String]? ,success:@escaping (JSON, Any) -> Void, failure:@escaping (NSError) -> Void) {

        Alamofire.request(strURL, method: .get, parameters: params,headers: headers).responseJSON { (responseObject) -> Void in
            
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                let res = responseObject.response?.allHeaderFields
                success(resJson, res as Any)
                
            }
            if responseObject.result.isFailure {
                let error : NSError = responseObject.result.error! as NSError
                failure(error)
            }
        }
    }
    
    class func requestPOSTURL(_ strURL : String, params : [String : AnyObject]?, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (NSError) -> Void){
         
        Alamofire.request(strURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject:DataResponse<Any>) in
            
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error : NSError = responseObject.result.error! as NSError
                failure(error)
            }
        }
    }
    
    class func uploadMultipartFormData(_ strURL : String, params : [String : AnyObject]?,fileName:String, image:UIImage, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (NSError) -> Void){
        Alamofire.upload(multipartFormData:{ multipartFormData in
            for (key, value) in params! {
                multipartFormData.append(String(describing: value).data(using: String.Encoding.utf8)!, withName: key)
                
            }
            multipartFormData.append(UIImageJPEGRepresentation(image, 0.5)!, withName: "image_url", fileName: fileName, mimeType: "image/png")
            
            } , usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: strURL, method: .post, headers: [:], encodingCompletion:{ encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if response.result.isSuccess {
                            let resJson = JSON(response.result.value!)
                            success(resJson)
                        }
                        if response.result.isFailure {
                            let error : NSError = response.result.error! as NSError
                            failure(error)
                        }
                    }
                    
                case .failure(let encodingError):
                    let error = encodingError as NSError
                    
                    failure(error)
                }
        } )
    }
}


