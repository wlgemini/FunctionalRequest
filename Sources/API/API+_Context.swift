//
//  API+_Context.swift
//  

import Foundation
import Alamofire


// MARK: - Context for DataRequest
extension API {
    
    // MARK: HTTPMethod
    func _method(_ ctx: Context) -> Alamofire.HTTPMethod? {
        guard let method = ctx.dataRequest.api.method else {
            _Log.error("`HTTPMethod` not set, request won't start", location: ctx.requestLocation)
            return nil
        }
        
        return method
    }
    
    // MARK: - URL
    func _url(_ ctx: Context) -> String? {
        guard let initialURL = ctx.dataRequest.api.initialURL else {
            _Log.error("`InitialURL` not set, request won't start", location: ctx.requestLocation)
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
            
            let appendPathURL = ctx.dataRequest.api.appendPaths.reduce("", { $0 + $1() })
            url = baseURL() + pathURL() + appendPathURL
        }
        
        // mock only in debug mode
        _Debug.only {
            if let mock = ctx.dataRequest.api.mock, let _url = url {
                _Log.warning("Using mock `\(mock())` for `\(_url)`", location: ctx.requestLocation)
                url = mock()
            }
        }
        
        return url
    }
    
    // MARK: HTTPHeaders
    func _headers(_ ctx: Context) -> Alamofire.HTTPHeaders {
        // combinedHeaders init from `Store._api.dataRequest.headers()` or an empty headers
        var combinedHeaders = Store._api.dataRequest.headers ?? Alamofire.HTTPHeaders()
        
        // Context.dataRequest.headers override or appends to combinedHeaders
        for h in ctx.dataRequest.headers {
            combinedHeaders.add(h)
        }
        
        return combinedHeaders
    }
    
