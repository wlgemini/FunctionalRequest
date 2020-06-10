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
    var additionalHeaders: Alamofire.HTTPHeaders? { get set }
    
    /// when an instance of load activity occurs
    /// (e.g. bytes are received from the network for a request), the idle
    /// interval for a request is reset to 0. If the idle interval ever
    /// becomes greater than or equal to the timeout interval, the request
    /// is considered to have timed out.
    var timeoutInterval: TimeInterval? { get set }
    
    /// A type that handles how an HTTP redirect response from a remote server should be redirected to the new request.
    /// there is a builtin type `Redirector`yout can use.
    /// this property will override the `Configuration.redirectHandler`.
    var redirectHandler: Alamofire.RedirectHandler? { get set }
    
    /// A type that handles whether the data task should store the HTTP response in the cache.
    /// there is a builtin type `ResponseCacher`yout can use.
    /// this property will override the `Configuration.cachedResponseHandler`.
    var cachedResponseHandler: Alamofire.CachedResponseHandler? { get set }
    
    /// the request method
    var method: Alamofire.HTTPMethod { get }
    
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
    var encoding: Alamofire.ParameterEncoding? { get set }
            
    /// for Encodable encoder
    var encoder: Alamofire.ParameterEncoder? { get set }
    
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
    
    func request(queue: DispatchQueue? = nil,
                 dataPreprocessor: Alamofire.DataPreprocessor? = nil,
                 emptyResponseCodes: Set<Int>? = nil,
                 emptyRequestMethods: Set<Alamofire.HTTPMethod>? = nil,
                 completion: @escaping (Alamofire.AFDataResponse<Data>) -> Void) {
        guard let url = self._url else { return }
        let req = _DataSession.request(url,
                                       method: self.method,
                                       parameters: nil,
                                       headers: self._headers,
                                       requestModifier: self._modifyURLRequest)
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        req._responseData(queue: queue,
                          dataPreprocessor: dataPreprocessor,
                          emptyResponseCodes: emptyResponseCodes,
                          emptyRequestMethods: emptyRequestMethods,
                          completionHandler: completion)
    }
}

// MARK: Input == None, Output == JSON
public extension DataRequestable where Input == None, Output == JSON {
    
    func request(queue: DispatchQueue? = nil,
                 dataPreprocessor: Alamofire.DataPreprocessor? = nil,
                 emptyResponseCodes: Set<Int>? = nil,
                 emptyRequestMethods: Set<Alamofire.HTTPMethod>? = nil,
                 options: JSONSerialization.ReadingOptions? = nil,
                 completion: @escaping (Alamofire.AFDataResponse<Any>) -> Void) {
        guard let url = self._url else { return }
        let req = _DataSession.request(url,
                                       method: self.method,
                                       parameters: nil,
                                       headers: self._headers,
                                       requestModifier: self._modifyURLRequest)
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        req._responseJSON(queue: queue,
                          dataPreprocessor: dataPreprocessor,
                          emptyResponseCodes: emptyResponseCodes,
                          emptyRequestMethods: emptyRequestMethods,
                          options: options,
                          completionHandler: completion)
    }
}

// MARK: Input == None, Output: Decodable
public extension DataRequestable where Input == None, Output: Decodable {
    
    func request(queue: DispatchQueue? = nil,
                 dataPreprocessor: Alamofire.DataPreprocessor? = nil,
                 decoder: Alamofire.DataDecoder? = nil,
                 emptyResponseCodes: Set<Int>? = nil,
                 emptyRequestMethods: Set<Alamofire.HTTPMethod>? = nil,
                 completion: @escaping (Alamofire.AFDataResponse<Output>) -> Void) {
        guard let url = self._url else { return }
        let req = _DataSession.request(url,
                                       method: self.method,
                                       parameters: nil,
                                       headers: self._headers,
                                       requestModifier: self._modifyURLRequest)
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        req._responseDecodable(of: Output.self,
                               queue: queue,
                               dataPreprocessor: dataPreprocessor,
                               decoder: decoder,
                               emptyResponseCodes: emptyResponseCodes,
                               emptyRequestMethods: emptyRequestMethods,
                               completionHandler: completion)
    }
}

// MARK: Input == JSON, Output == Data
public extension DataRequestable where Input == JSON, Output == Data {
    
    func request(_ params: [String: Any],
                 queue: DispatchQueue? = nil,
                 dataPreprocessor: Alamofire.DataPreprocessor? = nil,
                 emptyResponseCodes: Set<Int>? = nil,
                 emptyRequestMethods: Set<Alamofire.HTTPMethod>? = nil,
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
        req._responseData(queue: queue,
                          dataPreprocessor: dataPreprocessor,
                          emptyResponseCodes: emptyResponseCodes,
                          emptyRequestMethods: emptyRequestMethods,
                          completionHandler: completion)
    }
}

