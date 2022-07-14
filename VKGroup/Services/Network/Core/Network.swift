//
//  Network.swift
//  VKGroup
//
//  Created by Ivan Kopiev on 14.07.2022.
//

import Foundation

typealias CompletionBlock = ([String:Any]?) -> Void

protocol Networkable: AnyObject {
    func sendRequest(request: URLRequest, completion: @escaping CompletionBlock)
}

class Network: Networkable {
    
    private let session: URLSession!
    
    func sendRequest(request: URLRequest, completion: @escaping CompletionBlock) {
        session.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil, let dict = try? JSONSerialization.jsonObject(with: data) as? [String:Any] else {
                completion(nil)
                return
            }
            completion(dict)
        }.resume()
    }
    
    init(config: URLSessionConfiguration = .default) {
        session = URLSession(configuration: config)
    }
}
