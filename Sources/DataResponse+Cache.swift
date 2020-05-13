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


public extension AFDataResponse where Success == JSON {
    
    /// 解码过的缓存数据
    func cachedValue(options: JSONSerialization.ReadingOptions = .allowFragments) -> Any? {
        guard let data = self.cachedData else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: options)
    }
}


public extension AFDataResponse where Success: Decodable {
    
    /// 解码过的缓存数据
    func cachedValue(decoder: DataDecoder = JSONDecoder()) -> Success? {
        guard let data = self.cachedData else { return nil }
        return try? decoder.decode(Success.self, from: data)
    }
}