// MARK: Input == JSON, Output == JSON
public extension DataRequestable where Input == JSON, Output == JSON {
    
    func request(_ params: [String: Any],
                 queue: DispatchQueue? = nil,
                 dataPreprocessor: Alamofire.DataPreprocessor? = nil,
                 emptyResponseCodes: Set<Int>? = nil,
                 emptyRequestMethods: Set<Alamofire.HTTPMethod>? = nil,
                 options: JSONSerialization.ReadingOptions? = nil,
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
        req._responseJSON(queue: queue,
                          dataPreprocessor: dataPreprocessor,
                          emptyResponseCodes: emptyResponseCodes,
                          emptyRequestMethods: emptyRequestMethods,
                          options: options,
                          completionHandler: completion)
    }
}

// MARK: Input == JSON, Output: Decodable
public extension DataRequestable where Input == JSON, Output: Decodable {
    
    func request(_ params: [String: Any],
                 queue: DispatchQueue? = nil,
                 dataPreprocessor: Alamofire.DataPreprocessor? = nil,
                 decoder: Alamofire.DataDecoder? = nil,
                 emptyResponseCodes: Set<Int>? = nil,
                 emptyRequestMethods: Set<Alamofire.HTTPMethod>? = nil,
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
        req._responseDecodable(of: Output.self,
                               queue: queue,
                               dataPreprocessor: dataPreprocessor,
                               decoder: decoder,
                               emptyResponseCodes: emptyResponseCodes,
                               emptyRequestMethods: emptyRequestMethods,
                               completionHandler: completion)
    }
}

// MARK: Input: Encodable, Output == Data
public extension DataRequestable where Input: Encodable, Output == Data {
    
    func request(_ params: Input,
                 queue: DispatchQueue? = nil,
                 dataPreprocessor: Alamofire.DataPreprocessor? = nil,
                 emptyResponseCodes: Set<Int>? = nil,
                 emptyRequestMethods: Set<Alamofire.HTTPMethod>? = nil,
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
        req._responseData(queue: queue,
                          dataPreprocessor: dataPreprocessor,
                          emptyResponseCodes: emptyResponseCodes,
                          emptyRequestMethods: emptyRequestMethods,
                          completionHandler: completion)
    }
}

// MARK: Input: Encodable, Output == JSON
public extension DataRequestable where Input: Encodable, Output == JSON {
    
    func request(_ params: Input,
                 queue: DispatchQueue? = nil,
                 dataPreprocessor: Alamofire.DataPreprocessor? = nil,
                 emptyResponseCodes: Set<Int>? = nil,
                 emptyRequestMethods: Set<Alamofire.HTTPMethod>? = nil,
                 options: JSONSerialization.ReadingOptions? = nil,
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
        req._responseJSON(queue: queue,
                          dataPreprocessor: dataPreprocessor,
                          emptyResponseCodes: emptyResponseCodes,
                          emptyRequestMethods: emptyRequestMethods,
                          options: options,
                          completionHandler: completion)
    }
}

// MARK: Input: Encodable, Output: Decodable
public extension DataRequestable where Input: Encodable, Output: Decodable {
    
    func request(_ params: Input,
                 queue: DispatchQueue? = nil,
                 dataPreprocessor: Alamofire.DataPreprocessor? = nil,
                 decoder: Alamofire.DataDecoder? = nil,
                 emptyResponseCodes: Set<Int>? = nil,
                 emptyRequestMethods: Set<Alamofire.HTTPMethod>? = nil,
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
        req._responseDecodable(of: Output.self,
                               queue: queue,
                               dataPreprocessor: dataPreprocessor,
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
        new.encoding = encoding
        return new
    }
}

public extension DataRequestable where Input: Encodable {
    
    /// 设置encoder
    func setEncoder(_ encoder: Alamofire.ParameterEncoder) -> Self {
        var new = self
        new.encoder = encoder
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
        return self.encoding ?? Config.DataRequest.JSON.encoding ?? Alamofire.URLEncoding.default
    }
    
