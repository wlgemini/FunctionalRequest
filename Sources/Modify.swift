//
//  Modify.swift
//

import Alamofire


public enum Modify {
    
    // MARK: - Method/URL
    /// HTTPMethod
    public struct HTTPMethod: Modifier {
        
        public init(method: Alamofire.HTTPMethod) {
            self.method = method
        }
        
        public func apply(to context: Context) {
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
    public struct InitialURL: Modifier {
        
        public init(url: @escaping Compute<String>) {
            self._type = .full(url)
        }
        
        public init(path: @escaping Compute<String>) {
            self._type = .path(path)
        }
        
        public func apply(to context: Context) {
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
        
        public func apply(to context: Context) {
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

    // MARK: - Headers
    /// Headers
    public struct Headers: Modifier {
        
    }
    
    
    // MARK: - Encoder/Encoding
    /// Encoder
    // where ?
    
    
    /// encoding
    // where ?
    
    
    // MARK: - ?
    /// RequestModifier
    // ?
    
    
    // MARK: - Authenticate
    /// Authenticate
    
    
    // MARK: - Progress
    /// UploadProgress
    
    /// DownloadProgress
    
    // MARK: - Redirect
    /// Redirect
    
    
    // MARK: - CacheResponse
    /// CacheResponse
    
    
    // MARK: - cURLDescription
    /// cURLDescription
    
    
    // MARK: - ?
    /// onURLRequestCreation
    
    // MARK: - ?
    /// onURLSessionTaskCreation
    
    // MARK: - Validation
    /// Validation
    
    
    // MARK: - RequestInterceptor
    /// RequestInterceptor
    
    // MARK: - Download
    /// DownloadDestination
    
    
    // MARK: - Upload
    /// UploadFileManager
}

