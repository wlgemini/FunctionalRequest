//
//  API+Method.swift
//

public struct GET<Parameters, Result>: API, ModifiedAPI {
    
    /// method
    public let method: String = "GET"

    /// path
    public let path: String
    
    /// init
    public init(_ path: String) {
        self.path = path
    }
}


public struct POST<Parameters, Result>: API, ModifiedAPI {
    
    /// method
    public let method: String = "POST"

    /// path
    public let path: String
    
    /// init
    public init(_ path: String) {
        self.path = path
    }
}


public struct PUT<Parameters, Result>: API, ModifiedAPI {
    
    /// method
    public let method: String = "PUT"

    /// path
    public let path: String
    
    /// init
    public init(_ path: String) {
        self.path = path
    }
}


public struct PATCH<Parameters, Result>: API, ModifiedAPI {
    
    /// method
    public let method: String = "PATCH"

    /// path
    public let path: String
    
    /// init
    public init(_ path: String) {
        self.path = path
    }
}


public struct DELETE<Parameters, Result>: API, ModifiedAPI {
    
    /// method
    public let method: String = "DELETE"

    /// path
    public let path: String
    
    /// init
    public init(_ path: String) {
        self.path = path
    }
}
