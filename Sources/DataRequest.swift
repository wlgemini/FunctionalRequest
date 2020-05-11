//
//  DataRequest.swift
//

import Foundation
import Alamofire


///（SELECT）：从服务器取出资源（一项或多项）
public struct GET<Input, Output>: DataRequestable {

    public var additionalHeaders: HTTPHeaders?
    
    public var timeoutInterval: TimeInterval?
    
    public var redirectHandler: RedirectHandler?
    
    public var cachedResponseHandler: CachedResponseHandler?
    
    public let method: HTTPMethod = .get
    
    public let base: () -> String?
    
    public let api: String
    
    public var mock: String?
    
    /// Init
    /// - Parameters:
    ///   - api: 相对地址
    ///   - base: 基地址，默认为Configuration.base，如果使用默认值，需要提前设置好Configuration.base
    public init(_ api: String, base: @escaping @autoclosure () -> String? = Configuration.base) {
        self.api = api
        self.base = base
    }
}


///（CREATE）：在服务器新建一个资源
public struct POST<Input, Output>: DataRequestable {
    
    public var additionalHeaders: HTTPHeaders?
    
    public var timeoutInterval: TimeInterval?
    
    public var redirectHandler: RedirectHandler?
    
    public var cachedResponseHandler: CachedResponseHandler?
    
    public let method: HTTPMethod = .post
    
    public let base: () -> String?
    
    public let api: String
    
    public var mock: String?
    
    /// Init
    /// - Parameters:
    ///   - api: 相对地址
    ///   - base: 基地址，默认为Configuration.base，如果使用默认值，需要提前设置好Configuration.base
    public init(_ api: String, base: @escaping @autoclosure () -> String? = Configuration.base) {
        self.api = api
        self.base = base
    }
}


///（UPDATE）：在服务器更新资源（客户端提供改变后的完整资源）
public struct PUT<Input, Output>: DataRequestable {
    
    public var additionalHeaders: HTTPHeaders?
    
    public var timeoutInterval: TimeInterval?
    
    public var redirectHandler: RedirectHandler?
    
    public var cachedResponseHandler: CachedResponseHandler?
    
    public let method: HTTPMethod = .put
    
    public let base: () -> String?
    
    public let api: String
    
    public var mock: String?
    
    /// Init
    /// - Parameters:
    ///   - api: 相对地址
    ///   - base: 基地址，默认为Configuration.base，如果使用默认值，需要提前设置好Configuration.base
    public init(_ api: String, base: @escaping @autoclosure () -> String? = Configuration.base) {
        self.api = api
        self.base = base
    }
}


///（UPDATE）：在服务器更新资源（客户端提供改变的属性）
public struct PATCH<Input, Output>: DataRequestable {
    
    public var additionalHeaders: HTTPHeaders?
    
    public var timeoutInterval: TimeInterval?
    
    public var redirectHandler: RedirectHandler?
    
    public var cachedResponseHandler: CachedResponseHandler?
    
    public let method: HTTPMethod = .patch
    
    public let base: () -> String?
    
    public let api: String
    
    public var mock: String?
    
    /// Init
    /// - Parameters:
    ///   - api: 相对地址
    ///   - base: 基地址，默认为Configuration.base，如果使用默认值，需要提前设置好Configuration.base
    public init(_ api: String, base: @escaping @autoclosure () -> String? = Configuration.base) {
        self.api = api
        self.base = base
    }
}


///（DELETE）：从服务器删除资源
public struct DELETE<Input, Output>: DataRequestable {
    
    public var additionalHeaders: HTTPHeaders?
    
    public var timeoutInterval: TimeInterval?
    
    public var redirectHandler: RedirectHandler?
    
    public var cachedResponseHandler: CachedResponseHandler?
    
    public let method: HTTPMethod = .delete
    
    public let base: () -> String?
    
    public let api: String
    
    public var mock: String?
    
    /// Init
    /// - Parameters:
    ///   - api: 相对地址
    ///   - base: 基地址，默认为Configuration.base，如果使用默认值，需要提前设置好Configuration.base
    public init(_ api: String, base: @escaping @autoclosure () -> String? = Configuration.base) {
        self.api = api
        self.base = base
    }
}

