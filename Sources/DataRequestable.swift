//
//  DataRequestable.swift
//

import Foundation
import Alamofire


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
    /// this property will override the `Configuration.redirectHandler`.
    var redirectHandler: RedirectHandler? { get set }
    
    /// A type that handles whether the data task should store the HTTP response in the cache.
    /// there is a builtin type `ResponseCacher`yout can use.
    /// this property will override the `Configuration.cachedResponseHandler`.
    var cachedResponseHandler: CachedResponseHandler? { get set }
    
    /// the request method
    var method: HTTPMethod { get }
    
    /// the base url
    /// will combined with `api`
    /// this property will override the `Configuration.base`.
    var base: () -> String? { get }
    
    /// the request api
    /// will combined with `base`
    var api: String { get }
    
    /// the request sub api
    /// will append to `api`
    var subApi: String? { get set }
    
    /// mock to an url, only effected in debug mode
    /// eg: the original url is "http://www.wlgemini.com/foo", the mock url is "http://www.mock.com/foo"
    var mock: String? { get set }
    
    /// for JSON encoding
    var encoding: () -> ParameterEncoding { get set }
            
    /// for Encodable encoder
    var encoder: () -> ParameterEncoder { get set }
    
    /// init a request
    init(_ api: String, base: @escaping @autoclosure () -> String?)
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
        guard let url = self._url else { return }
        let req = _DataSession.request(url,
                                       method: self.method,
                                       parameters: nil,
                                       headers: self._headers,
                                       requestModifier: self._modifyURLRequest)
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        req.response(completionHandler: { _ in })
    }
}

// MARK: Input == JSON, Output == None
public extension DataRequestable where Input == JSON, Output == None {
    
    func request(_ params: [String: Any]) {
        guard let url = self._url else { return }
        let req = _DataSession.request(url,
                                       method: self.method,
                                       parameters: params,
                                       encoding: self._encoding,
                                       headers: self._headers,
                                       requestModifier: self._modifyURLRequest)
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        req.response(completionHandler: { _ in })
    }
}

// MARK: Input: Encodable, Output == None
public extension DataRequestable where Input: Encodable, Output == None {
    
    func request(_ params: Input) {
        guard let url = self._url else { return }
        let req = _DataSession.request(url,
                                       method: self.method,
                                       parameters: params,
                                       encoder: self._encoder,
                                       headers: self._headers,
                                       requestModifier: self._modifyURLRequest)
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        req.response(completionHandler: { _ in })
    }
}

// MARK: Input == None, Output == Data
public extension DataRequestable where Input == None, Output == Data {
    
    func request(dataPreprocessor: Alamofire.DataPreprocessor = Alamofire.DataResponseSerializer.defaultDataPreprocessor,
                 emptyResponseCodes: Set<Int> = Alamofire.DataResponseSerializer.defaultEmptyResponseCodes,
                 emptyRequestMethods: Set<Alamofire.HTTPMethod> = Alamofire.DataResponseSerializer.defaultEmptyRequestMethods,
                 completion: @escaping (Alamofire.AFDataResponse<Data>) -> Void) {
        guard let url = self._url else { return }
        let req = _DataSession.request(url,
                                       method: self.method,
                                       parameters: nil,
                                       headers: self._headers,
                                       requestModifier: self._modifyURLRequest)
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        req.responseData(dataPreprocessor: dataPreprocessor,
                         emptyResponseCodes: emptyResponseCodes,
                         emptyRequestMethods: emptyRequestMethods,
                         completionHandler: completion)
    }
}

// MARK: Input == None, Output == JSON
public extension DataRequestable where Input == None, Output == JSON {
    
    func request(dataPreprocessor: Alamofire.DataPreprocessor = Alamofire.JSONResponseSerializer.defaultDataPreprocessor,
                 emptyResponseCodes: Set<Int> = Alamofire.JSONResponseSerializer.defaultEmptyResponseCodes,
                 emptyRequestMethods: Set<Alamofire.HTTPMethod> = Alamofire.JSONResponseSerializer.defaultEmptyRequestMethods,
                 options: JSONSerialization.ReadingOptions = .allowFragments,
                 completion: @escaping (Alamofire.AFDataResponse<Any>) -> Void) {
        guard let url = self._url else { return }
        let req = _DataSession.request(url,
                                       method: self.method,
                                       parameters: nil,
                                       headers: self._headers,
                                       requestModifier: self._modifyURLRequest)
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        req.responseJSON(dataPreprocessor: dataPreprocessor,
                         emptyResponseCodes: emptyResponseCodes,
                         emptyRequestMethods: emptyRequestMethods,
                         options: options,
                         completionHandler: completion)
    }
}

