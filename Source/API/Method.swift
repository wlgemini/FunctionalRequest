//
//  Method.swift
//

import Alamofire


// MARK: - Method
public protocol Method: API {
        
    init(_ path: @escaping @autoclosure Compute<String>)
    
    init(url: @escaping @autoclosure Compute<String>)
}


// MARK: - Methods
public struct GET<P, R>: Method {
    
    public var modifier: some Modifier {
        self._modifier
    }

    public init(_ path: @escaping @autoclosure Compute<String>) {
        let modifier = AnyModifier(DataRequestModifier.HTTPMethod(method: .get),
                                   DataRequestModifier.InitialURL(path: path))
        self.init(modifier: modifier)
    }
    
    public init(url: @escaping @autoclosure Compute<String>) {
        let modifier = AnyModifier(DataRequestModifier.HTTPMethod(method: .get),
                                   DataRequestModifier.InitialURL(url: url))
        self.init(modifier: modifier)
    }
    
    public init(modifier: AnyModifier) {
        self._modifier = modifier
    }
    
    let _modifier: AnyModifier
}


public struct POST<P, R>: Method {
    
    public var modifier: some Modifier {
        self._modifier
    }

    public init(_ path: @escaping @autoclosure Compute<String>) {
        let modifier = AnyModifier(DataRequestModifier.HTTPMethod(method: .post),
                                   DataRequestModifier.InitialURL(path: path))
        self.init(modifier: modifier)
    }
    
    public init(url: @escaping @autoclosure Compute<String>) {
        let modifier = AnyModifier(DataRequestModifier.HTTPMethod(method: .post),
                                   DataRequestModifier.InitialURL(url: url))
        self.init(modifier: modifier)
    }
    
    public init(modifier: AnyModifier) {
        self._modifier = modifier
    }
    
    let _modifier: AnyModifier
}


public struct PUT<P, R>: Method {
    
    public var modifier: some Modifier {
        self._modifier
    }

    public init(_ path: @escaping @autoclosure Compute<String>) {
        let modifier = AnyModifier(DataRequestModifier.HTTPMethod(method: .put),
                                   DataRequestModifier.InitialURL(path: path))
        self.init(modifier: modifier)
    }
    
    public init(url: @escaping @autoclosure Compute<String>) {
        let modifier = AnyModifier(DataRequestModifier.HTTPMethod(method: .put),
                                   DataRequestModifier.InitialURL(url: url))
        self.init(modifier: modifier)
    }
    
    public init(modifier: AnyModifier) {
        self._modifier = modifier
    }
    
    let _modifier: AnyModifier
}


public struct PATCH<P, R>: Method {
    
    public var modifier: some Modifier {
        self._modifier
    }

    public init(_ path: @escaping @autoclosure Compute<String>) {
        let modifier = AnyModifier(DataRequestModifier.HTTPMethod(method: .patch),
                                   DataRequestModifier.InitialURL(path: path))
        self.init(modifier: modifier)
    }
    
    public init(url: @escaping @autoclosure Compute<String>) {
        let modifier = AnyModifier(DataRequestModifier.HTTPMethod(method: .patch),
                                   DataRequestModifier.InitialURL(url: url))
        self.init(modifier: modifier)
    }
    
    public init(modifier: AnyModifier) {
        self._modifier = modifier
    }
    
    let _modifier: AnyModifier
}


public struct DELETE<P, R>: Method {

    public var modifier: some Modifier {
        self._modifier
    }

    public init(_ path: @escaping @autoclosure Compute<String>) {
        let modifier = AnyModifier(DataRequestModifier.HTTPMethod(method: .delete),
                                   DataRequestModifier.InitialURL(path: path))
        self.init(modifier: modifier)
    }
    
    public init(url: @escaping @autoclosure Compute<String>) {
        let modifier = AnyModifier(DataRequestModifier.HTTPMethod(method: .delete),
                                   DataRequestModifier.InitialURL(url: url))
        self.init(modifier: modifier)
    }
    
    public init(modifier: AnyModifier) {
        self._modifier = modifier
    }
    
    let _modifier: AnyModifier
}
