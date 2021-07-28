//
//  Store.API.swift
//

import Foundation
import Alamofire


// MARK: API
extension Store {
    
    /// API
    public struct API {
        
        public let dataRequest = DataRequest()
        
        public let dataResponse = DataResponse()
        
        init() { }
    }
}


// MARK: - DataRequest/DataResponse
extension Store {
    
    /// DataRequest
    public final class DataRequest {
        
        // MARK: URL
        public var base = Setter.Compute.Nillable<String>()
        
        // MARK: Headers
        public var headers = Setter.Compute.Nillable<Alamofire.HTTPHeaders>()
        
        // MARK: Encoder/Encoding
        public let encoder = Encoder()
        public let encoding = Encoding()
        
        // MARK: Authentication
        public var authenticate = Setter.Copy.Nillable<URLCredential>()
        
        // MARK: Redirect
        public var redirect = Setter.Copy.Nillable<Alamofire.RedirectHandler>()
        
        init() { }
    }
    
    /// DataResponse
    public final class DataResponse {
        
        // MARK: DispatchQueue
        /// default: .main
        var queue = Setter.Copy.Nonnil<DispatchQueue>(.main)
        
        // MARK: Validate DataResponse
        /// default acceptable range: 200 ... 299
        public var acceptableStatusCodes = Setter.Copy.Nillable<Range<Int>>()
        /// default acceptable content type: matches any specified in the Accept HTTP header field.
        public var acceptableContentTypes = Setter.Copy.Nillable<[String]>()
        
        // MARK: Serialize DataResponse
        public let serializeData = SerializeData()
        public let serializeString = SerializeString()
        public let serializeJSON = SerializeJSON()
        public let serializeDecodable = SerializeDecodable()

        // MARK: Cache DataResponse
        public var cacheHandler = Setter.Copy.Nillable<Alamofire.CachedResponseHandler>()
        
        init() { }
    }
}


// MARK: - Encoder/Encoding
extension Store {
    
    /// Encoder
    public final class Encoder {
        
        /// for `get` encoder. default: `Alamofire.URLEncodedFormParameterEncoder.default`
        public var get = Setter.Copy.Nonnil<Alamofire.ParameterEncoder>(Alamofire.URLEncodedFormParameterEncoder.default)
        
        /// for `delete` encoder. default: `Alamofire.URLEncodedFormParameterEncoder.default`
        public var delete = Setter.Copy.Nonnil<Alamofire.ParameterEncoder>(Alamofire.URLEncodedFormParameterEncoder.default)
        
        /// for `patch` encoder. default: `Alamofire.JSONParameterEncoder.default`
        public var patch = Setter.Copy.Nonnil<Alamofire.ParameterEncoder>(Alamofire.JSONParameterEncoder.default)
        
        /// for `post` encoder. default: `Alamofire.JSONParameterEncoder.default`
        public var post = Setter.Copy.Nonnil<Alamofire.ParameterEncoder>(Alamofire.JSONParameterEncoder.default)
        
        /// for `put` encoder. default: `Alamofire.JSONParameterEncoder.default`
        public var put = Setter.Copy.Nonnil<Alamofire.ParameterEncoder>(Alamofire.JSONParameterEncoder.default)
        
        init() { }
    }
    
    /// Encoding
    public final class Encoding {
        
        /// for `get` encoding. default: `Alamofire.URLEncoding.default`
        public var get = Setter.Copy.Nonnil<Alamofire.ParameterEncoding>(Alamofire.URLEncoding.default)
        
        /// for `delete` encoding. default: `Alamofire.URLEncoding.default`
        public var delete = Setter.Copy.Nonnil<Alamofire.ParameterEncoding>(Alamofire.URLEncoding.default)
        
        /// for `patch` encoding. default: `Alamofire.JSONEncoding.default`
        public var patch = Setter.Copy.Nonnil<Alamofire.ParameterEncoding>(Alamofire.JSONEncoding.default)
        
        /// for `post` encoding. default: `Alamofire.JSONEncoding.default`
        public var post = Setter.Copy.Nonnil<Alamofire.ParameterEncoding>(Alamofire.JSONEncoding.default)
        
        /// for `put` encoding. default: `Alamofire.JSONEncoding.default`
        public var put = Setter.Copy.Nonnil<Alamofire.ParameterEncoding>(Alamofire.JSONEncoding.default)
        
        init() { }
    }
}


// MARK: - Serializer
extension Store {
    
    /// SerializeData
    public final class SerializeData {
        
        /// default `Alamofire.DataResponseSerializer.defaultDataPreprocessor`
        public var dataPreprocessor = Setter.Copy.Nonnil<Alamofire.DataPreprocessor>(Alamofire.DataResponseSerializer.defaultDataPreprocessor)
        
        /// default `Alamofire.DataResponseSerializer.defaultEmptyResponseCodes`
        public var emptyResponseCodes = Setter.Copy.Nonnil<Set<Int>>(Alamofire.DataResponseSerializer.defaultEmptyResponseCodes)
        
        /// default `Alamofire.DataResponseSerializer.defaultEmptyRequestMethods`
        public var emptyRequestMethods = Setter.Copy.Nonnil<Set<Alamofire.HTTPMethod>>(Alamofire.DataResponseSerializer.defaultEmptyRequestMethods)
        
        init() { }
    }
    
    /// SerializeString
    public final class SerializeString {
        
        /// default `Alamofire.StringResponseSerializer.defaultDataPreprocessor`
        public var dataPreprocessor = Setter.Copy.Nonnil<Alamofire.DataPreprocessor>(Alamofire.StringResponseSerializer.defaultDataPreprocessor)
        
        /// default `nil`
        public var encoding = Setter.Copy.Nillable<String.Encoding>()
        
        /// default `Alamofire.StringResponseSerializer.defaultEmptyResponseCodes`
        public var emptyResponseCodes = Setter.Copy.Nonnil<Set<Int>>(Alamofire.StringResponseSerializer.defaultEmptyResponseCodes)
        
        /// default `Alamofire.StringResponseSerializer.defaultEmptyRequestMethods`
        public var emptyRequestMethods = Setter.Copy.Nonnil<Set<Alamofire.HTTPMethod>>(Alamofire.StringResponseSerializer.defaultEmptyRequestMethods)
        
        init() { }
    }
    
    /// SerializeJSON
    public final class SerializeJSON {
        
        /// default `Alamofire.JSONResponseSerializer.defaultDataPreprocessor`
        public var dataPreprocessor = Setter.Copy.Nonnil<Alamofire.DataPreprocessor>(Alamofire.JSONResponseSerializer.defaultDataPreprocessor)
        
        /// default `Alamofire.JSONResponseSerializer.defaultEmptyResponseCodes`
        public var emptyResponseCodes = Setter.Copy.Nonnil<Set<Int>>(Alamofire.JSONResponseSerializer.defaultEmptyResponseCodes)
        
        /// default `Alamofire.JSONResponseSerializer.defaultEmptyRequestMethods`
        public var emptyRequestMethods = Setter.Copy.Nonnil<Set<Alamofire.HTTPMethod>>(Alamofire.JSONResponseSerializer.defaultEmptyRequestMethods)
        
        /// default `.allowFragments`
        public var options = Setter.Copy.Nonnil<JSONSerialization.ReadingOptions>(.allowFragments)
        
        init() { }
    }
    
    /// SerializeDecodable
    public final class SerializeDecodable {
        
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