// MARK: Input == None, Output: Decodable
public extension DataRequestable where Input == None, Output: Decodable {
    
    func request(dataPreprocessor: Alamofire.DataPreprocessor = Alamofire.DecodableResponseSerializer<Output>.defaultDataPreprocessor,
                 decoder: Alamofire.DataDecoder = JSONDecoder(),
                 emptyResponseCodes: Set<Int> = Alamofire.DecodableResponseSerializer<Output>.defaultEmptyResponseCodes,
                 emptyRequestMethods: Set<Alamofire.HTTPMethod> = Alamofire.DecodableResponseSerializer<Output>.defaultEmptyRequestMethods,
                 completion: @escaping (Alamofire.AFDataResponse<Output>) -> Void) {
        guard let url = self._url else { return }
        let req = _DataSession.request(url,
                                       method: self.method,
                                       parameters: nil,
                                       headers: self._headers,
                                       requestModifier: self._modifyURLRequest)
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        req.responseDecodable(dataPreprocessor: dataPreprocessor,
                              decoder: decoder,
                              emptyResponseCodes: emptyResponseCodes,
                              emptyRequestMethods: emptyRequestMethods,
                              completionHandler: completion)
    }
}

// MARK: Input == JSON, Output == Data
public extension DataRequestable where Input == JSON, Output == Data {
    
    func request(_ params: [String: Any],
                 dataPreprocessor: Alamofire.DataPreprocessor = Alamofire.DataResponseSerializer.defaultDataPreprocessor,
                 emptyResponseCodes: Set<Int> = Alamofire.DataResponseSerializer.defaultEmptyResponseCodes,
                 emptyRequestMethods: Set<Alamofire.HTTPMethod> = Alamofire.DataResponseSerializer.defaultEmptyRequestMethods,
                 completion: @escaping (Alamofire.AFDataResponse<Data>) -> Void) {
        guard let url = self._url else { return }
        let req = _DataSession.request(url,
                                       method: self.method,
                                       parameters: params,
                                       encoding: self._encoding,
                                       headers: self._headers,
                                       requestModifier: self._modifyURLRequest)
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        req.responseData(dataPreprocessor: dataPreprocessor,
                         emptyResponseCodes: emptyResponseCodes,
                         emptyRequestMethods: emptyRequestMethods,
                         completionHandler: completion)
    }
}

// MARK: Input == JSON, Output == JSON
public extension DataRequestable where Input == JSON, Output == JSON {
    
    func request(_ params: [String: Any],
                 dataPreprocessor: Alamofire.DataPreprocessor = Alamofire.JSONResponseSerializer.defaultDataPreprocessor,
                 emptyResponseCodes: Set<Int> = Alamofire.JSONResponseSerializer.defaultEmptyResponseCodes,
                 emptyRequestMethods: Set<Alamofire.HTTPMethod> = Alamofire.JSONResponseSerializer.defaultEmptyRequestMethods,
                 options: JSONSerialization.ReadingOptions = .allowFragments,
                 completion: @escaping (Alamofire.AFDataResponse<Any>) -> Void) {
        guard let url = self._url else { return }
        let req = _DataSession.request(url,
                                       method: self.method,
                                       parameters: params,
                                       encoding: self._encoding,
                                       headers: self._headers,
                                       requestModifier: self._modifyURLRequest)
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        req.responseJSON(dataPreprocessor: dataPreprocessor,
                         emptyResponseCodes: emptyResponseCodes,
                         emptyRequestMethods: emptyRequestMethods,
                         options: options,
                         completionHandler: completion)
    }
}

// MARK: Input == JSON, Output: Decodable
public extension DataRequestable where Input == JSON, Output: Decodable {
    
