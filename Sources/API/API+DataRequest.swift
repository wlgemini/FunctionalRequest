//
//  API+DataRequest.swift
//

import Foundation
import Alamofire


public extension API {
    
    // P == [String: Any], R == Data
    func request(_ params: [String: Any], completion: @escaping (Alamofire.AFDataResponse<Data>) -> Void) where P == [String: Any], R == Data {
        
        guard let url = self._url() else { return }
        
        let req = _FR.request(url,
                              method: self.modifier.method,
                              parameters: params,
                              encoding: self._encoding(),
                              headers: self._headers(),
                              requestModifier: self._modifyURLRequest())
        
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        
        req.responseData(queue: self._queue(),
                         dataPreprocessor: self._dataDataPreprocessor(),
                         emptyResponseCodes: self._dataEmptyResponseCodes(),
                         emptyRequestMethods: self._dataEmptyRequestMethods(),
                         completionHandler: completion)
    }
    
    // P == [String: Any], R == [String: Any]
    func request(_ params: [String: Any], completion: @escaping (Alamofire.AFDataResponse<Any>) -> Void) where P == [String: Any], R == [String: Any] {
        guard let url = self._url() else { return }
        
        let req = _FR.request(url,
                              method: self.modifier.method,
                              parameters: params,
                              encoding: self._encoding(),
                              headers: self._headers(),
                              requestModifier: self._modifyURLRequest())
        
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        
        req.responseJSON(queue: self._queue(),
                         dataPreprocessor: self._jsonDataPreprocessor(),
                         emptyResponseCodes: self._jsonEmptyResponseCodes(),
                         emptyRequestMethods: self._jsonEmptyRequestMethods(),
                         options: self._options(),
                         completionHandler: completion)
    }
    
    // P == [String: Any], R: Decodable
    func request(_ params: [String: Any], completion: @escaping (Alamofire.AFDataResponse<R>) -> Void) where P == [String: Any], R: Decodable {
        guard let url = self._url() else { return }
        
        let req = _FR.request(url,
                              method: self.modifier.method,
                              parameters: params,
                              encoding: self._encoding(),
                              headers: self._headers(),
                              requestModifier: self._modifyURLRequest())
        
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        
        req.responseDecodable(of: R.self,
                              queue: self._queue(),
                              dataPreprocessor: self._decodableDataPreprocessor(),
                              decoder: self._decoder(),
                              emptyResponseCodes: self._decodableEmptyResponseCodes(),
                              emptyRequestMethods: self._decodableEmptyRequestMethods(),
                              completionHandler: completion)
    }
    
    // P: Encodable, R == Data
    func request(_ params: P, completion: @escaping (Alamofire.AFDataResponse<Data>) -> Void) where P: Encodable, R == Data  {
        guard let url = self._url() else { return }
        
        let req = _FR.request(url,
                              method: self.modifier.method,
                              parameters: params,
                              encoder: self._encoder(),
                              headers: self._headers(),
                              requestModifier: self._modifyURLRequest())
        
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        
        req.responseData(queue: self._queue(),
                         dataPreprocessor: self._dataDataPreprocessor(),
                         emptyResponseCodes: self._dataEmptyResponseCodes(),
                         emptyRequestMethods: self._dataEmptyRequestMethods(),
                         completionHandler: completion)
    }
    
    // P: Encodable, R == [String: Any]
    func request(_ params: P, completion: @escaping (Alamofire.AFDataResponse<Any>) -> Void) where P: Encodable, R == [String: Any] {
        guard let url = self._url() else { return }
        
        let req = _FR.request(url,
                              method: self.modifier.method,
                              parameters: params,
                              encoder: self._encoder(),
                              headers: self._headers(),
                              requestModifier: self._modifyURLRequest())
        
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        
        req.responseJSON(queue: self._queue(),
                         dataPreprocessor: self._jsonDataPreprocessor(),
                         emptyResponseCodes: self._jsonEmptyResponseCodes(),
                         emptyRequestMethods: self._jsonEmptyRequestMethods(),
                         options: self._options(),
                         completionHandler: completion)
    }
    
    // P: Encodable, R: Decodable
    func request(_ params: P, completion: @escaping (Alamofire.AFDataResponse<R>) -> Void) where P: Encodable, R: Decodable {
        guard let url = self._url() else { return }
        
        let req = _FR.request(url,
                              method: self.modifier.method,
                              parameters: params,
                              encoder: self._encoder(),
                              headers: self._headers(),
                              requestModifier: self._modifyURLRequest())
        
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        
        req.responseDecodable(of: R.self,
                              queue: self._queue(),
                              dataPreprocessor: self._decodableDataPreprocessor(),
                              decoder: self._decoder(),
                              emptyResponseCodes: self._decodableEmptyResponseCodes(),
                              emptyRequestMethods: self._decodableEmptyRequestMethods(),
                              completionHandler: completion)
    }
}


// MARK: Context for DataRequest
extension API {
    
    /// 生成method
    func _method(for ctx: Context) -> Alamofire.HTTPMethod? {
        guard let method = ctx.dataRequest.api.method else {
            _Log.error("HTTPMethod not set, request won't start", location: ctx.requestLocation)
            return nil
        }
        
        return method
    }
    
