//
//  APIType.swift
//  VKGroup
//
//  Created by Ivan Kopiev on 14.07.2022.
//

import Foundation

enum APIType {
    
    case services

    var baseURL: URL? { urlComponents.url }
    
    var path: String {
        switch self {
        case .services: return "sirius/result.json"
        }
    }
    
    var urlComponents: URLComponents {
        var urlComp = URLComponents()
        urlComp.scheme = "https"
        urlComp.host = "publicstorage.hb.bizmrg.com"
        return urlComp
    }
    
    var request: URLRequest? {
        guard let url = URL(string: path, relativeTo: baseURL) else { return nil }
        var request = URLRequest(url: url)
        switch self {
        case .services:
            request.httpMethod = "GET"
            return request
        }
    }
}
