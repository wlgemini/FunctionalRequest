//
//  _DataRequestable+CombineConfiguration.swift
//  FunctionalRequest
//
//  Created by wangluguang on 2021/3/1.
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
        guard let base = self.internalConfiguration.base() else {
            #if DEBUG
            print("[ 🚫 ]: FunctionalRequest's base url not set for api `\(self.internalConfiguration.api)`, request won't start.")
            #endif
            return nil
        }
        
        // combine `base` & api
        var url: String = base + self.internalConfiguration.api
        
        // combine url & `subApi`
        if let subApi = self.internalConfiguration.subApi {
            url = url + subApi
        }
        
        // mock only in debug mode
        #if DEBUG
        if let mock = self.internalConfiguration.mock {
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
        if let additionalHeaders = self.internalConfiguration.dataRequest.additionalHeaders {
            for h in additionalHeaders {
                combinedHeaders.add(h)
            }
        }
        
        return combinedHeaders
    }
    
    @inlinable
    func _timeoutInterval() -> TimeInterval? {
        return self.internalConfiguration.dataRequest.timeoutInterval ?? Configuration.DataRequest.timeoutInterval()
    }
    
    @inlinable
    func _credential() -> URLCredential? {
        return self.internalConfiguration.dataRequest.credential ?? Configuration.DataRequest.credential()
    }
    
    @inlinable
    func _redirectHandler() -> Alamofire.RedirectHandler? {
        return self.internalConfiguration.dataRequest.redirectHandler ?? Configuration.DataRequest.redirectHandler()
    }
    
    func _encoding() -> Alamofire.ParameterEncoding {
        if let encoding = self.internalConfiguration.dataRequest.json.encoding {
            return encoding
            
        } else {
            switch self.internalConfiguration.method {
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
        if let encoder = self.internalConfiguration.dataRequest.encodable.encoder {
            return encoder
            
        } else {
            switch self.internalConfiguration.method {
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
        return self.internalConfiguration.dataResponse.queue ?? Configuration.DataResponse.queue() ?? DispatchQueue.main
    }
    
    @inlinable
    func _validation() -> Alamofire.DataRequest.Validation? {
        return self.internalConfiguration.dataResponse.validation ?? Configuration.DataResponse.validation()
    }
    
    @inlinable
    func _cachedResponseHandler() -> Alamofire.CachedResponseHandler? {
        return self.internalConfiguration.dataResponse.cachedResponseHandler ?? Configuration.DataResponse.cachedResponseHandler()
    }
    
    @inlinable
    func _options() -> JSONSerialization.ReadingOptions {
        return self.internalConfiguration.dataResponse.options ?? Configuration.DataResponse.JSON.options() ?? JSONSerialization.ReadingOptions.allowFragments
    }
    
    @inlinable
    func _decoder() -> Alamofire.DataDecoder {
        return self.internalConfiguration.dataResponse.decoder ?? Configuration.DataResponse.Decodable.decoder() ?? JSONDecoder()
    }
    
    @inlinable
    func _dataDataPreprocessor() -> Alamofire.DataPreprocessor {
        return self.internalConfiguration.dataResponse.dataPreprocessor ?? Configuration.DataResponse.Data.dataPreprocessor() ?? Alamofire.DataResponseSerializer.defaultDataPreprocessor
    }
    
    @inlinable
    func _jsonDataPreprocessor() -> Alamofire.DataPreprocessor {
        return self.internalConfiguration.dataResponse.dataPreprocessor ?? Configuration.DataResponse.JSON.dataPreprocessor() ?? Alamofire.JSONResponseSerializer.defaultDataPreprocessor
    }

    @inlinable
    func _decodableDataPreprocessor() -> Alamofire.DataPreprocessor where Output: Decodable {
        return self.internalConfiguration.dataResponse.dataPreprocessor ?? Configuration.DataResponse.Decodable.dataPreprocessor() ?? Alamofire.DecodableResponseSerializer<Output>.defaultDataPreprocessor
    }

    @inlinable
    func _dataEmptyResponseCodes() -> Set<Int> {
        return self.internalConfiguration.dataResponse.emptyResponseCodes ?? Configuration.DataResponse.Data.emptyResponseCodes() ?? Alamofire.DataResponseSerializer.defaultEmptyResponseCodes
    }
    
    @inlinable
    func _jsonEmptyResponseCodes() -> Set<Int> {
        return self.internalConfiguration.dataResponse.emptyResponseCodes ?? Configuration.DataResponse.JSON.emptyResponseCodes() ?? Alamofire.JSONResponseSerializer.defaultEmptyResponseCodes
    }

    @inlinable
    func _decodableEmptyResponseCodes() -> Set<Int> where Output: Decodable {
        return self.internalConfiguration.dataResponse.emptyResponseCodes ?? Configuration.DataResponse.Decodable.emptyResponseCodes() ?? Alamofire.DecodableResponseSerializer<Output>.defaultEmptyResponseCodes
    }

    @inlinable
    func _dataEmptyRequestMethods() -> Set<Alamofire.HTTPMethod> {
        return self.internalConfiguration.dataResponse.emptyRequestMethods ?? Configuration.DataResponse.Data.emptyRequestMethods() ?? Alamofire.DataResponseSerializer.defaultEmptyRequestMethods
    }
    
    @inlinable
    func _jsonEmptyRequestMethods() -> Set<Alamofire.HTTPMethod> {
        return self.internalConfiguration.dataResponse.emptyRequestMethods ?? Configuration.DataResponse.JSON.emptyRequestMethods() ?? Alamofire.JSONResponseSerializer.defaultEmptyRequestMethods
    }

    @inlinable
    func _decodableEmptyRequestMethods() -> Set<Alamofire.HTTPMethod> where Output: Decodable {
        return self.internalConfiguration.dataResponse.emptyRequestMethods ?? Configuration.DataResponse.Decodable.emptyRequestMethods() ?? Alamofire.DecodableResponseSerializer<Output>.defaultEmptyRequestMethods
    }
}
