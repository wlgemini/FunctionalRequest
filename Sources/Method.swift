//
//  Method.swift
//

public struct GET<Parameters, Result>: API {
    
    /// method
    public let method: String = "GET"

    /// path
    public let path: String
    
    /// init
    public init(_ path: String) {
        self.path = path
    }
}


public struct POST<Parameters, Result>: API {
    
    /// method
    public let method: String = "POST"

    /// path
    public let path: String
    
    /// init
    public init(_ path: String) {
        self.path = path
    }
}


public struct PUT<Parameters, Result>: API {
    
    /// method
    public let method: String = "PUT"

    /// path
    public let path: String
    
    /// init
    public init(_ path: String) {
        self.path = path
    }
}


public struct PATCH<Parameters, Result>: API {
    
    /// method
    public let method: String = "PATCH"

    /// path
    public let path: String
    
    /// init
    public init(_ path: String) {
        self.path = path
    }
}


public struct DELETE<Parameters, Result>: API {
    
    /// method
    public let method: String = "DELETE"

    /// path
    public let path: String
    
    /// init
    public init(_ path: String) {
        self.path = path
    }
}


// MARK: - Method modifiers impl
extension API {
    
    /// modifiers
    public var modifiers: some Modifier {
        return ModifierPair(first: MethodModifier(method: self.method),
                            second: PathModifier(path: self.path))
    }
}
