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
    
    public let api: String
    
    public var mocking: String? = nil
    
    public init(_ api: String) {
        self.api = api
    }
}


///（CREATE）：在服务器新建一个资源
public struct POST<Input, Output>: Requestable {
    
    public var additionalHeaders: HTTPHeaders? = nil
    
    public var timeoutInterval: TimeInterval? = nil
    
    public let method: HTTPMethod = .post
    
    public let api: String
    
    public var mocking: String? = nil
    
    public init(_ api: String) {
        self.api = api
    }
}


///（UPDATE）：在服务器更新资源（客户端提供改变后的完整资源）
public struct PUT<Input, Output>: Requestable {
    
    public var additionalHeaders: HTTPHeaders? = nil
    
    public var timeoutInterval: TimeInterval? = nil
    
    public let method: HTTPMethod = .put
    
    public let api: String
    
    public var mocking: String? = nil
    
    public init(_ api: String) {
        self.api = api
    }
}


///（UPDATE）：在服务器更新资源（客户端提供改变的属性）
public struct PATCH<Input, Output>: Requestable {
    
    public var additionalHeaders: HTTPHeaders? = nil
    
    public var timeoutInterval: TimeInterval? = nil
    
    public let method: HTTPMethod = .patch
    
    public let api: String
    
    public var mocking: String? = nil
    
    public init(_ api: String) {
        self.api = api
    }
}


///（DELETE）：从服务器删除资源
public struct DELETE<Input, Output>: Requestable {
    
    public var additionalHeaders: HTTPHeaders? = nil
    
    public var timeoutInterval: TimeInterval? = nil
    
    public let method: HTTPMethod = .delete
    
    public let api: String
    
    public var mocking: String? = nil
    
    public init(_ api: String) {
        self.api = api
    }
}