    /// 生成url
    func _url(for ctx: Context) -> String? {
        guard let initialURL = ctx.dataRequest.api.initialURL else {
            _Log.error("Initial URL not set, request won't start", location: ctx.requestLocation)
            return nil
        }
        
        var url: String?
        switch initialURL {
        case .full(let fullURL):
            url = fullURL()
            
        case .path(let pathURL):
            guard let baseURL = ctx.dataRequest.api.base else {
                _Log.error("Base URL not set, request won't start", location: ctx.requestLocation)
                return nil
            }
            
            let appendPath = ctx.dataRequest.api.appendPaths.reduce("", { $0 + $1() })
            
            url = baseURL() + pathURL() + appendPath
        }
        
        // mock only in debug mode
        #if DEBUG
        if let mock = ctx.dataRequest.api.mock, let _url = url {
            _Log.warning("Using mock `\(mock())` for `\(_url)`", location: ctx.requestLocation)
            url = mock()
        }
        #endif
        
        return url
    }
    
    /// 合并Headers，self.additionalHeaders会覆盖Configuration.headers中冲突的key-value
    func _headers(for ctx: Context) -> Alamofire.HTTPHeaders {
        // combinedHeaders init from `Config.DataRequest.headers()` or an empty headers
        var combinedHeaders = Store._api.dataRequest.headers ?? Alamofire.HTTPHeaders()
        
        // additionalHeaders override or appends to combinedHeaders
        for h in ctx.dataRequest.headers {
            combinedHeaders.add(h)
        }
        
        return combinedHeaders
    }
    
    /// encoder
    func _encoder(for ctx: Context) -> Alamofire.ParameterEncoder {
        if let encoder = ctx.dataRequest.encoder {
            return encoder
            
        } else {
            guard let method = ctx.dataRequest.api.method else {
                return Alamofire.URLEncodedFormParameterEncoder.default
            }
            
            switch method {
            // URLEncodedFormParameterEncoder
            case .get: return Store._api.dataRequest.encoder.get ?? Alamofire.URLEncodedFormParameterEncoder.default
            case .delete: return Store._api.dataRequest.encoder.delete ?? Alamofire.URLEncodedFormParameterEncoder.default
                
            // JSONEncoding
            case .patch: return Store._api.dataRequest.encoder.patch ?? Alamofire.JSONParameterEncoder.default
            case .post: return Store._api.dataRequest.encoder.post ?? Alamofire.JSONParameterEncoder.default
            case .put: return Store._api.dataRequest.encoder.put ?? Alamofire.JSONParameterEncoder.default
                
            // default
            default: return Alamofire.URLEncodedFormParameterEncoder.default
            }
        }
    }
    
    /// encoding
    func _encoding(for ctx: Context) -> Alamofire.ParameterEncoding {
        if let encoding = ctx.dataRequest.encoding {
            return encoding
            
        } else {
            guard let method = ctx.dataRequest.api.method else {
                return Alamofire.URLEncoding.default
            }
            
            switch method {
            // URLEncoding
            case .get: return Store._api.dataRequest.encoding.get ?? Alamofire.URLEncoding.default
            case .delete: return Store._api.dataRequest.encoding.delete ?? Alamofire.URLEncoding.default
                
            // JSONEncoding
            case .patch: return Store._api.dataRequest.encoding.patch ?? Alamofire.JSONEncoding.default
            case .post: return Store._api.dataRequest.encoding.post ?? Alamofire.JSONEncoding.default
            case .put: return Store._api.dataRequest.encoding.put ?? Alamofire.JSONEncoding.default
                
            // default
            default: return Alamofire.URLEncoding.default
            }
        }
    }
    
    /// 修改URLRequest
    func _urlRequestModifiers(for ctx: Context) -> (_ req: inout URLRequest) throws -> Void {
        // NOTE: Make sure not access `Context` in block
        return { [urlRequestModifiers = ctx.dataRequest.urlRequestModifiers] (req) in
            for modifier in urlRequestModifiers {
                try modifier(&req)
            }
        }
    }
    
    /// Authentication
    func _authenticate(for ctx: Context) -> URLCredential? {
        ctx.dataRequest.authenticate
    }
    
    /// Redirect
    func _redirectHandler(for ctx: Context) -> Alamofire.RedirectHandler? {
        return ctx.dataRequest.redirectHandler ?? Store._api.dataRequest.redirect
    }
}


// MARK: Context for DataResponse
extension API {
    
    /// Validate DataResponse
    func _acceptableStatusCodes(for ctx: Context) -> Range<Int>? {
        ctx.dataResponse.acceptableStatusCodes ?? Store._api.dataResponse.acceptableStatusCodes
    }
    
    func _acceptableContentTypes(for ctx: Context) -> [String]? {
        let types = ctx.dataResponse.acceptableContentTypes ?? Store._api.dataResponse.acceptableContentTypes
        return types?()
    }

    // Serialize DataResponse
//    var serializeData = Store.SerializeData()
//    var serializeString = Store.SerializeString()
//    var serializeJSON = Store.SerializeJSON()
//    var serializeDecodable = Store.SerializeDecodable()
//    
//    // Cache DataResponse
//    var cacheHandler: Alamofire.CachedResponseHandler?
}

// MARK: Context for Accessing
extension API {
//    var onDataRequestAvailable: Available<Alamofire.DataRequest>?
    
}
