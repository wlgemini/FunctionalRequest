//
//  ModifyURL.swift
//
//  Ref: https://developer.mozilla.org/en-US/docs/Learn/Common_questions/What_is_a_URL
//


/// ModifyURL
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
public struct ModifyURL: URLModifier {
    
    public init(base: @escaping Compute<String>) {
        self._type = .base(base)
    }
    
    public init(appendPath: @escaping Compute<String>) {
        self._type = .appendPath(appendPath)
    }
    
    public init(mock: @escaping Compute<String>) {
        self._type = .mock(mock)
    }
    
    // MARK: URLModifier
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
    
    // MARK: Internal    
    let _type: _Type
    
    enum _Type {
        
        case base(Compute<String>)
        
        case appendPath(Compute<String>)
        
        case mock(Compute<String>)
    }
}


// MARK: - Method
public extension Method {
    
    /// base url
    func base(_ base: @escaping @autoclosure Compute<String>) -> some Method {
        self.modifier(ModifyURL(base: base))
    }
    
    /// append path
    func appendPath(_ appendPath: @escaping @autoclosure Compute<String>) -> some Method {
        self.modifier(ModifyURL(appendPath: appendPath))
    }
    
    /// mocking with full url
    func mock(_ mock: @escaping @autoclosure Compute<String>) -> some Method {
        self.modifier(ModifyURL(mock: mock))
    }
}
