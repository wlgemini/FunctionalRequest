//
//  NonmutatingModifier.swift
//  

import Foundation
import Alamofire


/// NonmutatingModifier
public enum NonmutatingModifier {
    
    // MARK: - Method/URL
    /// HTTPMethod
    public struct HTTPMethod: Modify {
        
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
    public struct InitialURL: Modify {
        
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
                _Log.error("`InitialURL` should set only once", location: context.requestLocation)
            }
        }
        
        let _type: _Type
        
        enum _Type {
            
            case full(Compute<String>)
            
            case path(Compute<String>)
        }
    }


    // MARK: - Accessing
    /// AccessingValue
    public struct AccessingValue<Value: Any>: Modify {
        
        public func modify(context: Context) {
            
        }
        
        var _onAvailable: (Value) -> Void
        
        init(onAvailable: @escaping (Value) -> Void) {
            self._onAvailable = onAvailable
        }
    }
    
    /// AccessingObject
    public struct AccessingObject<Object: AnyObject>: Modify {
        
        public func modify(context: Context) {
            
        }
        
        var _onAvailable: (Object) -> Void
        
        init(onAvailable: @escaping (Object) -> Void) {
            self._onAvailable = onAvailable
        }
    }
}
