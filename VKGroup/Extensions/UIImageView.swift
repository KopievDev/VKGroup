//
//  UIImageView.swift
//  VKGroup
//
//  Created by Ivan Kopiev on 14.07.2022.
//

import UIKit

extension UIImageView {
    
    func setImage(urlString: String) {
        let cache = URLCache.shared
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        if cache.cachedResponse(for: request) != nil {
            loadImageFromCache(imageURL: url)
        } else {
            downloadImage(imageURL: url)
        }
    }
    
    private func downloadImage(imageURL: URL) {
        let request = URLRequest(url: imageURL)
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async { self.image = image }
        }.resume()
    }
    
    private func loadImageFromCache(imageURL: URL) {
        let cache = URLCache.shared
        let request = URLRequest(url: imageURL)
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async { self.image = image }
            }
        }
    }
    
}

