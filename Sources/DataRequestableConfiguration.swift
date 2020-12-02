//
//  DataRequestableConfiguration.swift
//

import Foundation
import Alamofire


/// DataRequestableConfiguration
public struct DataRequestableConfiguration {
    
    /// init a DataRequestConfiguration
    public init(method: Alamofire.HTTPMethod, base: @escaping Compute<String?>, api: String) {
        self.method = method
        self.base = base
        self.api = api
    }
    
    /// the request method
    public let method: Alamofire.HTTPMethod
    
    /// the base url
    /// will combined with `api`
    /// this property will override the `Configuration.DataRequest.base`.
    public let base: Compute<String?>
    
    /// the request api
    /// will combined with `base`: url = `base() + api`
    public let api: String
    
    /// the request sub path
    /// will append to `api`: url = `base() + api + subApi`
    public internal(set) var subApi: String?
    
    /// mock to an url, only effected in debug mode
    /// eg: the original url is "http://www.wlgemini.com/foo", the mock url is "http://www.mock.com/foo"
    public internal(set) var mock: String?
    
    /// add some additional headers for this request
    public internal(set) var additionalHeaders: Alamofire.HTTPHeaders?
    
    /// when an instance of load activity occurs
    /// (e.g. bytes are received from the network for a request), the idle
    /// interval for a request is reset to 0. If the idle interval ever
    /// becomes greater than or equal to the timeout interval, the request
    /// is considered to have timed out.
    public internal(set) var timeoutInterval: TimeInterval?
    
    /// add a `URLCredential` for each `Alamofire.Request`
    /// this property will override the `Configuration.DataRequest.credential`.
    public internal(set) var credential: URLCredential?
    
    /// A type that handles how an HTTP redirect response from a remote server should be redirected to the new request.
    /// there is a builtin type `Redirector`yout can use.
    /// this property will override the `Configuration.DataRequest.redirectHandler`.
    public internal(set) var redirectHandler: Alamofire.RedirectHandler?
    
    /// DataResponse validation
    /// this property will override the `Configuration.DataResponse.validate`.
    public internal(set) var validation: Alamofire.DataRequest.Validation?
    
    /// A type that handles whether the data task should store the HTTP response in the cache.
    /// there is a builtin type `ResponseCacher`yout can use.
    /// this property will override the `Configuration.DataResponse.cachedResponseHandler`.
    public internal(set) var cachedResponseHandler: Alamofire.CachedResponseHandler?
    
    /// for JSON encoding
    public internal(set) var encoding: Alamofire.ParameterEncoding?
    
    /// for Encodable encoder
    public internal(set) var encoder: Alamofire.ParameterEncoder?
}
