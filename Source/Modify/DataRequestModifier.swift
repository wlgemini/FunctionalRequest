//
//  DataRequestModifier.swift
//

import Foundation
import Alamofire


/// DataRequestModifier
public enum DataRequestModifier {

    // MARK: - Method/URL
    /// HTTPMethod
    public struct HTTPMethod: Modifier {
        
        public init(method: Alamofire.HTTPMethod) {
            self.method = method
        }
        
        public func modify(context: Context) {
            if context.dataRequest.api.method == nil {
                context.dataRequest.api.method = self.method
            } else {
                _Log.error("Can not modify `HTTPMethod`", location: context.requestLocation)
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
    public struct InitialURL: Modifier {
        
        public init(url: @escaping Compute<String>) {
            self._type = .full(url)
        }
        
        public init(path: @escaping Compute<String>) {
            self._type = .path(path)
        }
        
        public func modify(context: Context) {
            if context.dataRequest.api.initialURL == nil {
                context.dataRequest.api.initialURL = self._type
            } else {
                _Log.error("Can not modify `InitialURL`", location: context.requestLocation)
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
    public struct URL: Modifier {
        
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
            switch self._type {
            case .base(let base):
                context.dataRequest.api.base = base
                
            case .appendPath(let appendPath):
                context.dataRequest.api.appendPaths.append(appendPath)
                
            case .mock(let mock):
                context.dataRequest.api.mock = mock
            }
        }
        
        let _type: _Type
        
        enum _Type {
            
            case base(Compute<String>)
            
            case appendPath(Compute<String>)
            
            case mock(Compute<String>)
        }
    }

    // MARK: - HTTPHeader
    /// Headers
    public struct HTTPHeader: Modifier {
        
        public init(_ header: Alamofire.HTTPHeader) {
            self._header = header
        }
        
        public func modify(context: Context) {
            context.dataRequest.headers.add(self._header)
        }
        
        let _header: Alamofire.HTTPHeader
    }
    
    
    // MARK: - Encoder/Encoding
    /// Encoder
    public struct Encoder: Modifier {
        
        public init(_ encoder: Alamofire.ParameterEncoder) {
            self._encoder = encoder
        }
        
        public func modify(context: Context) {
            context.dataRequest.encoder = self._encoder
        }
        
        let _encoder: Alamofire.ParameterEncoder
    }
    
    
    /// Encoding
    public struct Encoding: Modifier {
        
        public init(_ encoding: Alamofire.ParameterEncoding) {
            self._encoding = encoding
        }
        
        public func modify(context: Context) {
            context.dataRequest.encoding = self._encoding
        }
        
        let _encoding: Alamofire.ParameterEncoding
    }
    
    
    // MARK: - Modify URLRequest
    /// TimeoutInterval
    public struct TimeoutInterval: Modifier {
        
        public init(_ timeInterval: TimeInterval) {
            self._timeInterval = timeInterval
        }
        
        public func modify(context: Context) {
            context.dataRequest.urlRequestModifiers.append { [timeInterval = self._timeInterval] urlRequest in
                urlRequest.timeoutInterval = timeInterval
            }
        }
        
        let _timeInterval: TimeInterval
    }
    
    
    // MARK: - Authenticate
    /// Authenticate
    public struct Authenticate: Modifier {
        
        public init(username: String, password: String, persistence: URLCredential.Persistence) {
            self._credential = URLCredential(user: username, password: password, persistence: persistence)
        }
        
        public init(credential: URLCredential) {
            self._credential = credential
        }
        
        public func modify(context: Context) {
            context.dataRequest.authenticate = self._credential
        }
        
        let _credential: URLCredential
    }
    
    
    // MARK: - Redirect
    /// Redirect
    public struct Redirect: Modifier {
        
        public init(using handler: Alamofire.RedirectHandler) {
            self._handler = handler
        }
        
        public func modify(context: Context) {
            context.dataRequest.redirectHandler = self._handler
        }
        
        let _handler: Alamofire.RedirectHandler
    }
}
