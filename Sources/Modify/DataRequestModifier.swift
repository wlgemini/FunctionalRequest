//
//  DataRequestModifier.swift
//

import Foundation
import Alamofire


/// DataRequestModifier
public enum DataRequestModifier {

    // MARK: - URL
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
            guard context.dataRequest.api.initialURL != nil else {
                _Log.error("Modifier `InitialURL` not set", location: context.requestLocation)
                return
            }
            
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
}



