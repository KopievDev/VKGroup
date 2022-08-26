//
//  APIManager.swift
//  VKGroup
//
//  Created by Ivan Kopiev on 14.07.2022.
//

import UIKit

typealias ArrayOfDict = ([[String:Any]]?) -> Void

protocol API: AnyObject {
    var network: Networkable { get set }
    func getServices(copmletion: @escaping ArrayOfDict)
}

class APIManager: API {
    
    var network: Networkable = Network(config: .default)

    func getServices(copmletion: @escaping ArrayOfDict) {
        guard let request = APIType.services.request else {
            copmletion(nil)
            return
        }
        network.send(request: request) { [weak self] resp in
            guard let self = self else { return }
            let array = resp?[d: .body][ad: .services].map { self.create(cellId: ServiceCell.reuseId, data: $0) }
            DispatchQueue.main.async { copmletion(array) }
        }
    }
    
    init(network: Networkable = Network(config: .default)) {
        self.network = network
    }
}

private extension APIManager {
    
    func create(cellId: String, data: [String:Any]) -> [String:Any] {
        var element = [String:Any]()
        element[s:. reuse] = ServiceCell.reuseId
        element[d: .data] = data
        return element
    }
}
