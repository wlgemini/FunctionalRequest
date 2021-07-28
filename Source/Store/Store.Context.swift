//
//  Store.Context.swift
//  

import Foundation
import Alamofire


extension Store {
    
    /// Context
    public final class _Context {
        
        // DataRequest Location
        let requestLocation: Location
        
        // DataRequest
        let dataRequest = _Context._DataRequest()
        
        // DataResponse
        let dataResponse = _Context._DataResponse()
        
        // Accessing
        let accessing = _Context._Accessing()
        
        /// init
        init(requestLocation: Location) {
            self.requestLocation = requestLocation
        }
    }
}


extension Store._Context {
    
    // MARK: DataRequest
    /// _DataRequest
    final class _DataRequest {
        
        // API
        let api = Store._Context._API()
        
        // Headers
        var headers: Alamofire.HTTPHeaders = Alamofire.HTTPHeaders()
        
        // Encoder/Encoding
        var encoder: Alamofire.ParameterEncoder?
        var encoding: Alamofire.ParameterEncoding?
        
        // URLRequest Modifiers
        var urlRequestModifiers: [MutatingAvailable<URLRequest>] = []
        
        // Authentication
        var authenticate: URLCredential?
        
        // Redirect
        var redirectHandler: Alamofire.RedirectHandler?
    }
    
    
    // MARK: DataResponse
    /// _DataResponse
    final class _DataResponse {
        
        // DispatchQueue
        var queue: DispatchQueue?
        
        // Validate DataResponse
        var acceptableStatusCodes: Range<Int>?
        var acceptableContentTypes: Compute<[String]>?
        
        // Serialize DataResponse
        var serializeData = Store._Context._SerializeData()
        var serializeString = Store._Context._SerializeString()
        var serializeJSON = Store._Context._SerializeJSON()
        var serializeDecodable = Store._Context._SerializeDecodable()
        
        // Cache DataResponse
        var cacheHandler: Alamofire.CachedResponseHandler?
    }
    
    
    // MARK: Accessing
    /// _Accessing
    final class _Accessing {
        
        var onRequestAvailable: Available<Alamofire.Request>?
    }
    
    
    // MARK: DataRequest.API
    /// _API
    final class _API {
        
        // Initial URL
        var initialURL: DataRequestModifier.InitialURL._Type?
        
        // Modify URL
        var base: Compute<String>?
        var appendPaths: [Compute<String>] = []
        var mock: Compute<String>?
        
        // Method
        var method: Alamofire.HTTPMethod?
    }
    
    
    // MARK: - DataRequest.Encoder/Encoding
    /// _Encoder
    final class _Encoder {
        
        /// for `get` encoder. default: `Alamofire.URLEncodedFormParameterEncoder.default`
        var get = Setter.Copy.Nillable<Alamofire.ParameterEncoder>()
        
        /// for `delete` encoder. default: `Alamofire.URLEncodedFormParameterEncoder.default`
        var delete = Setter.Copy.Nillable<Alamofire.ParameterEncoder>()
        
        /// for `patch` encoder. default: `Alamofire.JSONParameterEncoder.default`
        var patch = Setter.Copy.Nillable<Alamofire.ParameterEncoder>()
        
        /// for `post` encoder. default: `Alamofire.JSONParameterEncoder.default`
        var post = Setter.Copy.Nillable<Alamofire.ParameterEncoder>()
        
        /// for `put` encoder. default: `Alamofire.JSONParameterEncoder.default`
        var put = Setter.Copy.Nillable<Alamofire.ParameterEncoder>()
        
        init() { }
    }
    
    /// _Encoding
    final class _Encoding {
        
        /// for `get` encoding. default: `Alamofire.URLEncoding.default`
        var get = Setter.Copy.Nillable<Alamofire.ParameterEncoding>()
        
        /// for `delete` encoding. default: `Alamofire.URLEncoding.default`
        var delete = Setter.Copy.Nillable<Alamofire.ParameterEncoding>()
        
        /// for `patch` encoding. default: `Alamofire.JSONEncoding.default`
        var patch = Setter.Copy.Nillable<Alamofire.ParameterEncoding>()
        
        /// for `post` encoding. default: `Alamofire.JSONEncoding.default`
        var post = Setter.Copy.Nillable<Alamofire.ParameterEncoding>()
        
        /// for `put` encoding. default: `Alamofire.JSONEncoding.default`
        var put = Setter.Copy.Nillable<Alamofire.ParameterEncoding>()
        
        init() { }
    }
    
    
    // MARK: - DataResponse.Serializer
    /// _SerializeData
    final class _SerializeData {
        
        /// default `Alamofire.DataResponseSerializer.defaultDataPreprocessor`
        public var dataPreprocessor = Setter.Copy.Nillable<Alamofire.DataPreprocessor>()
        
        /// default `Alamofire.DataResponseSerializer.defaultEmptyResponseCodes`
        public var emptyResponseCodes = Setter.Copy.Nillable<Set<Int>>()
        
        /// default `Alamofire.DataResponseSerializer.defaultEmptyRequestMethods`
        public var emptyRequestMethods = Setter.Copy.Nillable<Set<Alamofire.HTTPMethod>>()
        
        init() { }
    }
    
    /// _SerializeString
    final class _SerializeString {
        
        /// default `Alamofire.StringResponseSerializer.defaultDataPreprocessor`
        public var dataPreprocessor = Setter.Copy.Nillable<Alamofire.DataPreprocessor>()
        
        /// default `nil`
        public var encoding = Setter.Copy.Nillable<String.Encoding>()
        
        /// default `Alamofire.StringResponseSerializer.defaultEmptyResponseCodes`
        public var emptyResponseCodes = Setter.Copy.Nillable<Set<Int>>()
        
        /// default `Alamofire.StringResponseSerializer.defaultEmptyRequestMethods`
        public var emptyRequestMethods = Setter.Copy.Nillable<Set<Alamofire.HTTPMethod>>()
        
        init() { }
    }
    
    /// _SerializeJSON
    final class _SerializeJSON {
        
        /// default `Alamofire.JSONResponseSerializer.defaultDataPreprocessor`
        public var dataPreprocessor = Setter.Copy.Nillable<Alamofire.DataPreprocessor>()
        
        /// default `Alamofire.JSONResponseSerializer.defaultEmptyResponseCodes`
        public var emptyResponseCodes = Setter.Copy.Nillable<Set<Int>>()
        
        /// default `Alamofire.JSONResponseSerializer.defaultEmptyRequestMethods`
        public var emptyRequestMethods = Setter.Copy.Nillable<Set<Alamofire.HTTPMethod>>()
        
        /// default `.allowFragments`
        public var options = Setter.Copy.Nillable<JSONSerialization.ReadingOptions>()
        
        init() { }
    }
    
    /// _SerializeDecodable
    final class _SerializeDecodable {
        
        /// default `Alamofire.DecodableResponseSerializer<API.R>.defaultDataPreprocessor`
        public var dataPreprocessor = Setter.Copy.Nillable<Alamofire.DataPreprocessor>()
        
        /// default `JSONDecoder`
        public var decoder = Setter.Copy.Nillable<Alamofire.DataDecoder>()
        
        /// default `Alamofire.DecodableResponseSerializer<API.R>.defaultEmptyResponseCodes`
        public var emptyResponseCodes = Setter.Copy.Nillable<Set<Int>>()
        
        /// default `Alamofire.DecodableResponseSerializer<API.R>.defaultEmptyRequestMethods`
        public var emptyRequestMethods = Setter.Copy.Nillable<Set<Alamofire.HTTPMethod>>()
        
        init() { }
    }
}
