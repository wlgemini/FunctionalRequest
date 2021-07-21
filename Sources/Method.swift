//
//  Method.swift
//


// MARK: - Method
public protocol Method: API {
    
    var method: RM.HTTPMethod { get }
    
    var initialURL: RM.InitialURL { get }
    
    init(initialURL: RM.InitialURL)
}


public extension Method {
    
    var m: T2<RM.HTTPMethod, RM.InitialURL> {
        T2(self.method, self.initialURL)
    }
    
    init(_ path: @escaping @autoclosure Compute<String>) {
        self.init(initialURL: RM.InitialURL(path: path))
    }
    
    init(url: @escaping @autoclosure Compute<String>) {
        self.init(initialURL: RM.InitialURL(url: url))
    }
}


// MARK: - Methods
public struct GET<P, R>: Method {

    public let method = RM.HTTPMethod(method: .get)
    
    public let initialURL: RM.InitialURL
    
    public init(initialURL: RM.InitialURL) {
        self.initialURL = initialURL
    }
}


public struct POST<P, R>: Method {
    
    public let method = RM.HTTPMethod(method: .post)
    
    public let initialURL: RM.InitialURL
    
    public init(initialURL: RM.InitialURL) {
        self.initialURL = initialURL
    }
}


public struct PUT<P, R>: Method {
    
    public let method = RM.HTTPMethod(method: .put)
    
    public let initialURL: RM.InitialURL
    
    public init(initialURL: RM.InitialURL) {
        self.initialURL = initialURL
    }
}


public struct PATCH<P, R>: Method {
    
    public let method = RM.HTTPMethod(method: .patch)
    
    public let initialURL: RM.InitialURL
    
    public init(initialURL: RM.InitialURL) {
        self.initialURL = initialURL
    }
}


public struct DELETE<P, R>: Method {

    public let method = RM.HTTPMethod(method: .delete)
    
    public let initialURL: RM.InitialURL
    
    public init(initialURL: RM.InitialURL) {
        self.initialURL = initialURL
    }
}
