//
//  DataRequestable.swift
//

import Alamofire
import Foundation


// MARK: - DataRequestable
public protocol DataRequestable: Any {
    
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
    
    /// A type that handles how an HTTP redirect response from a remote server should be redirected to the new request.
    /// there is a builtin type `Redirector`yout can use.
    /// this property override the `Configuration.redirectHandler`.
    var redirectHandler: RedirectHandler? { get set }
    
    /// A type that handles whether the data task should store the HTTP response in the cache.
    /// there is a builtin type `ResponseCacher`yout can use.
    /// this property override the `Configuration.cachedResponseHandler`.
    var cachedResponseHandler: CachedResponseHandler? { get set }
    
    /// the request method
    var method: HTTPMethod { get }
    
    /// the base url
    /// will combined with `api`
    var base: () -> String { get }
    
    /// the request api
    /// will combined with `base`
    /// eg: base = "http://www.wlgemini.com/", api = "foo", url = base + api = "http://www.wlgemini.com/foo"
    var api: String { get }
    
    /// mocking to an url, only effected in debug mode
    /// eg: the original url is "http://www.wlgemini.com/foo", the mocking url is "http://www.mocking.com/foo"
    var mocking: String? { get set }
    
    /// init a request
    init(_ api: String, base: @escaping @autoclosure () -> String)
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
/// 可以表示请求参数为JSON(也就是一个Any)，或者返回值为JSON(也就是一个Any)
///
public enum JSON {}


// MARK: Input == None, Output == None
public extension DataRequestable where Input == None, Output == None {
    
    func request() {
        let req = AF.request(self._url, method: self.method, parameters: nil, headers: self._headers, requestModifier: self._modifyURLRequest)
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        req.response(completionHandler: { _ in })
    }
}

// MARK: Input == JSON, Output == None
public extension DataRequestable where Input == JSON, Output == None {
    
    func request(_ params: [String: Any]) {
        let req = AF.request(self._url, method: self.method, parameters: params, headers: self._headers, requestModifier: self._modifyURLRequest)
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        req.response(completionHandler: { _ in })
    }
}

// MARK: Input: Encodable, Output == None
public extension DataRequestable where Input: Encodable, Output == None {
    
    func request(_ params: Input) {
        let req = AF.request(self._url, method: self.method, parameters: params, headers: self._headers, requestModifier: self._modifyURLRequest)
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        req.response(completionHandler: { _ in })
    }
}

// MARK: Input == None, Output == Data
public extension DataRequestable where Input == None, Output == Data {
    
    func request(completion: @escaping (AFDataResponse<Data>) -> Void) {
        let req = AF.request(self._url, method: self.method, parameters: nil, headers: self._headers, requestModifier: self._modifyURLRequest)
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        req.responseData(completionHandler: completion)
    }
}

// MARK: Input == None, Output == JSON
public extension DataRequestable where Input == None, Output == JSON {
    
    func request(completion: @escaping (AFDataResponse<Any>) -> Void) {
        let req = AF.request(self._url, method: self.method, parameters: nil, headers: self._headers, requestModifier: self._modifyURLRequest)
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        req.responseJSON(completionHandler: completion)
    }
}

// MARK: Input == None, Output: Decodable
public extension DataRequestable where Input == None, Output: Decodable {
    
    func request(completion: @escaping (DataResponse<Output, AFError>) -> Void) {
        let req = AF.request(self._url, method: self.method, parameters: nil, headers: self._headers, requestModifier: self._modifyURLRequest)
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        req.responseDecodable(completionHandler: completion)
    }
}

// MARK: Input == JSON, Output == Data
public extension DataRequestable where Input == JSON, Output == Data {
    
    func request(_ params: [String: Any], completion: @escaping (AFDataResponse<Data>) -> Void) {
        let req = AF.request(self._url, method: self.method, parameters: params, headers: self._headers, requestModifier: self._modifyURLRequest)
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        req.responseData(completionHandler: completion)
    }
}

// MARK: Input == JSON, Output == JSON
public extension DataRequestable where Input == JSON, Output == JSON {
    
