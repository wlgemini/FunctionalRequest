//
//  URLModifier.swift
//

/// URLModifier
public struct URLModifier {
    
    public init(path: @escaping Compute<String>) {
        self.type = .path(path)
    }
    
    public init(base: @escaping Compute<String>) {
        self.type = .base(base)
    }
    
    public init(url: @escaping Compute<String>) {
        self.type = .url(url)
    }
    
    public init(mock: @escaping Compute<String>) {
        self.type = .mock(mock)
    }
    
    // MARK: Internal    
    let type: URLType
}


// MARK: - Modifier
extension URLModifier: Modifier {
    
    public func apply(to context: Context) {
        switch self.type {
        case .path(let path):
            if context.forAPI.path == nil {
                context.forAPI.path = path
            } else {
                fatalError("Can not modify `API.path`")
            }
            
            if let base = context.forAPI.base {
                context.forAPI.url = base() + path()
            }
            
        case .base(let base):
            context.forAPI.base = base
            if let path = context.forAPI.path {
                context.forAPI.url = base() + path()
            }
            
        case .url(let url):
            context.forAPI.url = url()
            
        case .mock(let mock):
            context.forAPI.mock = mock()
        }
    }
}


// MARK: - API
public extension API {

    func base(_ base: @escaping @autoclosure () -> String) -> some API {
        self.modifier(URLModifier(base: base))
    }
    
    func url(_ url: @escaping @autoclosure () -> String) -> some API {
        self.modifier(URLModifier(url: url))
    }
    
    func mock(_ mock: @escaping @autoclosure () -> String) -> some API {
        self.modifier(URLModifier(mock: mock))
    }
}
