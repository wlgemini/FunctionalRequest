//
//  Store.API.swift
//

import Foundation
import Alamofire


// MARK: API
extension Store {
    
    /// API
    public struct API {
        
        public var dataRequest = DataRequest()
        
        public var dataResponse = DataResponse()
        
        init() { }
    }
}


// MARK: - DataRequest/DataResponse
extension Store {
    
    /// DataRequest
    public struct DataRequest {
        
        // MARK: URL
        public var base: Compute<String>?
        
        // MARK: Headers
        public var headers: Alamofire.HTTPHeaders?
        
        // MARK: Encoder/Encoding
        public var encoder = Encoder()
        public var encoding = Encoding()
        
        // MARK: Authentication
        public var authenticate: URLCredential?
        
        // MARK: Redirect
        public var redirect: Alamofire.RedirectHandler?
        
        init() { }
    }
    
    /// DataResponse
    public struct DataResponse {
        
        // MARK: Validate DataResponse
        public var acceptableStatusCodes: Range<Int>?
        public var acceptableContentTypes: Compute<[String]>?
        
        // MARK: Serialize DataResponse
        public var serializeData = SerializeData()
        public var serializeString = SerializeString()
        public var serializeJSON = SerializeJSON()
        public var serializeDecodable = SerializeDecodable()

        // MARK: Cache DataResponse
        public var cacheHandler: Alamofire.CachedResponseHandler?
        
        init() { }
    }
}


// MARK: - Encoder/Encoding
extension Store {
    
    /// Encoder
    public struct Encoder {
        
        /// for `get` encoder. default: `Alamofire.URLEncodedFormParameterEncoder.default`
        public var get: Alamofire.ParameterEncoder?
        
        /// for `delete` encoder. default: `Alamofire.URLEncodedFormParameterEncoder.default`
        public var delete: Alamofire.ParameterEncoder?
        
        /// for `patch` encoder. default: `Alamofire.JSONParameterEncoder.default`
        public var patch: Alamofire.ParameterEncoder?
        
        /// for `post` encoder. default: `Alamofire.JSONParameterEncoder.default`
        public var post: Alamofire.ParameterEncoder?
        
        /// for `put` encoder. default: `Alamofire.JSONParameterEncoder.default`
        public var put: Alamofire.ParameterEncoder?
        
        init() { }
    }
    
    /// Encoding
    public struct Encoding {
        
        /// for `get` encoding. default: `Alamofire.URLEncoding.default`
        public var get: Alamofire.ParameterEncoding?
        
        /// for `delete` encoding. default: `Alamofire.URLEncoding.default`
        public var delete: Alamofire.ParameterEncoding?
        
        /// for `patch` encoding. default: `Alamofire.JSONEncoding.default`
        public var patch: Alamofire.ParameterEncoding?
        
        /// for `post` encoding. default: `Alamofire.JSONEncoding.default`
        public var post: Alamofire.ParameterEncoding?
        
        /// for `put` encoding. default: `Alamofire.JSONEncoding.default`
        public var put: Alamofire.ParameterEncoding?
        
        init() { }
    }
}


// MARK: - Serializer
extension Store {
    
    /// SerializeData
    public struct SerializeData {
        
        /// default `Alamofire.DataResponseSerializer.defaultDataPreprocessor`
        public var dataPreprocessor: Alamofire.DataPreprocessor?
        
        /// default `Alamofire.DataResponseSerializer.defaultEmptyResponseCodes`
        public var emptyResponseCodes: Set<Int>?
        
        /// default `Alamofire.DataResponseSerializer.defaultEmptyRequestMethods`
        public var emptyRequestMethods: Set<Alamofire.HTTPMethod>?
        
        init() { }
    }
    
    /// SerializeString
    public struct SerializeString {
        
        /// default `Alamofire.StringResponseSerializer.defaultDataPreprocessor`
        public var dataPreprocessor: Alamofire.DataPreprocessor?
        
        /// default `nil`
        public var encoding: String.Encoding?
        
        /// default `Alamofire.StringResponseSerializer.defaultEmptyResponseCodes`
        public var emptyResponseCodes: Set<Int>?
        
        /// default `Alamofire.StringResponseSerializer.defaultEmptyRequestMethods`
        public var emptyRequestMethods: Set<Alamofire.HTTPMethod>?
        
        init() { }
    }
    
    /// SerializeJSON
    public struct SerializeJSON {
        
        /// default `Alamofire.JSONResponseSerializer.defaultDataPreprocessor`
        public var dataPreprocessor: Alamofire.DataPreprocessor?
        
        /// default `Alamofire.JSONResponseSerializer.defaultEmptyResponseCodes`
        public var emptyResponseCodes: Set<Int>?
        
        /// default `Alamofire.JSONResponseSerializer.defaultEmptyRequestMethods`
        public var emptyRequestMethods: Set<Alamofire.HTTPMethod>?
        
        /// default `.allowFragments`
        public var options: JSONSerialization.ReadingOptions?
        
        init() { }
    }
    
    /// SerializeDecodable
    public struct SerializeDecodable {
        
        /// default `Alamofire.DecodableResponseSerializer<API.R>.defaultDataPreprocessor`
        public var dataPreprocessor: Alamofire.DataPreprocessor?
        
        /// default `JSONDecoder`
        public var decoder: Alamofire.DataDecoder?
        
        /// default `Alamofire.DecodableResponseSerializer<API.R>.defaultEmptyResponseCodes`
        public var emptyResponseCodes: Set<Int>?
        
        /// default `Alamofire.DecodableResponseSerializer<API.R>.defaultEmptyRequestMethods`
        public var emptyRequestMethods: Set<Alamofire.HTTPMethod>?
        
        init() { }
    }
}
