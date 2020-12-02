//
//  DataResponse+Extension.swift
//

import Foundation
import Alamofire


public extension Alamofire.AFDataResponse {
    
    /// 缓存数据(URLCache.shared)，重定向过的数据不会被缓存
    var cachedData: Data? {
        guard let request = self.request else { return nil }
        return URLCache.shared.cachedResponse(for: request)?.data
    }
}


public extension Alamofire.AFDataResponse where Success == JSON {
    
    /// 解码过的缓存数据(URLCache.shared)，重定向过的数据不会被缓存
    func cachedValue(options: JSONSerialization.ReadingOptions = .allowFragments) -> Any? {
        guard let data = self.cachedData else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: options)
    }
}


public extension Alamofire.AFDataResponse where Success: Decodable {
    
    /// 解码过的缓存数据(URLCache.shared)，重定向过的数据不会被缓存
    func cachedValue(decoder: Alamofire.DataDecoder = JSONDecoder()) -> Success? {
        guard let data = self.cachedData else { return nil }
        return try? decoder.decode(Success.self, from: data)
    }
}
