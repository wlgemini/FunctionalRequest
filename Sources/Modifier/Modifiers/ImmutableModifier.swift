//
//  ImmutableModifier.swift
//

import Alamofire


/// ModifyInitialURL
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
public struct ModifyInitialURL: Modifier {
    
    public init(url: @escaping Compute<String>) {
        self._type = .full(url)
    }
    
    public init(path: @escaping Compute<String>) {
        self._type = .path(path)
    }
    
    // MARK: InitialURLModifier
    public func apply(to context: Context) {
        if context.forAPI.initialURL == nil {
            context.forAPI.initialURL = self._type
        } else {
            _Log.warning("`ModifyInitialURL` should set only once", location: context.requestLocation)
        }
    }
    
    // MARK: Internal
    let _type: _Type
    
    enum _Type {
        
        case full(Compute<String>)
        
        case path(Compute<String>)
    }
}


/// ModifyMethod
public struct ModifyMethod: Modifier {
    
    public init(method: Alamofire.HTTPMethod) {
        self.method = method
    }
    
    // MARK: URLModifier
    public func apply(to context: Context) {
        if context.forAPI.method == nil {
            context.forAPI.method = self.method
        } else {
            fatalError("Can not modify `HTTPMethod`")
        }
    }
    
    // MARK: Internal
    let method: Alamofire.HTTPMethod
}
