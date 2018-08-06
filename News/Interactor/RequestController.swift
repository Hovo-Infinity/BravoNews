//
//  RequestController.swift
//  News
//
//  Created by Hovhannes Stepanyan on 3/24/18.
//  Copyright © 2018 Hovhannes Stepanyan. All rights reserved.
//

import UIKit

class RequestController: NSObject {
    private var URL:URL!
    private var doCache: Bool = false
    var comletion:(( _ dataTask: URLResponse?, _ response: Data?)->Void)? = nil
    var failure:((_ error:Error)->Void)? = nil
    
    init(url:URL!) {
        super.init()
        URL = url
    }
    
    func doGetRequestWithCache(_ cache: Bool) -> Void {
        doCache = cache
        let request:URLRequest = URLRequest(url: URL, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 3)
        guard let cachedResponse = URLCache.shared.cachedResponse(for: request) else {
            getFromNet(request: request)
            return
        }
        if let handler = comletion {
            handler(cachedResponse.response, cachedResponse.data)
        }
    }
    
    func doGetRequest() {
        doGetRequestWithCache(false)
    }
    
    private func getFromNet(request: URLRequest!) {
        guard var UrlRequest = request else { return }
        UrlRequest.httpMethod = "GET";
        let session:URLSession = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: UrlRequest) {[weak self] (data, URLResponse, err) in
            if err == nil {
                if let handler = self?.comletion {
                    handler(URLResponse, data)
                }
                if let _data = data, let _response = URLResponse, (self?.doCache)! {
                    let URLCachedResponse = CachedURLResponse(response: _response, data: _data)
                    URLCache.shared.storeCachedResponse(URLCachedResponse, for: request)
                }
            } else {
                if let failure = self?.failure {
                    failure(err!)
                }
            }
        }
        dataTask.resume();
    }
}
