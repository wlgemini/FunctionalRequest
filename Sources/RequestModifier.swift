//
//  RequestModifier.swift
//

import Foundation
import Alamofire


/// RM
public typealias RM = RequestModifier


/// RequestModifier
public enum RequestModifier {

    // MARK: - Method/URL
    /// HTTPMethod
    public struct HTTPMethod: Modify {
        
        public init(method: Alamofire.HTTPMethod) {
            self.method = method
        }
        
        public func modify(context: Context) {
            if context.forAPI.method == nil {
                context.forAPI.method = self.method
            } else {
                fatalError("Can not modify `HTTPMethod`")
            }
        }
        
        let method: Alamofire.HTTPMethod
    }


    /// InitialURL
    ///
    /// some type examples:
    ///
    ///     http://www.example.com/some/path/to/file
    ///     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
    ///                                         full
    ///
    ///     http://www.example.com/some/path/to/file
    ///                           ~~~~~~~~~~~~~~~~~^
    ///                                         path
    ///
    public struct InitialURL: Modify {
        
        public init(url: @escaping Compute<String>) {
            self._type = .full(url)
        }
        
        public init(path: @escaping Compute<String>) {
            self._type = .path(path)
        }
        
        public func modify(context: Context) {
            if context.forAPI.initialURL == nil {
                context.forAPI.initialURL = self._type
            } else {
                _Log.warning("`InitialURL` should set only once", location: context.requestLocation)
            }
        }
        
        let _type: _Type
        
        enum _Type {
            
            case full(Compute<String>)
            
            case path(Compute<String>)
        }
    }


    /// URL
    ///
    /// some type examples:
    ///
    ///     http://www.example.com/some/path/to/file
    ///     ~~~~~~~~~~~~~~~~~~~~~^
    ///                       base
    ///
    ///     http://www.example.com/some/path/to/file/appendPath
    ///                                             ~~~~~~~~~~^
    ///                                              appendPath
    ///
    ///     http://www.mock.com/some/path/to/file/appendPath
    ///     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
    ///                                                 mock
    ///
    public struct URL: Modify {
        
        public init(base: @escaping Compute<String>) {
            self._type = .base(base)
        }
        
        public init(appendPath: @escaping Compute<String>) {
            self._type = .appendPath(appendPath)
        }
        
        public init(mock: @escaping Compute<String>) {
            self._type = .mock(mock)
        }
        
        public func modify(context: Context) {
            guard context.forAPI.initialURL != nil else {
                _Log.error("Modifier `InitialURL` not set", location: context.requestLocation)
                return
            }
            
            switch self._type {
            case .base(let base):
                context.forAPI.base = base
                
            case .appendPath(let appendPath):
                context.forAPI.appendPaths.append(appendPath)
                
            case .mock(let mock):
                context.forAPI.mock = mock
            }
        }
        
        let _type: _Type
        
        enum _Type {
            
            case base(Compute<String>)
            
            case appendPath(Compute<String>)
            
            case mock(Compute<String>)
        }
    }

    // MARK: - HTTPHeaders
    /// Headers
    public struct HTTPHeaders: Modify {
        
        public init(_ headers: Alamofire.HTTPHeaders) {
            self._headers = headers
        }
        
        public func modify(context: Context) {
            
        }
        
        let _headers: Alamofire.HTTPHeaders
    }
    
    
    // MARK: - Encoder/Encoding
    /// Encoder
    public struct Encoder: Modify {
        
        public init(_ encoder: Alamofire.ParameterEncoder) {
            self._encoder = encoder
        }
        
        public func modify(context: Context) {
            
        }
        
        let _encoder: Alamofire.ParameterEncoder
    }
    
    
    /// Encoding
    public struct Encoding: Modify {
        
        public init(_ encoding: Alamofire.ParameterEncoding) {
            self._encoding = encoding
        }
        
        public func modify(context: Context) {
            
        }
        
        let _encoding: Alamofire.ParameterEncoding
    }
    
    
    // MARK: - Authenticate
    /// Authenticate
    public struct Authenticate: Modify {
        
        public init(username: String, password: String, persistence: URLCredential.Persistence) {
            self._type = .authenticate(username: username, password: password, persistence: persistence)
        }
        
        public init(credential: URLCredential) {
            self._type = .authenticate(credential: credential)
        }
        
        public func modify(context: Context) {
            
        }
        
        let _type: _Type
        
        enum _Type {
            
            case authenticate(username: String, password: String, persistence: URLCredential.Persistence)
            
            case authenticate(credential: URLCredential)
        }
    }
    
    
    // MARK: - Redirect
    /// Redirect
    public struct Redirect: Modify {
        
        public init(using handler: Alamofire.RedirectHandler) {
            self._handler = handler
        }
        
        public func modify(context: Context) {
            
        }
        
        let _handler: Alamofire.RedirectHandler
    }
    
    
    // MARK: - CacheResponse
    /// CacheResponse
    public struct CacheResponse: Modify {
        
        public init(using handler: Alamofire.CachedResponseHandler) {
            self._handler = handler
        }
        
        public func modify(context: Context) {
            
        }
        
        let _handler: Alamofire.CachedResponseHandler
    }
    
    
    // MARK: - Validation
    /// Validation
    public struct Validation<S: Sequence>: Modify {
        
        public init(statusCode acceptableStatusCodes: S)
        where S.Iterator.Element == Int {
            self._type = .statusCode(acceptableStatusCodes)
        }
        
        public init(contentType acceptableContentTypes: @escaping Compute<S>)
        where S.Iterator.Element == String {
            self._type = .contentType(acceptableContentTypes)
        }
        
        public func modify(context: Context) {
            
        }
        
        let _type: _Type<S>
        
        enum _Type<T> {
            
            case statusCode(T)
            
            case contentType(Compute<T>)
        }
    }
}

