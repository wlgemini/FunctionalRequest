//
//  ConfigurationModifier.swift
//

import Foundation
import Alamofire


public struct ConfigurationModifier {
    
    /// init
    public init(method: Alamofire.HTTPMethod, base: @escaping Compute<String?>, api: String) {
        self.method = method
        self.base = base
        self.api = api
    }
    
    /// the request method
    public let method: Alamofire.HTTPMethod
    
    /// the base url
    /// will combined with `api`
    public let base: Compute<String?>
    
    /// the request api
    /// will combined with `base`
    ///
    ///     let url = base() + api
    public let api: String
    
    /// the request sub path
    /// will append to `api`: url = `base() + api + subApi`
    public internal(set) var subApi: String?
    
    /// mock to an url, only effected in debug mode
    /// eg: the original url is "http://www.wlgemini.com/foo", the mock url is "http://www.mock.com/foo"
    public internal(set) var mock: String?
    
    /// dataRequest
    public internal(set) var dataRequest: DataRequest = DataRequest()
    
    /// dataResponse
    public internal(set) var dataResponse: DataResponse = DataResponse()
}


extension ConfigurationModifier {
    
    /// DataRequest
    public struct DataRequest {
        
        public internal(set) var additionalHeaders: Alamofire.HTTPHeaders?
        
        public internal(set) var timeoutInterval: TimeInterval?
        
        public internal(set) var credential: URLCredential?
        
        public internal(set) var redirectHandler: Alamofire.RedirectHandler?
        
        public internal(set) var encoding: Alamofire.ParameterEncoding?
        
        public internal(set) var encoder: Alamofire.ParameterEncoder?
    }
    
    /// DataResponse
    public struct DataResponse {
        
        public internal(set) var queue: DispatchQueue?
        
        public internal(set) var validation: Alamofire.DataRequest.Validation?

        public internal(set) var cachedResponseHandler: Alamofire.CachedResponseHandler?

        public internal(set) var options: JSONSerialization.ReadingOptions?
        
        public internal(set) var decoder: Alamofire.DataDecoder?
        
        public internal(set) var dataPreprocessor: Alamofire.DataPreprocessor?
        
        public internal(set) var emptyResponseCodes: Set<Int>?
        
        public internal(set) var emptyRequestMethods: Set<Alamofire.HTTPMethod>?
    }
}
