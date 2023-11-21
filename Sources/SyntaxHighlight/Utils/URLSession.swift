//
//  File.swift
//  
//
//  Created by BoiseITGuru on 11/21/23.
//

import Foundation

extension URLSession {
    static var withCache: URLSession {
        let config = URLSessionConfiguration.default
        config.urlCache = URLCache(memoryCapacity: 10 * 1024 * 1024, // 10 MB
                                   diskCapacity: 50 * 1024 * 1024,  // 50 MB
                                   diskPath: nil)
        config.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: config)
    }
}
