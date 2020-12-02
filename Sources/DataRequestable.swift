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
    
    /// a data request config, some of which propertys will override `Configuration`
    var configuration: DataRequestableConfiguration { get set }
    
    /// init a request
    /// - Parameters:
    ///   - api: request path
    ///   - base: base url
    init(_ api: String, base: @escaping @autoclosure Compute<String?>)
}


// MARK: - Internal
internal extension DataRequestable {
    
    /// 生成url
    var _url: String? {
        // make sure `base` is available
        guard let base = self.configuration.base() ?? Configuration.DataRequest.base() else {
            #if DEBUG
            print("🚫 FunctionalRequest Error: base url not set for api `\(self.configuration.api)`, request won't start.")
            #endif
            return nil
        }
        
        // combine `base` & api
        var url: String = base + self.configuration.api
        
        // combine url & `subApi`
        if let subApi = self.configuration.subApi {
            url = url + subApi
        }
        
        // mock only in debug mode
        #if DEBUG
        if let mock = self.configuration.mock {
            print("⚠️ FunctionalRequest Warning: using mock `\(mock)` for `\(url).`")
            url = mock
        }
        #endif
        
        return url
    }
    
    /// 合并Headers，self.additionalHeaders会覆盖Configuration.headers中冲突的key-value
    var _headers: Alamofire.HTTPHeaders {
        // combinedHeaders init from `Config.DataRequest.headers()` or an empty headers
        var combinedHeaders = Configuration.DataRequest.headers() ?? Alamofire.HTTPHeaders()
        
        // additionalHeaders override or appends to combinedHeaders
        if let additionalHeaders = self.configuration.additionalHeaders {
            for h in additionalHeaders {
                combinedHeaders.add(h)
            }
        }
        
        return combinedHeaders
    }
    
    /// 获取encoding
    var _encoding: Alamofire.ParameterEncoding {
        if let encoding = self.configuration.encoding {
            return encoding
            
        } else {
            switch self.configuration.method {
            // URLEncoding
            case .get: return Configuration.DataRequest.JSON.Encoding.get() ?? Alamofire.URLEncoding.default
            case .delete: return Configuration.DataRequest.JSON.Encoding.delete() ?? Alamofire.URLEncoding.default
                
            // JSONEncoding
            case .patch: return Configuration.DataRequest.JSON.Encoding.patch() ?? Alamofire.JSONEncoding.default
            case .post: return Configuration.DataRequest.JSON.Encoding.post() ?? Alamofire.JSONEncoding.default
            case .put: return Configuration.DataRequest.JSON.Encoding.put() ?? Alamofire.JSONEncoding.default
                
            // default
            default: return Alamofire.URLEncoding.default
            }
        }
    }
    
    /// 获取encoder
    var _encoder: Alamofire.ParameterEncoder {
        if let encoder = self.configuration.encoder {
            return encoder
            
        } else {
            switch self.configuration.method {
            // URLEncodedFormParameterEncoder
            case .get: return Configuration.DataRequest.Encodable.Encoder.get() ?? Alamofire.URLEncodedFormParameterEncoder.default
            case .delete: return Configuration.DataRequest.Encodable.Encoder.delete() ?? Alamofire.URLEncodedFormParameterEncoder.default
                
            // JSONEncoding
            case .patch: return Configuration.DataRequest.Encodable.Encoder.patch() ?? Alamofire.JSONParameterEncoder.default
            case .post: return Configuration.DataRequest.Encodable.Encoder.post() ?? Alamofire.JSONParameterEncoder.default
            case .put: return Configuration.DataRequest.Encodable.Encoder.put() ?? Alamofire.JSONParameterEncoder.default
                
            // default
            default: return Alamofire.URLEncodedFormParameterEncoder.default
            }
        }
    }
    
    /// 修改URLRequest
    var _modifyURLRequest: (_ req: inout URLRequest) throws -> Void {
        let timeoutInterval = self.configuration.timeoutInterval ?? Configuration.DataRequest.timeoutInterval()
        
        // NOTE: Make sure not access `self` in block
        return { (req) in
            // timeoutInterval
            if let timeoutInterval = timeoutInterval {
                req.timeoutInterval = timeoutInterval
            }
        }
    }
    
    /// 修改Request
    func _modifyRequest(_ req: Alamofire.Request) {
        
        // credential
        if let credential = self.configuration.credential ?? Configuration.DataRequest.credential() {
            req.authenticate(with: credential)
        }
        
        // redirect
        if let redirectHandler = self.configuration.redirectHandler {
            req.redirect(using: redirectHandler)
        }
        
        // cacheResponse
        if let cachedResponseHandler = self.configuration.cachedResponseHandler ?? Configuration.DataResponse.cachedResponseHandler() {
            req.cacheResponse(using: cachedResponseHandler)
        }
    }
    
    /// 修改DataRequest
    func _modifyDataRequest(_ req: Alamofire.DataRequest) {
        // validate
        if let validation = self.configuration.validation ?? Configuration.DataResponse.validation() {
            req.validate(validation)
        } else {
            req.validate()
        }
    }
}


