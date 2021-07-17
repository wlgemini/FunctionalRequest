//
//  Method.swift
//


// MARK: - Method
public protocol Method: API {
    
    var method: Modify.HTTPMethod { get }
    
    var initialURL: Modify.InitialURL { get }
    
    init(initialURL: Modify.InitialURL)
}


public extension Method {
    
    var m: Tuple2<Modify.HTTPMethod, Modify.InitialURL> {
        Tuple2(self.method, self.initialURL)
    }
    
    init(_ path: @escaping @autoclosure Compute<String>) {
        self.init(initialURL: Modify.InitialURL(path: path))
    }
    
    init(url: @escaping @autoclosure Compute<String>) {
        self.init(initialURL: Modify.InitialURL(url: url))
    }
}


// MARK: - Methods
public struct GET<P, R>: Method {

    public let method = Modify.HTTPMethod(method: .get)
    
    public let initialURL: Modify.InitialURL
    
    public init(initialURL: Modify.InitialURL) {
        self.initialURL = initialURL
    }
}


public struct POST<P, R>: Method {
    
    public let method = Modify.HTTPMethod(method: .post)
    
    public let initialURL: Modify.InitialURL
    
    public init(initialURL: Modify.InitialURL) {
        self.initialURL = initialURL
    }
}


public struct PUT<P, R>: Method {
    
    public let method = Modify.HTTPMethod(method: .put)
    
    public let initialURL: Modify.InitialURL
    
    public init(initialURL: Modify.InitialURL) {
        self.initialURL = initialURL
    }
}


public struct PATCH<P, R>: Method {
    
    public let method = Modify.HTTPMethod(method: .patch)
    
    public let initialURL: Modify.InitialURL
    
    public init(initialURL: Modify.InitialURL) {
        self.initialURL = initialURL
    }
}


public struct DELETE<P, R>: Method {

    public let method = Modify.HTTPMethod(method: .delete)
    
    public let initialURL: Modify.InitialURL
    
    public init(initialURL: Modify.InitialURL) {
        self.initialURL = initialURL
    }
}
