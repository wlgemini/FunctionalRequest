//
//  Method.swift
//

import Alamofire


// MARK: - Method
public protocol Method: API {
    
    var method: Alamofire.HTTPMethod { get }
    
    var initialURL: NonmutatingModifier.InitialURL { get }
    
    init(initialURL: NonmutatingModifier.InitialURL)
}


public extension Method {
    
    var modifiers: T2<NonmutatingModifier.HTTPMethod, NonmutatingModifier.InitialURL> {
        T2(NonmutatingModifier.HTTPMethod(method: self.method), self.initialURL)
    }
    
    init(_ path: @escaping @autoclosure Compute<String>) {
        self.init(initialURL: NonmutatingModifier.InitialURL(path: path))
    }
    
    init(url: @escaping @autoclosure Compute<String>) {
        self.init(initialURL: NonmutatingModifier.InitialURL(url: url))
    }
}


// MARK: - Methods
public struct GET<P, R>: Method {

    public let method = Alamofire.HTTPMethod.get
    
    public let initialURL: NonmutatingModifier.InitialURL
    
    public init(initialURL: NonmutatingModifier.InitialURL) {
        self.initialURL = initialURL
    }
}


public struct POST<P, R>: Method {
    
    public let method = Alamofire.HTTPMethod.post
    
    public let initialURL: NonmutatingModifier.InitialURL
    
    public init(initialURL: NonmutatingModifier.InitialURL) {
        self.initialURL = initialURL
    }
}


public struct PUT<P, R>: Method {
    
    public let method = Alamofire.HTTPMethod.put
    
    public let initialURL: NonmutatingModifier.InitialURL
    
    public init(initialURL: NonmutatingModifier.InitialURL) {
        self.initialURL = initialURL
    }
}


public struct PATCH<P, R>: Method {
    
    public let method = Alamofire.HTTPMethod.patch
    
    public let initialURL: NonmutatingModifier.InitialURL
    
    public init(initialURL: NonmutatingModifier.InitialURL) {
        self.initialURL = initialURL
    }
}


public struct DELETE<P, R>: Method {

    public let method = Alamofire.HTTPMethod.delete
    
    public let initialURL: NonmutatingModifier.InitialURL
    
    public init(initialURL: NonmutatingModifier.InitialURL) {
        self.initialURL = initialURL
    }
}