internal extension Alamofire.DataRequest {
    
    @discardableResult
    func _response(queue: DispatchQueue?,
                   completionHandler: @escaping (Alamofire.AFDataResponse<Data?>) -> Void) -> Self {
        
        let _queue = queue ?? Configuration.DataResponse.queue() ?? DispatchQueue.main
        
        return self.response(queue: _queue,
                             completionHandler: completionHandler)
    }
    
    @discardableResult
    func _responseData(queue: DispatchQueue?,
                       dataPreprocessor: Alamofire.DataPreprocessor?,
                       emptyResponseCodes: Set<Int>?,
                       emptyRequestMethods: Set<Alamofire.HTTPMethod>?,
                       completionHandler: @escaping (Alamofire.AFDataResponse<Data>) -> Void) -> Self {
        
        let _queue = queue ?? Configuration.DataResponse.queue() ?? DispatchQueue.main
        let _dataPreprocessor = dataPreprocessor ?? Configuration.DataResponse.Data.dataPreprocessor() ?? Alamofire.DataResponseSerializer.defaultDataPreprocessor
        let _emptyResponseCodes = emptyResponseCodes ?? Configuration.DataResponse.Data.emptyResponseCodes() ?? Alamofire.DataResponseSerializer.defaultEmptyResponseCodes
        let _emptyRequestMethods = emptyRequestMethods ?? Configuration.DataResponse.Data.emptyRequestMethods() ?? Alamofire.DataResponseSerializer.defaultEmptyRequestMethods
        
        return self.responseData(queue: _queue,
                                 dataPreprocessor: _dataPreprocessor,
                                 emptyResponseCodes: _emptyResponseCodes,
                                 emptyRequestMethods: _emptyRequestMethods,
                                 completionHandler: completionHandler)
    }
    
    @discardableResult
    func _responseJSON(queue: DispatchQueue?,
                       dataPreprocessor: Alamofire.DataPreprocessor?,
                       emptyResponseCodes: Set<Int>?,
                       emptyRequestMethods: Set<Alamofire.HTTPMethod>?,
                       options: JSONSerialization.ReadingOptions?,
                       completionHandler: @escaping (Alamofire.AFDataResponse<Any>) -> Void) -> Self {
        
        let _queue = queue ?? Configuration.DataResponse.queue() ?? DispatchQueue.main
        let _dataPreprocessor = dataPreprocessor ?? Configuration.DataResponse.JSON.dataPreprocessor() ?? Alamofire.JSONResponseSerializer.defaultDataPreprocessor
        let _emptyResponseCodes = emptyResponseCodes ?? Configuration.DataResponse.JSON.emptyResponseCodes() ?? Alamofire.JSONResponseSerializer.defaultEmptyResponseCodes
        let _emptyRequestMethods = emptyRequestMethods ?? Configuration.DataResponse.JSON.emptyRequestMethods() ?? Alamofire.JSONResponseSerializer.defaultEmptyRequestMethods
        let _options = options ?? Configuration.DataResponse.JSON.options() ?? JSONSerialization.ReadingOptions.allowFragments
        
        return self.responseJSON(queue: _queue,
                                 dataPreprocessor: _dataPreprocessor,
                                 emptyResponseCodes: _emptyResponseCodes,
                                 emptyRequestMethods: _emptyRequestMethods,
                                 options: _options,
                                 completionHandler: completionHandler)
    }
    
    @discardableResult
    func _responseDecodable<T: Decodable>(of type: T.Type,
                                          queue: DispatchQueue?,
                                          dataPreprocessor: Alamofire.DataPreprocessor?,
                                          decoder: Alamofire.DataDecoder?,
                                          emptyResponseCodes: Set<Int>?,
                                          emptyRequestMethods: Set<Alamofire.HTTPMethod>?,
                                          completionHandler: @escaping (Alamofire.AFDataResponse<T>) -> Void) -> Self {
        
        let _queue = queue ?? Configuration.DataResponse.queue() ?? DispatchQueue.main
        let _dataPreprocessor = dataPreprocessor ?? Configuration.DataResponse.Decodable.dataPreprocessor() ?? Alamofire.DecodableResponseSerializer<T>.defaultDataPreprocessor
        let _decoder = decoder ?? Configuration.DataResponse.Decodable.decoder() ?? JSONDecoder()
        let _emptyResponseCodes = emptyResponseCodes ?? Configuration.DataResponse.Decodable.emptyResponseCodes() ?? Alamofire.DecodableResponseSerializer<T>.defaultEmptyResponseCodes
        let _emptyRequestMethods = emptyRequestMethods ?? Configuration.DataResponse.Decodable.emptyRequestMethods() ?? Alamofire.DecodableResponseSerializer<T>.defaultEmptyRequestMethods
        
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
internal let _DataSession = Alamofire.Session(interceptor: Configuration.DataRequest.interceptor,
                                              serverTrustManager: Configuration.DataRequest.serverTrustManager,
                                              eventMonitors: Configuration.eventMonitors)
