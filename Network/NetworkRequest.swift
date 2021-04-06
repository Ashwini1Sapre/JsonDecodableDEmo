//
//  NetworkRequest.swift
//  JsonDecodableDEmo
//
//  Created by Knoxpo MacBook Pro on 06/04/21.
//

import Foundation


class NetworkRequest {
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
   
   
    func execute(withCompletion completion: @escaping (Data?) -> Void) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data:Data?, _, _) -> Void in
            DispatchQueue.main.async {
                completion(data)
            }
        })
        task.resume()
      }
    
    
    func execute1(withCompletion completion: @escaping (Data?) -> Void) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data:Data?, _, _) -> Void in
            DispatchQueue.main.async {
                completion(data)
            }
         
        })
        
        task.resume()
        
        
        
    }

}