    func request(_ params: [String: Any],
                 dataPreprocessor: Alamofire.DataPreprocessor = Alamofire.DecodableResponseSerializer<Output>.defaultDataPreprocessor,
                 decoder: Alamofire.DataDecoder = JSONDecoder(),
                 emptyResponseCodes: Set<Int> = Alamofire.DecodableResponseSerializer<Output>.defaultEmptyResponseCodes,
                 emptyRequestMethods: Set<Alamofire.HTTPMethod> = Alamofire.DecodableResponseSerializer<Output>.defaultEmptyRequestMethods,
                 completion: @escaping (Alamofire.AFDataResponse<Output>) -> Void) {
        guard let url = self._url else { return }
        let req = _DataSession.request(url,
                                       method: self.method,
                                       parameters: params,
                                       encoding: self._encoding,
                                       headers: self._headers,
                                       requestModifier: self._modifyURLRequest)
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        req.responseDecodable(dataPreprocessor: dataPreprocessor,
                              decoder: decoder,
                              emptyResponseCodes: emptyResponseCodes,
                              emptyRequestMethods: emptyRequestMethods,
                              completionHandler: completion)
    }
}

// MARK: Input: Encodable, Output == Data
public extension DataRequestable where Input: Encodable, Output == Data {
    
    func request(_ params: Input,
                 dataPreprocessor: Alamofire.DataPreprocessor = Alamofire.DataResponseSerializer.defaultDataPreprocessor,
                 emptyResponseCodes: Set<Int> = Alamofire.DataResponseSerializer.defaultEmptyResponseCodes,
                 emptyRequestMethods: Set<Alamofire.HTTPMethod> = Alamofire.DataResponseSerializer.defaultEmptyRequestMethods,
                 completion: @escaping (Alamofire.AFDataResponse<Data>) -> Void) {
        guard let url = self._url else { return }
        let req = _DataSession.request(url,
                                       method: self.method,
                                       parameters: params,
                                       encoder: self._encoder,
                                       headers: self._headers,
                                       requestModifier: self._modifyURLRequest)
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        req.responseData(dataPreprocessor: dataPreprocessor,
                         emptyResponseCodes: emptyResponseCodes,
                         emptyRequestMethods: emptyRequestMethods,
                         completionHandler: completion)
    }
}

// MARK: Input: Encodable, Output == JSON
public extension DataRequestable where Input: Encodable, Output == JSON {
    
    func request(_ params: Input,
                 dataPreprocessor: Alamofire.DataPreprocessor = Alamofire.JSONResponseSerializer.defaultDataPreprocessor,
                 emptyResponseCodes: Set<Int> = Alamofire.JSONResponseSerializer.defaultEmptyResponseCodes,
                 emptyRequestMethods: Set<Alamofire.HTTPMethod> = Alamofire.JSONResponseSerializer.defaultEmptyRequestMethods,
                 options: JSONSerialization.ReadingOptions = .allowFragments,
                 completion: @escaping (Alamofire.AFDataResponse<Any>) -> Void) {
        guard let url = self._url else { return }
        let req = _DataSession.request(url,
                                       method: self.method,
                                       parameters: params,
                                       encoder: self._encoder,
                                       headers: self._headers,
                                       requestModifier: self._modifyURLRequest)
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        req.responseJSON(dataPreprocessor: dataPreprocessor,
                         emptyResponseCodes: emptyResponseCodes,
                         emptyRequestMethods: emptyRequestMethods,
                         options: options,
                         completionHandler: completion)
    }
}

// MARK: Input: Encodable, Output: Decodable
public extension DataRequestable where Input: Encodable, Output: Decodable {
    
    func request(_ params: Input,
                 dataPreprocessor: Alamofire.DataPreprocessor = Alamofire.DecodableResponseSerializer<Output>.defaultDataPreprocessor,
                 decoder: Alamofire.DataDecoder = JSONDecoder(),
                 emptyResponseCodes: Set<Int> = Alamofire.DecodableResponseSerializer<Output>.defaultEmptyResponseCodes,
                 emptyRequestMethods: Set<Alamofire.HTTPMethod> = Alamofire.DecodableResponseSerializer<Output>.defaultEmptyRequestMethods,
                 completion: @escaping (Alamofire.AFDataResponse<Output>) -> Void) {
        guard let url = self._url else { return }
        let req = _DataSession.request(url,
                                       method: self.method,
                                       parameters: params,
                                       encoder: self._encoder,
                                       headers: self._headers,
                                       requestModifier: self._modifyURLRequest)
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        req.responseDecodable(dataPreprocessor: dataPreprocessor,
                              decoder: decoder,
                              emptyResponseCodes: emptyResponseCodes,
                              emptyRequestMethods: emptyRequestMethods,
                              completionHandler: completion)
    }
}


