//
//  ImageCacheManager.swift
//  DongJibSa
//
//  Created by heyji on 2023/08/05.
//

import UIKit

class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() { }
}

extension UIImageView {
    func setImageURL(_ url: String) {
        let cacheKey = NSString(string: url)
        
        if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
            DispatchQueue.main.async {
                self.image = cachedImage
            }
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: url) {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let _ = error {
                        DispatchQueue.main.async {
                            self.image = UIImage()
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        if let data = data, let image = UIImage(data: data) {
                            ImageCacheManager.shared.setObject(image, forKey: cacheKey)
                            self.image = image
                        }
                    }
                }.resume()
            }
        }
    }
}
