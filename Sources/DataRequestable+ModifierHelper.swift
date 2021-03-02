//
//  DataRequestable+ModifierHelper.swift
//

import Foundation
import Alamofire


// MARK: - Combine Configuration
// MARK: API
internal extension DataRequestable {
    
    /// 生成url
    @inlinable
    func _url() -> String? {
        // make sure `base` is available
        guard let base = self.modifier.base() else {
            #if DEBUG
            print("[ 🚫 ]: FunctionalRequest's base url not set for api `\(self.modifier.api)`, request won't start.")
            #endif
            return nil
        }
        
        // combine `base` & api
        var url: String = base + self.modifier.api
        
        // combine url & `subApi`
        if let subApi = self.modifier.subApi {
            url = url + subApi
        }
        
        // mock only in debug mode
        #if DEBUG
        if let mock = self.modifier.mock {
            print("[ ⚠️ ]: FunctionalRequest using mock `\(mock)` for `\(url).`")
            url = mock
        }
        #endif
        
        return url
    }
}


// MARK: DataRequest
internal extension DataRequestable {
    
    /// 合并Headers，self.additionalHeaders会覆盖Configuration.headers中冲突的key-value
    func _headers() -> Alamofire.HTTPHeaders {
        // combinedHeaders init from `Config.DataRequest.headers()` or an empty headers
        var combinedHeaders = Configuration.DataRequest.headers() ?? Alamofire.HTTPHeaders()
        
        // additionalHeaders override or appends to combinedHeaders
        if let additionalHeaders = self.modifier.dataRequest.additionalHeaders {
            for h in additionalHeaders {
                combinedHeaders.add(h)
            }
        }
        
        return combinedHeaders
    }
    
    @inlinable
    func _timeoutInterval() -> TimeInterval? {
        return self.modifier.dataRequest.timeoutInterval ?? Configuration.DataRequest.timeoutInterval()
    }
    
    @inlinable
    func _credential() -> URLCredential? {
        return self.modifier.dataRequest.credential ?? Configuration.DataRequest.credential()
    }
    
    @inlinable
    func _redirectHandler() -> Alamofire.RedirectHandler? {
        return self.modifier.dataRequest.redirectHandler ?? Configuration.DataRequest.redirectHandler()
    }
    
