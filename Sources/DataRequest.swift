//
//  DataRequest.swift
//

import Foundation
import Alamofire


/// GET (SELECT): 从服务器取出资源
public struct GET<Input, Output>: DataRequestable {

    public var additionalHeaders: Alamofire.HTTPHeaders?
    
    public var timeoutInterval: TimeInterval?
    
    public var credential: URLCredential?
    
    public var redirectHandler: Alamofire.RedirectHandler?
    
    public var cachedResponseHandler: Alamofire.CachedResponseHandler?
    
    public let method: Alamofire.HTTPMethod = .get
    
    public let base: () -> String?
    
    public let api: String
    
    public var subApi: String?
    
    public var mock: String?
    
    public var encoding: Alamofire.ParameterEncoding?
            
    public var encoder: Alamofire.ParameterEncoder?
    
    public init(_ api: String, base: @escaping @autoclosure () -> String? = Config.DataRequest.base()) {
        self.api = api
        self.base = base
    }
}


/// POST (CREATE): 在服务器新建一个资源
public struct POST<Input, Output>: DataRequestable {
    
    public var additionalHeaders: Alamofire.HTTPHeaders?
    
    public var timeoutInterval: TimeInterval?
    
    public var credential: URLCredential?
    
    public var redirectHandler: Alamofire.RedirectHandler?
    
    public var cachedResponseHandler: Alamofire.CachedResponseHandler?
    
    public let method: Alamofire.HTTPMethod = .post
    
    public let base: () -> String?
    
    public let api: String
    
    public var subApi: String?
    
    public var mock: String?
    
    public var encoding: Alamofire.ParameterEncoding?
            
    public var encoder: Alamofire.ParameterEncoder?
    
    public init(_ api: String, base: @escaping @autoclosure () -> String? = Config.DataRequest.base()) {
        self.api = api
        self.base = base
    }
}


/// PUT (UPDATE): 在服务器更新资源(客户端提供改变后的完整资源)
public struct PUT<Input, Output>: DataRequestable {
    
    public var additionalHeaders: Alamofire.HTTPHeaders?
    
    public var timeoutInterval: TimeInterval?
    
    public var credential: URLCredential?
    
    public var redirectHandler: Alamofire.RedirectHandler?
    
    public var cachedResponseHandler: Alamofire.CachedResponseHandler?
    
    public let method: Alamofire.HTTPMethod = .put
    
    public let base: () -> String?
    
    public let api: String
    
    public var subApi: String?
    
    public var mock: String?
    
    public var encoding: Alamofire.ParameterEncoding?
            
    public var encoder: Alamofire.ParameterEncoder?
    
    public init(_ api: String, base: @escaping @autoclosure () -> String? = Config.DataRequest.base()) {
        self.api = api
        self.base = base
    }
}


/// PATCH (UPDATE): 在服务器更新资源(客户端提供改变的属性)
public struct PATCH<Input, Output>: DataRequestable {
    
    public var additionalHeaders: Alamofire.HTTPHeaders?
    
    public var timeoutInterval: TimeInterval?
    
    public var credential: URLCredential?
    
    public var redirectHandler: Alamofire.RedirectHandler?
    
    public var cachedResponseHandler: Alamofire.CachedResponseHandler?
    
    public let method: Alamofire.HTTPMethod = .patch
    
    public let base: () -> String?
    
    public let api: String
    
    public var subApi: String?
    
    public var mock: String?
    
    public var encoding: Alamofire.ParameterEncoding?
            
    public var encoder: Alamofire.ParameterEncoder?
    
    public init(_ api: String, base: @escaping @autoclosure () -> String? = Config.DataRequest.base()) {
        self.api = api
        self.base = base
    }
}


/// DELETE: 从服务器删除资源
public struct DELETE<Input, Output>: DataRequestable {
    
    public var additionalHeaders: Alamofire.HTTPHeaders?
    
    public var timeoutInterval: TimeInterval?
    
    public var credential: URLCredential?
    
    public var redirectHandler: Alamofire.RedirectHandler?
    
    public var cachedResponseHandler: Alamofire.CachedResponseHandler?
    
    public let method: Alamofire.HTTPMethod = .delete
    
    public let base: () -> String?
    
    public let api: String
    
    public var subApi: String?
    
    public var mock: String?
    
    public var encoding: Alamofire.ParameterEncoding?
            
    public var encoder: Alamofire.ParameterEncoder?
    
    public init(_ api: String, base: @escaping @autoclosure () -> String? = Config.DataRequest.base()) {
        self.api = api
        self.base = base
    }
}

