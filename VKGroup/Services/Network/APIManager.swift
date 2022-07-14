//
//  APIManager.swift
//  VKGroup
//
//  Created by Ivan Kopiev on 14.07.2022.
//

import UIKit

typealias ServicesBlock = ([[String:Any]]?) -> Void

protocol API: AnyObject {
    var network: Networkable { get set }
    func getServices(copmletion: @escaping ServicesBlock)
}

class APIManager: API {
    
    var network: Networkable = Network(config: .default)

    func getServices(copmletion: @escaping ServicesBlock) {
        guard let request = APIType.services.request  else {
            DispatchQueue.main.async { copmletion(nil) }
            return
        }
        network.sendRequest(request: request) { resp in
            let array = resp?[d: .body][ad: .services].map { item -> [String:Any] in
                var element = [String:Any]()
                element[s:. reuse] = ServiceCell.reuseId
                element[d: .data] = item
                return element
            }
            
            DispatchQueue.main.async { copmletion(array) }
        }
    }
    
    init(network: Networkable = Network(config: .default)) {
        self.network = network
    }
}