    // MARK: Encoder
    func _encoder(_ ctx: Context) -> Alamofire.ParameterEncoder {
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
    
    // MARK: Encoding
    func _encoding(_ ctx: Context) -> Alamofire.ParameterEncoding {
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
    
    // MARK: Modify URLRequest
    func _urlRequestModifier(_ ctx: Context) -> (_ req: inout URLRequest) throws -> Void {
        // NOTE: Make sure not access `Context` in block
        return { [urlRequestModifiers = ctx.dataRequest.urlRequestModifiers] (urlRequest) in
            for modifier in urlRequestModifiers {
                try modifier(&urlRequest)
            }
        }
    }
    
    // MARK: Authentication
    func _authenticate(_ ctx: Context) -> URLCredential? {
        ctx.dataRequest.authenticate
    }
    
    // MARK: Redirect
    func _redirectHandler(_ ctx: Context) -> Alamofire.RedirectHandler? {
        ctx.dataRequest.redirectHandler ?? Store._api.dataRequest.redirect
    }
}


// MARK: - Context for DataResponse
extension API {
    
    // MARK: DispatchQueue
    func _queue(_ ctx: Context) -> DispatchQueue {
        ctx.dataResponse.queue ?? Store._api.dataResponse.queue ?? .main
    }
    
    // MARK: Validate DataResponse
    func _validation(_ ctx: Context) -> (Range<Int>?, [String]?) {
        let acceptableStatusCodes = ctx.dataResponse.acceptableStatusCodes ??
            Store._api.dataResponse.acceptableStatusCodes
        
        let acceptableContentTypes = ctx.dataResponse.acceptableContentTypes ??
            Store._api.dataResponse.acceptableContentTypes
        
        return (acceptableStatusCodes, acceptableContentTypes?())
    }

    // MARK: Serialize DataResponse
    func _dataResponseSerializer(_ ctx: Context) -> Alamofire.DataResponseSerializer {
        let dataPreprocessor = ctx.dataResponse.serializeData.dataPreprocessor ??
            Store._api.dataResponse.serializeData.dataPreprocessor ??
            Alamofire.DataResponseSerializer.defaultDataPreprocessor
        
        let emptyResponseCodes = ctx.dataResponse.serializeData.emptyResponseCodes ??
            Store._api.dataResponse.serializeData.emptyResponseCodes ??
            Alamofire.DataResponseSerializer.defaultEmptyResponseCodes
        
        let emptyRequestMethods = ctx.dataResponse.serializeData.emptyRequestMethods ??
            Store._api.dataResponse.serializeData.emptyRequestMethods ??
            Alamofire.DataResponseSerializer.defaultEmptyRequestMethods
        
        return Alamofire.DataResponseSerializer(dataPreprocessor: dataPreprocessor,
                                                emptyResponseCodes: emptyResponseCodes,
                                                emptyRequestMethods: emptyRequestMethods)
    }
    
    func _stringResponseSerializer(_ ctx: Context) -> Alamofire.StringResponseSerializer {
        let dataPreprocessor = ctx.dataResponse.serializeString.dataPreprocessor ??
            Store._api.dataResponse.serializeString.dataPreprocessor ??
            Alamofire.StringResponseSerializer.defaultDataPreprocessor
        
        let encoding = ctx.dataResponse.serializeString.encoding ??
            Store._api.dataResponse.serializeString.encoding
        
        let emptyResponseCodes = ctx.dataResponse.serializeString.emptyResponseCodes ??
            Store._api.dataResponse.serializeString.emptyResponseCodes ??
            Alamofire.StringResponseSerializer.defaultEmptyResponseCodes
        
        let emptyRequestMethods = ctx.dataResponse.serializeString.emptyRequestMethods ??
            Store._api.dataResponse.serializeString.emptyRequestMethods ??
            Alamofire.StringResponseSerializer.defaultEmptyRequestMethods
        
        return Alamofire.StringResponseSerializer(dataPreprocessor: dataPreprocessor,
                                                  encoding: encoding,
                                                  emptyResponseCodes: emptyResponseCodes,
                                                  emptyRequestMethods: emptyRequestMethods)
    }
    
    func _jsonResponseSerializer(_ ctx: Context) -> Alamofire.JSONResponseSerializer {
        let dataPreprocessor = ctx.dataResponse.serializeJSON.dataPreprocessor ??
            Store._api.dataResponse.serializeJSON.dataPreprocessor ??
            Alamofire.JSONResponseSerializer.defaultDataPreprocessor
        
        let emptyResponseCodes = ctx.dataResponse.serializeJSON.emptyResponseCodes ??
            Store._api.dataResponse.serializeJSON.emptyResponseCodes ??
            Alamofire.JSONResponseSerializer.defaultEmptyResponseCodes
        
        let emptyRequestMethods = ctx.dataResponse.serializeJSON.emptyRequestMethods ??
            Store._api.dataResponse.serializeJSON.emptyRequestMethods ??
            Alamofire.JSONResponseSerializer.defaultEmptyRequestMethods
        
        let options = ctx.dataResponse.serializeJSON.options ??
            Store._api.dataResponse.serializeJSON.options ??
            .allowFragments
         
        return Alamofire.JSONResponseSerializer(dataPreprocessor: dataPreprocessor,
                                                emptyResponseCodes: emptyResponseCodes,
                                                emptyRequestMethods: emptyRequestMethods,
                                                options: options)
    }
    
    func _decodableResponseSerializer(_ ctx: Context) -> Alamofire.DecodableResponseSerializer<R>
    where R: Decodable {
        let dataPreprocessor = ctx.dataResponse.serializeDecodable.dataPreprocessor ??
            Store._api.dataResponse.serializeDecodable.dataPreprocessor ??
            Alamofire.DecodableResponseSerializer<R>.defaultDataPreprocessor
        
        let decoder = ctx.dataResponse.serializeDecodable.decoder ??
            Store._api.dataResponse.serializeDecodable.decoder ??
            JSONDecoder()
        
        let emptyResponseCodes = ctx.dataResponse.serializeDecodable.emptyResponseCodes ??
            Store._api.dataResponse.serializeDecodable.emptyResponseCodes ??
            Alamofire.DecodableResponseSerializer<R>.defaultEmptyResponseCodes
        
        let emptyRequestMethods = ctx.dataResponse.serializeDecodable.emptyRequestMethods ??
            Store._api.dataResponse.serializeDecodable.emptyRequestMethods ??
            Alamofire.DecodableResponseSerializer<R>.defaultEmptyRequestMethods
        
        return Alamofire.DecodableResponseSerializer(dataPreprocessor: dataPreprocessor,
                                                     decoder: decoder,
                                                     emptyResponseCodes: emptyResponseCodes,
                                                     emptyRequestMethods: emptyRequestMethods)
    }
    
    // MARK: Cache DataResponse
    func _cachedResponseHandler(_ ctx: Context) -> Alamofire.CachedResponseHandler? {
        ctx.dataResponse.cacheHandler ?? Store._api.dataResponse.cacheHandler
    }
}

// MARK: - Context for Accessing
extension API {
    
    // MARK: - Accessing DataRequest
    func _accessingDataRequest(_ ctx: Context) -> Available<Alamofire.DataRequest>? {
        ctx.accessing.onDataRequestAvailable
    }
}
