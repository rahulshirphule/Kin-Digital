//
//  BaseHttpRequest.swift
//  Kin Digital
//
//  Created by Rahul Shirphule on 2019/10/08.
//  Copyright © 2019 Kin Digital. All rights reserved.
//

import UIKit

class BaseHttpRequest: NSObject {
    
    override init() {
    }
    
      func getDataFromServer(baseUrl: String,_ completion: @escaping ([Article]?) -> ()) {
        
        if Reachability.isConnectedToNetwork(){
            let session = URLSession.shared
            let url = URL(string: baseUrl)!
            
            let task = session.dataTask(with: url, completionHandler: { data, response, error in
                
                let decoder = JSONDecoder()
                if(error != nil) {
                    print(error.debugDescription);
                    completion(nil)
                } else {
                    let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                    print(json as Any);
                    do {
                        struct Articles : Codable{let articles:[Article]}
                        let parsed = try decoder.decode(Articles.self, from: data!)
                        let articles = parsed.articles as [Article]?;
                        completion(articles)
                    } catch {
                        print("OOPS")
                        completion(nil);
                    }
                }
            })
            task.resume();
        }else{
            
        }
        
    }
    
}
