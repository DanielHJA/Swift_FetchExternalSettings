//
//  WebService.swift
//  Mapss_DEBUG
//
//  Created by Daniel Hjärtström on 2020-03-05.
//  Copyright © 2020 Daniel Hjärtström. All rights reserved.
//

import UIKit

class WebService<T: Decodable> {

    class func fetch(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.cachePolicy = URLRequest.CachePolicy.returnCacheDataElseLoad
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            if let data: T = data?.decoded() { 
                completion(.success(data))
            }
            
        }.resume()
    }
    
}
