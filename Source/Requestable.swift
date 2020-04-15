//
//  Requestable.swift
//  Net
//
//  Created by wangluguang on 2020/4/8.
//  Copyright © 2020 com.wlgemini. All rights reserved.
//

import Alamofire
import Foundation


// Requestable
public protocol Requestable {
    
    /// Input type (aka params)
    associatedtype Input
    
    /// Output type (aka response data)
    associatedtype Output
    
    /// add some additional headers for this request
    var additionalHeaders: HTTPHeaders? { get set }
    
    /// when an instance of load activity occurs
    /// (e.g. bytes are received from the network for a request), the idle
    /// interval for a request is reset to 0. If the idle interval ever
    /// becomes greater than or equal to the timeout interval, the request
    /// is considered to have timed out.
    var timeoutInterval: TimeInterval? { get set }
    
    /// the request method
    var method: HTTPMethod { get }
    
    /// the request api
    /// will combined with `base`
    /// eg: base = "http://www.wlgemini.com/", api = "foo", url = base + api = "http://www.wlgemini.com/foo"
    var api: String { get }
    
    /// mocking to an url, only effected in debug mode
    /// eg: the original url is "http://www.wlgemini.com/foo", the mocking url is "http://www.mocking.com/foo"
    var mocking: String? { get set }
}


// MARK: - Request Function
// MARK: Input/Output Argument
/// 表示一个Requestable的Input和Output的范型参数
///
/// 可以表示请求没有参数，或者忽略返回值
///
public enum None {}


/// 表示一个Requestable的Input和Output的范型参数
///
/// 可以表示请求参数为JSON(也就是一个Dictionary)，或者返回值为JSON(也就是一个Dictionary)
///
public enum JSON {}


// MARK: Input == None, Output == None
public extension Requestable where Input == None, Output == None {
    
    func request() {
        AF.request(self._url, method: self.method, parameters: nil, headers: self._headers, requestModifier: self._requestModifier).responseData(completionHandler: { _ in })
    }
}


// MARK: Input == None, Output == JSON
public extension Requestable where Input == None, Output == JSON {
    
    func request(completionJSON: @escaping (AFDataResponse<Any>) -> Void) {
        AF.request(self._url, method: self.method, parameters: nil, headers: self._headers, requestModifier: self._requestModifier).responseJSON(completionHandler: completionJSON)
    }
}

// MARK: Input == None, Output: Decodable
public extension Requestable where Input == None, Output: Decodable {
    
    func request(completionDecodable: @escaping (DataResponse<Output, AFError>) -> Void) {
        AF.request(self._url, method: self.method, parameters: nil, headers: self._headers, requestModifier: self._requestModifier).responseDecodable(completionHandler: completionDecodable)
    }
}

// MARK: Input == JSON, Output == None
public extension Requestable where Input == JSON, Output == None {
    
    func request(_ params: [String: Any]) {
        AF.request(self._url, method: self.method, parameters: params, headers: self._headers, requestModifier: self._requestModifier).responseData(completionHandler: { _ in })
    }
}

// MARK: Input: Encodable, Output == None
public extension Requestable where Input: Encodable, Output == None {
    
    func request(_ params: Input) {
        AF.request(self._url, method: self.method, parameters: params, headers: self._headers, requestModifier: self._requestModifier).responseData(completionHandler: { _ in })
    }
}

// MARK: Input == JSON, Output == JSON
public extension Requestable where Input == JSON, Output == JSON {
    
    func request(_ params: [String: Any], completionJSON: @escaping (AFDataResponse<Any>) -> Void) {
        AF.request(self._url, method: self.method, parameters: params, headers: self._headers, requestModifier: self._requestModifier).responseJSON(completionHandler: completionJSON)
    }
}

// MARK: Input: Encodable, Output == JSON
public extension Requestable where Input: Encodable, Output == JSON {
    
    func request(_ params: Input, completionJSON: @escaping (AFDataResponse<Any>) -> Void) {
        AF.request(self._url, method: self.method, parameters: params, headers: self._headers, requestModifier: self._requestModifier).responseJSON(completionHandler: completionJSON)
    }
}

// MARK: Input == JSON, Output: Decodable
public extension Requestable where Input == JSON, Output: Decodable {
    
    func request(_ params: [String: Any], completionDecodable: @escaping (DataResponse<Output, AFError>) -> Void) {
        AF.request(self._url, method: self.method, parameters: params, headers: self._headers, requestModifier: self._requestModifier).responseDecodable(completionHandler: completionDecodable)
    }
}

// MARK: Input: Encodable, Output: Decodable
public extension Requestable where Input: Encodable, Output: Decodable {
    
    func request(_ params: Input, completionDecodable: @escaping (DataResponse<Output, AFError>) -> Void) {
        AF.request(self._url, method: self.method, parameters: params, headers: self._headers, requestModifier: self._requestModifier).responseDecodable(completionHandler: completionDecodable)
    }
}


// Requestable Modifier
public extension Requestable {
    
    func setAdditionalHeaders(_ headers: HTTPHeaders) -> Self {
        var new = self
        new.additionalHeaders = headers
        return new
    }
    
    func setTimeoutInterval(_ timeout: TimeInterval) -> Self {
        var new = self
        new.timeoutInterval = timeout
        return new
    }
    
    func setMocking(_ mocking: String) -> Self {
        var new = self
        new.mocking = mocking
        return new
    }
}


// MARK: - Private
extension Requestable {
    
    private var _url: String {
        guard let base  = Configuration.base else {
            fatalError("Configuration.base not set")
        }
        
        var url: String = base + self.api
        #if DEBUG
        if let mocking = self.mocking {
            url = mocking
        }
        #endif
        return url
    }
    
    /// 合并Headers，self.additionalHeaders更高优先级
    private var _headers: HTTPHeaders {
        var headers = Configuration.headers
        if let additionalHeaders = self.additionalHeaders {
            for h in additionalHeaders {
                headers.add(h)
            }
        }
        return headers
    }
    
    
    private func _requestModifier(_ req: inout URLRequest) throws {
        if let timeout = self.timeoutInterval {
            req.timeoutInterval = timeout
        } else if let timeout = Configuration.timeoutInterval {
            req.timeoutInterval = timeout
        }
    }
}
