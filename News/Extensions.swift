//
//  Extensions.swift
//  News
//
//  Created by Hovhannes Stepanyan on 3/25/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import UIKit

extension UIImageView {
    /**
        load image async from given url
        while image downloading, use thumbnail image
        after gave image call completion block, also after fail
    */
    public func setImageFrom(_ url: URL!, thumbnail: UIImage?, completion:((UIImage?, Error?) -> Void)?) {
        self.image = thumbnail
        guard let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) else {
            URLSession.shared.dataTask(with: url) {[unowned self] (data, response, error) in
                if error == nil {
                    if let _data = data, let _response = response {
                        guard let image = UIImage(data: _data) else { return }
                        DispatchQueue.main.async {
                            self.image = image
                            let URLCachedResponse = CachedURLResponse(response: _response, data: _data)
                            URLCache.shared.storeCachedResponse(URLCachedResponse, for: URLRequest(url: url))
                            if let handler = completion {
                                handler(image, nil)
                            }
                        }
                    }
                } else {
                    if let handler = completion {
                        handler(nil, error)
                    }
                }
                }.resume()
            return
        }
        if let anImage = UIImage(data: cachedResponse.data) {
            image = anImage
            if let handler = completion {
                handler(image, nil)
            }
        }
    }
    
    public func setImageFrom(_ url: URL!, thumbnail: UIImage?) {
        self.setImageFrom(url, thumbnail: thumbnail, completion: nil)
    }
    
    public func setImageFrom(_ url: URL!, completion:((UIImage?, Error?) -> Void)?) {
        self.setImageFrom(url, thumbnail: nil, completion: completion)
    }
    
    public func setImageFrom(_ url: URL!) {
        self.setImageFrom(url, thumbnail: nil, completion: nil)
    }
    
    public func correctSizeForAspectRatio() {
        let imagesize = self.image?.size
        let aspectRatio = Float((imagesize?.width)!) / Float((imagesize?.height)!)
        var frame = self.frame
        frame.size.height = CGFloat(Float(frame.width) / aspectRatio)
        self.frame = frame
    }
}

extension UIViewController {
    class func instantiateViewController<T>() -> T {
        let mainStoryboard = UIStoryboard.main()
        let id = String(describing: T.self).components(separatedBy: ".").last
        return mainStoryboard.instantiateViewController(withIdentifier: id!) as! T
    }
}

extension UIStoryboard {
    class func main() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}

extension UIColor {
    /**
        return random color
    */
    open class var random: UIColor {
        get {
            let red = Float(arc4random_uniform(255)) / 255.0;
            let green = Float(arc4random_uniform(255)) / 255.0;
            let blue = Float(arc4random_uniform(255)) / 255.0;
            return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1)
        }
    }
}