    func request(_ params: [String: Any], completion: @escaping (AFDataResponse<Any>) -> Void) {
        let req = AF.request(self._url, method: self.method, parameters: params, headers: self._headers, requestModifier: self._modifyURLRequest)
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        req.responseJSON(completionHandler: completion)
    }
}

// MARK: Input == JSON, Output: Decodable
public extension DataRequestable where Input == JSON, Output: Decodable {
    
    func request(_ params: [String: Any], completion: @escaping (DataResponse<Output, AFError>) -> Void) {
        let req = AF.request(self._url, method: self.method, parameters: params, headers: self._headers, requestModifier: self._modifyURLRequest)
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        req.responseDecodable(completionHandler: completion)
    }
}

// MARK: Input: Encodable, Output == Data
public extension DataRequestable where Input: Encodable, Output == Data {
    
    func request(_ params: Input, completion: @escaping (AFDataResponse<Data>) -> Void) {
        let req = AF.request(self._url, method: self.method, parameters: params, headers: self._headers, requestModifier: self._modifyURLRequest)
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        req.responseData(completionHandler: completion)
    }
}

// MARK: Input: Encodable, Output == JSON
public extension DataRequestable where Input: Encodable, Output == JSON {
    
    func request(_ params: Input, completion: @escaping (AFDataResponse<Any>) -> Void) {
        let req = AF.request(self._url, method: self.method, parameters: params, headers: self._headers, requestModifier: self._modifyURLRequest)
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        req.responseJSON(completionHandler: completion)
    }
}

// MARK: Input: Encodable, Output: Decodable
public extension DataRequestable where Input: Encodable, Output: Decodable {
    
    func request(_ params: Input, completion: @escaping (DataResponse<Output, AFError>) -> Void) {
        let req = AF.request(self._url, method: self.method, parameters: params, headers: self._headers, requestModifier: self._modifyURLRequest)
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        req.responseDecodable(completionHandler: completion)
    }
}


// Requestable Modifier
public extension DataRequestable {
    
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
    
    /// 可以使用内置的重定向策略`Redirector`
    func setRedirectHandler(_ handler: RedirectHandler) -> Self {
        var new = self
        new.redirectHandler = handler
        return new
    }
    
    /// 可以使用内置的缓存策略`ResponseCacher`
    func setCachedResponseHandler(_ handler: CachedResponseHandler) -> Self {
        var new = self
        new.cachedResponseHandler = handler
        return new
    }
    
    func setMocking(_ mocking: String) -> Self {
        var new = self
        new.mocking = mocking
        return new
    }
}


// MARK: - Private
extension DataRequestable {
    
    /// 生成url
    private var _url: String {
        // combine `base` & api
        var url: String = self.base() + self.api
        
        // mocking only in debug mode
        #if DEBUG
        if let mocking = self.mocking {
            url = mocking
        }
        #endif
        
        return url
    }
    
    /// 合并Headers，self.additionalHeaders会覆盖Configuration.headers中冲突的key-value
    private var _headers: HTTPHeaders {
        var headers = Configuration.headers
        if let additionalHeaders = self.additionalHeaders {
            for h in additionalHeaders {
                headers.add(h)
            }
        }
        return headers
    }
    
    /// 修改URLRequest
    private func _modifyURLRequest(_ req: inout URLRequest) throws {
        // timeoutInterval
        if let timeoutInterval = self.timeoutInterval ?? Configuration.timeoutInterval {
            req.timeoutInterval = timeoutInterval
        }
    }
    
    /// 修改Request
    private func _modifyRequest(_ req: Request) {
        // redirect
        if let redirectHandler = self.redirectHandler {
            req.redirect(using: redirectHandler)
        }
        
        // cacheResponse
        if let cachedResponseHandler = self.cachedResponseHandler {
            req.cacheResponse(using: cachedResponseHandler)
        }
    }
    
    /// 修改DataRequest
    private func _modifyDataRequest(_ req: DataRequest) {
        // validate
        req.validate()
    }
}
