//
//  URLModifier.swift
//
//  Ref: https://developer.mozilla.org/en-US/docs/Learn/Common_questions/What_is_a_URL
//


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
public struct InitialURL {
    
    public init(url: @escaping Compute<String>) {
        self.type = .full(url)
    }
    
    public init(path: @escaping Compute<String>) {
        self.type = .path(path)
    }
    
    // MARK: Internal
    let type: _Type
    
    enum _Type {
        
        case full(Compute<String>)
        
        case path(Compute<String>)
    }
}


/// URLModifier
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
public struct URLModifier {
    
    public init(base: @escaping Compute<String>) {
        self.type = .base(base)
    }
    
    public init(appendPath: @escaping Compute<String>) {
        self.type = .appendPath(appendPath)
    }
    
    public init(mock: @escaping Compute<String>) {
        self.type = .mock(mock)
    }
    
    // MARK: Internal    
    let type: _Type
    
    enum _Type {
        
        case base(Compute<String>)
        
        case appendPath(Compute<String>)
        
        case mock(Compute<String>)
    }
}


// MARK: - Modifier
extension InitialURL: Modifier {
    
    public func apply(to context: Context) {
        if context.forAPI.initialURL == nil {
            context.forAPI.initialURL = self.type
        } else {
            _Log.warning("Modifier `InitialURL` should set only once", location: context.requestLocation)
        }
    }
}


extension URLModifier: Modifier {
    
    public func apply(to context: Context) {
        guard context.forAPI.initialURL != nil else {
            _Log.error("Modifier `InitialURL` not set", location: context.requestLocation)
            return
        }
        
        switch self.type {
        case .base(let base):
            context.forAPI.base = base
            
        case .appendPath(let appendPath):
            context.forAPI.appendPaths.append(appendPath)
            
        case .mock(let mock):
            context.forAPI.mock = mock
        }
    }
}


// MARK: - API
public extension API {
    
    /// base url
    func base(_ base: @escaping @autoclosure Compute<String>) -> some API {
        self.modifier(URLModifier(base: base))
    }
    
    /// append path
    func appendPath(_ appendPath: @escaping @autoclosure Compute<String>) -> some API {
        self.modifier(URLModifier(appendPath: appendPath))
    }
    
    /// mocking with full url
    func mock(_ mock: @escaping @autoclosure Compute<String>) -> some API {
        self.modifier(URLModifier(mock: mock))
    }
}
