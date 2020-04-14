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
struct GET<Input, Output>: Requestable {
    
    var additionalHeaders: HTTPHeaders? = nil
    
    var timeoutInterval: TimeInterval? = nil
    
    let method: HTTPMethod = .get
    
    let api: String
    
    var mocking: String? = nil
}


///（CREATE）：在服务器新建一个资源
struct POST<Input, Output>: Requestable {
    
    var additionalHeaders: HTTPHeaders?
    
    var timeoutInterval: TimeInterval?
    
    let method: HTTPMethod = .post
    
    let api: String
    
    var mocking: String?
}


///（UPDATE）：在服务器更新资源（客户端提供改变后的完整资源）
struct PUT<Input, Output>: Requestable {
    
    var additionalHeaders: HTTPHeaders? = nil
    
    var timeoutInterval: TimeInterval? = nil
    
    let method: HTTPMethod = .put
    
    let api: String
    
    var mocking: String? = nil
}


///（UPDATE）：在服务器更新资源（客户端提供改变的属性）
struct PATCH<Input, Output>: Requestable {
    
    var additionalHeaders: HTTPHeaders?
    
    var timeoutInterval: TimeInterval?
    
    let method: HTTPMethod = .patch
    
    let api: String
    
    var mocking: String?
}


///（DELETE）：从服务器删除资源
struct DELETE<Input, Output>: Requestable {
    
    var additionalHeaders: HTTPHeaders?
    
    var timeoutInterval: TimeInterval?
    
    let method: HTTPMethod = .delete
    
    let api: String
    
    var mocking: String?
}

