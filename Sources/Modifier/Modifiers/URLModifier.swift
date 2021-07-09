//
//  URLModifier.swift
//

/// URLModifier
public struct URLModifier {
    
    public init(appendPath: String) {
        self.type = .appendPath(appendPath)
    }
    
    public init(base: @escaping Compute<String>) {
        self.type = .base(base)
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
        case .appendPath(let path):
            context.forAPI.paths.append(path)
            
            if let base = context.forAPI.base {
                context.forAPI.url = base() + context.forAPI.paths.joined()
            }
            
        case .base(let base):
            context.forAPI.base = base
            if context.forAPI.paths.isEmpty == false {
                context.forAPI.url = base() + context.forAPI.paths.joined()
            }
            
        case .mock(let mock):
            context.forAPI.mock = mock()
        }
    }
}


// MARK: - API
public extension API {
    
    func appendPath(_ path: String) -> some API {
        self.modifier(URLModifier(appendPath: path))
    }

    func base(_ base: @escaping @autoclosure () -> String) -> some API {
        self.modifier(URLModifier(base: base))
    }
    
    func mock(_ mock: @escaping @autoclosure () -> String) -> some API {
        self.modifier(URLModifier(mock: mock))
    }
}
