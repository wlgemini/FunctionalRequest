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
    var type: URLType
}


// MARK: Modifier
extension URLModifier: Modifier {
    
    public func apply(to context: Context) {
        // make url from URLType cases
        context.urls.append(self.type)
    }
}


// MARK: - Modify URL
public extension API {
    
    func path(_ path: @escaping @autoclosure () -> String) -> some API {
        self.modifier(URLModifier(path: path))
    }

    func base(_ base: @escaping @autoclosure () -> String) -> some API {
        self.modifier(URLModifier(base: base))
    }
    
    func url(_ url: @escaping @autoclosure () -> String) -> some API {
        self.modifier(URLModifier(url: url))
    }
}
