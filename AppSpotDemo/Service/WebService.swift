//
//  WebService.swift
//  AppSpotDemo
//
//  Created by Pankaj on 10/01/19.
//

import Foundation


struct Post:Encodable{
    let emailId:String
}

struct Response<T> {
    let url:URL
    let postData:Post
    let parse:(Data)->T?
}


struct WebService {
    
    func callPost<T>(response:Response<T>,completionHandler:@escaping (T?)->Void){
        
        var request = URLRequest(url: response.url)
        request.httpMethod = "POST"
        
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        let jsonData = try? JSONEncoder().encode(response.postData)
        request.httpBody = jsonData
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        
        let task = session.dataTask(with: request) { (responseData, jsonResponse, responseError) in
            guard responseError == nil else {
                return
            }
            if let data = responseData{
                DispatchQueue.main.async {
                    completionHandler(response.parse(data))
                }
                
            } else {
                print("no readable data received in response")
            }
        }
        task.resume()
        
    }
    
}

