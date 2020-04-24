//
//  Request.swift
//  Net
//
//  Created by wangluguang on 2020/4/8.
//  Copyright © 2020 com.wlgemini. All rights reserved.
//

import Foundation
import Alamofire


/// SELECT）：从服务器取出资源（一项或多项）
public struct GET<Input, Output>: Requestable {
    
    public var additionalHeaders: HTTPHeaders? = nil
    
    public var timeoutInterval: TimeInterval? = nil
    
    public let method: HTTPMethod = .get
    
    public var base: () -> String
    
    public let api: String
    
    public var mocking: String? = nil
    
    /// Init
    /// - Parameters:
    ///   - api: 相对地址
    ///   - base: 基地址，changeable
    public init(_ api: String, base: @escaping @autoclosure () -> String) {
        self.api = api
        self.base = base
    }
}


///（CREATE）：在服务器新建一个资源
public struct POST<Input, Output>: Requestable {
    
    public var additionalHeaders: HTTPHeaders? = nil
    
    public var timeoutInterval: TimeInterval? = nil
    
    public let method: HTTPMethod = .post
    
    public var base: () -> String
    
    public let api: String
    
    public var mocking: String? = nil
    
    /// Init
    /// - Parameters:
    ///   - api: 相对地址
    ///   - base: 基地址，changeable
    public init(_ api: String, base: @escaping @autoclosure () -> String) {
        self.api = api
        self.base = base
    }
}


///（UPDATE）：在服务器更新资源（客户端提供改变后的完整资源）
public struct PUT<Input, Output>: Requestable {
    
    public var additionalHeaders: HTTPHeaders? = nil
    
    public var timeoutInterval: TimeInterval? = nil
    
    public let method: HTTPMethod = .put
    
    public var base: () -> String
    
    public let api: String
    
    public var mocking: String? = nil
    
    /// Init
    /// - Parameters:
    ///   - api: 相对地址
    ///   - base: 基地址，changeable
    public init(_ api: String, base: @escaping @autoclosure () -> String) {
        self.api = api
        self.base = base
    }
}


///（UPDATE）：在服务器更新资源（客户端提供改变的属性）
public struct PATCH<Input, Output>: Requestable {
    
    public var additionalHeaders: HTTPHeaders? = nil
    
    public var timeoutInterval: TimeInterval? = nil
    
    public let method: HTTPMethod = .patch
    
    public var base: () -> String
    
    public let api: String
    
    public var mocking: String? = nil
    
    /// Init
    /// - Parameters:
    ///   - api: 相对地址
    ///   - base: 基地址，changeable
    public init(_ api: String, base: @escaping @autoclosure () -> String) {
        self.api = api
        self.base = base
    }
}


///（DELETE）：从服务器删除资源
public struct DELETE<Input, Output>: Requestable {
    
    public var additionalHeaders: HTTPHeaders? = nil
    
    public var timeoutInterval: TimeInterval? = nil
    
    public let method: HTTPMethod = .delete
    
    public var base: () -> String
    
    public let api: String
    
    public var mocking: String? = nil
    
    /// Init
    /// - Parameters:
    ///   - api: 相对地址
    ///   - base: 基地址，changeable
    public init(_ api: String, base: @escaping @autoclosure () -> String) {
        self.api = api
        self.base = base
    }
}