    /// 获取encoder
    private var _encoder: Alamofire.ParameterEncoder {
        return self.encoder ?? Config.DataRequest.Encodable.encoder ?? Alamofire.URLEncodedFormParameterEncoder.default
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


extension Alamofire.DataRequest {
    
    @discardableResult
    fileprivate func _responseData(queue: DispatchQueue?,
                                   dataPreprocessor: Alamofire.DataPreprocessor?,
                                   emptyResponseCodes: Set<Int>?,
                                   emptyRequestMethods: Set<Alamofire.HTTPMethod>?,
                                   completionHandler: @escaping (Alamofire.AFDataResponse<Data>) -> Void) -> Self {
        let _queue = queue ?? Config.DataResponse.queue ?? DispatchQueue.main
        let _dataPreprocessor = dataPreprocessor ?? Config.DataResponse.Data.dataPreprocessor ?? Alamofire.DataResponseSerializer.defaultDataPreprocessor
        let _emptyResponseCodes = emptyResponseCodes ?? Config.DataResponse.Data.emptyResponseCodes ?? Alamofire.DataResponseSerializer.defaultEmptyResponseCodes
        let _emptyRequestMethods = emptyRequestMethods ?? Config.DataResponse.Data.emptyRequestMethods ?? Alamofire.DataResponseSerializer.defaultEmptyRequestMethods
        
        return self.responseData(queue: _queue,
                                 dataPreprocessor: _dataPreprocessor,
                                 emptyResponseCodes: _emptyResponseCodes,
                                 emptyRequestMethods: _emptyRequestMethods,
                                 completionHandler: completionHandler)
    }
    
    @discardableResult
    fileprivate func _responseJSON(queue: DispatchQueue?,
                                   dataPreprocessor: Alamofire.DataPreprocessor?,
                                   emptyResponseCodes: Set<Int>?,
                                   emptyRequestMethods: Set<Alamofire.HTTPMethod>?,
                                   options: JSONSerialization.ReadingOptions?,
                                   completionHandler: @escaping (Alamofire.AFDataResponse<Any>) -> Void) -> Self {
        let _queue = queue ?? Config.DataResponse.queue ?? DispatchQueue.main
        let _dataPreprocessor = dataPreprocessor ?? Config.DataResponse.JSON.dataPreprocessor ?? Alamofire.JSONResponseSerializer.defaultDataPreprocessor
        let _emptyResponseCodes = emptyResponseCodes ?? Config.DataResponse.JSON.emptyResponseCodes ?? Alamofire.JSONResponseSerializer.defaultEmptyResponseCodes
        let _emptyRequestMethods = emptyRequestMethods ?? Config.DataResponse.JSON.emptyRequestMethods ?? Alamofire.JSONResponseSerializer.defaultEmptyRequestMethods
        let _options = options ?? Config.DataResponse.JSON.options ?? JSONSerialization.ReadingOptions.allowFragments
        
        return self.responseJSON(queue: _queue,
                                 dataPreprocessor: _dataPreprocessor,
                                 emptyResponseCodes: _emptyResponseCodes,
                                 emptyRequestMethods: _emptyRequestMethods,
                                 options: _options,
                                 completionHandler: completionHandler)
    }
    
    @discardableResult
    fileprivate func _responseDecodable<T: Decodable>(of type: T.Type,
                                                      queue: DispatchQueue?,
                                                      dataPreprocessor: Alamofire.DataPreprocessor?,
                                                      decoder: Alamofire.DataDecoder?,
                                                      emptyResponseCodes: Set<Int>?,
                                                      emptyRequestMethods: Set<Alamofire.HTTPMethod>?,
                                                      completionHandler: @escaping (Alamofire.AFDataResponse<T>) -> Void) -> Self {
        let _queue = queue ?? Config.DataResponse.queue ?? DispatchQueue.main
        let _dataPreprocessor = dataPreprocessor ?? Config.DataResponse.Decodable.dataPreprocessor ?? Alamofire.DecodableResponseSerializer<T>.defaultDataPreprocessor
        let _decoder = decoder ?? Config.DataResponse.Decodable.decoder ?? JSONDecoder()
        let _emptyResponseCodes = emptyResponseCodes ?? Config.DataResponse.Decodable.emptyResponseCodes ?? Alamofire.DecodableResponseSerializer<T>.defaultEmptyResponseCodes
        let _emptyRequestMethods = emptyRequestMethods ?? Config.DataResponse.Decodable.emptyRequestMethods ?? Alamofire.DecodableResponseSerializer<T>.defaultEmptyRequestMethods
        
        return self.responseDecodable(of: type,
                                      queue: _queue,
                                      dataPreprocessor: _dataPreprocessor,
                                      decoder: _decoder,
                                      emptyResponseCodes: _emptyResponseCodes,
                                      emptyRequestMethods: _emptyRequestMethods,
                                      completionHandler: completionHandler)
    }
}

/// 内部使用的session
fileprivate let _DataSession = Alamofire.Session(eventMonitors: Config.DataRequest.eventMonitors)