// Requestable Modifier
public extension DataRequestable {
    
    /// 添加额外的headers
    func setAdditionalHeaders(_ headers: Alamofire.HTTPHeaders) -> Self {
        var new = self
        new.additionalHeaders = headers
        return new
    }
    
    /// 设置单独超时时间
    func setTimeoutInterval(_ timeout: TimeInterval) -> Self {
        var new = self
        new.timeoutInterval = timeout
        return new
    }
    
    /// 设置重定向策略，可以使用内置的重定向策略`Redirector`
    func setRedirectHandler(_ handler: Alamofire.RedirectHandler) -> Self {
        var new = self
        new.redirectHandler = handler
        return new
    }
    
    /// 设置缓存策略，可以使用内置的缓存策略`ResponseCacher`
    func setCachedResponseHandler(_ handler: Alamofire.CachedResponseHandler) -> Self {
        var new = self
        new.cachedResponseHandler = handler
        return new
    }
    
    /// 设置sub api
    func setSubApi(_ subApi: String) -> Self {
        var new = self
        new.subApi = subApi
        return new
    }
    
    /// mock到指定url，需要使用绝对地址
    func setMock(_ mock: String) -> Self {
        var new = self
        new.mock = mock
        return new
    }
}

public extension DataRequestable where Input == JSON {
    
    /// 设置encoding方式
    func setEncoding(_ encoding: Alamofire.ParameterEncoding) -> Self {
        var new = self
        new.encoding = { encoding }
        return new
    }
}

public extension DataRequestable where Input: Encodable {
    
    /// 设置encoder
    func setEncoder(_ encoder: Alamofire.ParameterEncoder) -> Self {
        var new = self
        new.encoder = { encoder }
        return new
    }
}


// MARK: - Private
extension DataRequestable {
    
    /// 生成url
    private var _url: String? {
        // make sure `base` is available
        guard let base = self.base() ?? Config.DataRequest.base else {
            #if DEBUG
            print("FunctionalRequest Error: base url not set for api `\(self.api)`, request won't start.")
            #endif
            return nil
        }
        
        // combine `base` & api
        var url: String = base + self.api
        
        // combine url & `subApi`
        if let subApi = self.subApi {
            url = url + subApi
        }
        
        // mock only in debug mode
        #if DEBUG
        if let mock = self.mock {
            print("FunctionalRequest Warning: using mock `\(mock)` for `\(url).`")
            url = mock
        }
        #endif
        
        return url
    }
    
    /// 合并Headers，self.additionalHeaders会覆盖Configuration.headers中冲突的key-value
    private var _headers: Alamofire.HTTPHeaders {
        var combineHeaders = Alamofire.HTTPHeaders()
        
        // DataRequest.headers
        if let headers = Config.DataRequest.headers?() {
            for h in headers {
                combineHeaders.add(h)
            }
        }
        
        // additionalHeaders
        if let additionalHeaders = self.additionalHeaders {
            for h in additionalHeaders {
                combineHeaders.add(h)
            }
        }
        
        return combineHeaders
    }
    
    /// 获取encoding
    private var _encoding: Alamofire.ParameterEncoding {
        return self.encoding()
    }
    
    /// 获取encoder
    private var _encoder: Alamofire.ParameterEncoder {
        return self.encoder()
    }
    
    /// 修改URLRequest
    private func _modifyURLRequest(_ req: inout URLRequest) throws {
        // timeoutInterval
        if let timeoutInterval = self.timeoutInterval ?? Config.DataRequest.timeoutInterval {
            req.timeoutInterval = timeoutInterval
        }
    }
    
    /// 修改Request
    private func _modifyRequest(_ req: Alamofire.Request) {
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
    private func _modifyDataRequest(_ req: Alamofire.DataRequest) {
        // validate
        req.validate()
    }
}

/// 内部使用的session
fileprivate let _DataSession = Alamofire.Session(eventMonitors: Config.DataRequest.eventMonitors)
