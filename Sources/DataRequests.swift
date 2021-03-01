//
//  DataRequests.swift
//

import Foundation
import Alamofire


/// GET (SELECT): 从服务器取出资源
public struct GET<Input, Output>: DataRequestable {

    public var internalConfiguration: InternalConfiguration

    public init(_ api: String, base: @escaping @autoclosure Compute<String?> = Configuration.DataRequest.base()) {
        self.internalConfiguration = InternalConfiguration(method: .get, base: base, api: api)
    }
}


/// POST (CREATE): 在服务器新建一个资源
public struct POST<Input, Output>: DataRequestable {
    
    public var internalConfiguration: InternalConfiguration
    
    public init(_ api: String, base: @escaping @autoclosure Compute<String?> = Configuration.DataRequest.base()) {
        self.internalConfiguration = InternalConfiguration(method: .post, base: base, api: api)
    }
}


/// PUT (UPDATE): 在服务器更新资源(客户端提供改变后的完整资源)
public struct PUT<Input, Output>: DataRequestable {
    
    public var internalConfiguration: InternalConfiguration
    
    public init(_ api: String, base: @escaping @autoclosure Compute<String?> = Configuration.DataRequest.base()) {
        self.internalConfiguration = InternalConfiguration(method: .put, base: base, api: api)
    }
}


/// PATCH (UPDATE): 在服务器更新资源(客户端提供改变的属性)
public struct PATCH<Input, Output>: DataRequestable {
    
    public var internalConfiguration: InternalConfiguration
    
    public init(_ api: String, base: @escaping @autoclosure Compute<String?> = Configuration.DataRequest.base()) {
        self.internalConfiguration = InternalConfiguration(method: .patch, base: base, api: api)
    }
}


/// DELETE: 从服务器删除资源
public struct DELETE<Input, Output>: DataRequestable {
    
    public var internalConfiguration: InternalConfiguration
    
    public init(_ api: String, base: @escaping @autoclosure Compute<String?> = Configuration.DataRequest.base()) {
        self.internalConfiguration = InternalConfiguration(method: .delete, base: base, api: api)
    }
}

