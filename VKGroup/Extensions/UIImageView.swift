//
//  UIImageView.swift
//  VKGroup
//
//  Created by Ivan Kopiev on 14.07.2022.
//

import UIKit

extension UIImageView {
    
    func setImage(urlString: String, withLoader: Bool = true) {
        if withLoader { UIActivityIndicatorView.addLoader(for: self) }
        let cache = URLCache.shared
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        if cache.cachedResponse(for: request) != nil {
            loadImage(on: request, from: cache)
        } else {
            downloadImage(on: request)
        }
    }
    
    private func downloadImage(on request: URLRequest) {
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async { self.set(image: image) }
        }.resume()
    }
    
    private func loadImage(on request: URLRequest, from cache:URLCache) {
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async { self.set(image: image) }
            }
        }
    }
    
    private func set(image: UIImage) {
        self.image = image
        subviews.first { $0.accessibilityLabel == "loader" }?.removeFromSuperview()
    }
}

extension UIActivityIndicatorView {
    
    class func addLoader(for view: UIView) {
        UIActivityIndicatorView().with {
            $0.startAnimating()
            $0.hidesWhenStopped = true
            $0.accessibilityLabel = "loader"
            view.addSubview($0)
            $0.pin(to: view)
        }
    }
}


extension UIView {
    
    func pin(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
