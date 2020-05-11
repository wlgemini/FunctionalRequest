//
//  DataResponse+Extension.swift
//  Alamofire
//
//  Created by wangluguang on 2020/5/11.
//

import Foundation
import Alamofire


public extension AFDataResponse {
    
    /// 缓存数据，目前(v0.1.0)重定向过的数据不会被缓存
    var cachedData: Data? {
        guard let request = self.request else { return nil }
        return URLCache.shared.cachedResponse(for: request)?.data
    }
}

public extension AFDataResponse where Success: Decodable {
    
    /// 解码过的缓存数据
    var cachedValue: Success? {
        guard let data = self.cachedData else { return nil }
        return try? JSONDecoder().decode(Success.self, from: data)
    }
}