    func _encoding() -> Alamofire.ParameterEncoding {
        if let encoding = self.modifier.dataRequest.encoding {
            return encoding
            
        } else {
            switch self.modifier.method {
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
    
    func _encoder() -> Alamofire.ParameterEncoder {
        if let encoder = self.modifier.dataRequest.encoder {
            return encoder
            
        } else {
            switch self.modifier.method {
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
}


// MARK: DataRequest
internal extension DataRequestable {
    
    @inlinable
    func _queue() -> DispatchQueue {
        return self.modifier.dataResponse.queue ?? Configuration.DataResponse.queue() ?? DispatchQueue.main
    }
    
    @inlinable
    func _validation() -> Alamofire.DataRequest.Validation? {
        return self.modifier.dataResponse.validation ?? Configuration.DataResponse.validation()
    }
    
    @inlinable
    func _cachedResponseHandler() -> Alamofire.CachedResponseHandler? {
        return self.modifier.dataResponse.cachedResponseHandler ?? Configuration.DataResponse.cachedResponseHandler()
    }
    
    @inlinable
    func _options() -> JSONSerialization.ReadingOptions {
        return self.modifier.dataResponse.options ?? Configuration.DataResponse.JSON.options() ?? JSONSerialization.ReadingOptions.allowFragments
    }
    
    @inlinable
    func _decoder() -> Alamofire.DataDecoder {
        return self.modifier.dataResponse.decoder ?? Configuration.DataResponse.Decodable.decoder() ?? JSONDecoder()
    }
    
    @inlinable
    func _dataDataPreprocessor() -> Alamofire.DataPreprocessor {
        return self.modifier.dataResponse.dataPreprocessor ?? Configuration.DataResponse.Data.dataPreprocessor() ?? Alamofire.DataResponseSerializer.defaultDataPreprocessor
    }
    
    @inlinable
    func _jsonDataPreprocessor() -> Alamofire.DataPreprocessor {
        return self.modifier.dataResponse.dataPreprocessor ?? Configuration.DataResponse.JSON.dataPreprocessor() ?? Alamofire.JSONResponseSerializer.defaultDataPreprocessor
    }

    @inlinable
    func _decodableDataPreprocessor() -> Alamofire.DataPreprocessor where Output: Decodable {
        return self.modifier.dataResponse.dataPreprocessor ?? Configuration.DataResponse.Decodable.dataPreprocessor() ?? Alamofire.DecodableResponseSerializer<Output>.defaultDataPreprocessor
    }

    @inlinable
    func _dataEmptyResponseCodes() -> Set<Int> {
        return self.modifier.dataResponse.emptyResponseCodes ?? Configuration.DataResponse.Data.emptyResponseCodes() ?? Alamofire.DataResponseSerializer.defaultEmptyResponseCodes
    }
    
    @inlinable
    func _jsonEmptyResponseCodes() -> Set<Int> {
        return self.modifier.dataResponse.emptyResponseCodes ?? Configuration.DataResponse.JSON.emptyResponseCodes() ?? Alamofire.JSONResponseSerializer.defaultEmptyResponseCodes
    }

    @inlinable
    func _decodableEmptyResponseCodes() -> Set<Int> where Output: Decodable {
        return self.modifier.dataResponse.emptyResponseCodes ?? Configuration.DataResponse.Decodable.emptyResponseCodes() ?? Alamofire.DecodableResponseSerializer<Output>.defaultEmptyResponseCodes
    }

    @inlinable
    func _dataEmptyRequestMethods() -> Set<Alamofire.HTTPMethod> {
        return self.modifier.dataResponse.emptyRequestMethods ?? Configuration.DataResponse.Data.emptyRequestMethods() ?? Alamofire.DataResponseSerializer.defaultEmptyRequestMethods
    }
    
    @inlinable
    func _jsonEmptyRequestMethods() -> Set<Alamofire.HTTPMethod> {
        return self.modifier.dataResponse.emptyRequestMethods ?? Configuration.DataResponse.JSON.emptyRequestMethods() ?? Alamofire.JSONResponseSerializer.defaultEmptyRequestMethods
    }

    @inlinable
    func _decodableEmptyRequestMethods() -> Set<Alamofire.HTTPMethod> where Output: Decodable {
        return self.modifier.dataResponse.emptyRequestMethods ?? Configuration.DataResponse.Decodable.emptyRequestMethods() ?? Alamofire.DecodableResponseSerializer<Output>.defaultEmptyRequestMethods
    }
}


// MARK: - Modify DataRequest
internal extension DataRequestable {
    
    /// 修改URLRequest
    func _modifyURLRequest() -> (_ req: inout URLRequest) throws -> Void {
        let timeoutInterval = self._timeoutInterval
        
        // NOTE: Make sure not access `self` in block
        return { (req) in
            // timeoutInterval
            if let timeoutInterval = timeoutInterval() {
                req.timeoutInterval = timeoutInterval
            }
        }
    }
    
    /// 修改Request
    func _modifyRequest(_ req: Alamofire.Request) {
        // credential
        if let credential = self._credential() {
            req.authenticate(with: credential)
        }
        
        // redirect
        if let redirectHandler = self._redirectHandler() {
            req.redirect(using: redirectHandler)
        }
        
        // cacheResponse
        if let cachedResponseHandler = self._cachedResponseHandler() {
            req.cacheResponse(using: cachedResponseHandler)
        }
    }
    
    /// 修改DataRequest
    func _modifyDataRequest(_ req: Alamofire.DataRequest) {
        // validate
        if let validation = self._validation() {
            req.validate(validation)
        } else {
            req.validate()
        }
    }
}


/// 内部使用的session
internal let _FR = Alamofire.Session(interceptor: Configuration.DataRequest.interceptor,
                                     serverTrustManager: Configuration.DataRequest.serverTrustManager,
                                     eventMonitors: Configuration.eventMonitors)
