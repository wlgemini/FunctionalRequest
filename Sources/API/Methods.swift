//
//  Methods.swift
//


public struct GET<Parameters, Returns>: Method {

    public let initialURL: ModifyInitialURL
    
    public var body: some Modifier {
        ModifyTuple2(m0: ModifyMethod(method: .get), m1: self.initialURL)
    }
    
    public init(_ path: @escaping Compute<String>) {
        self.initialURL = ModifyInitialURL(path: path)
    }
    
    public init(url: @escaping Compute<String>) {
        self.initialURL = ModifyInitialURL(url: url)
    }
}


public struct POST<Parameters, Returns>: Method {
    
    public let initialURL: ModifyInitialURL
    
    public var body: some Modifier {
        ModifyTuple2(m0: ModifyMethod(method: .post), m1: self.initialURL)
    }
    
    public init(_ path: @escaping Compute<String>) {
        self.initialURL = ModifyInitialURL(path: path)
    }
    
    public init(url: @escaping Compute<String>) {
        self.initialURL = ModifyInitialURL(url: url)
    }
}


public struct PUT<Parameters, Returns>: Method {
    
    public let initialURL: ModifyInitialURL
    
    public var body: some Modifier {
        ModifyTuple2(m0: ModifyMethod(method: .put), m1: self.initialURL)
    }
    
    public init(_ path: @escaping Compute<String>) {
        self.initialURL = ModifyInitialURL(path: path)
    }
    
    public init(url: @escaping Compute<String>) {
        self.initialURL = ModifyInitialURL(url: url)
    }
}


public struct PATCH<Parameters, Returns>: Method {
    
    public let initialURL: ModifyInitialURL
    
    public var body: some Modifier {
        ModifyTuple2(m0: ModifyMethod(method: .patch), m1: self.initialURL)
    }
    
    public init(_ path: @escaping Compute<String>) {
        self.initialURL = ModifyInitialURL(path: path)
    }
    
    public init(url: @escaping Compute<String>) {
        self.initialURL = ModifyInitialURL(url: url)
    }
}


public struct DELETE<Parameters, Returns>: Method {

    public let initialURL: ModifyInitialURL
    
    public var body: some Modifier {
        ModifyTuple2(m0: ModifyMethod(method: .delete), m1: self.initialURL)
    }
    
    public init(_ path: @escaping Compute<String>) {
        self.initialURL = ModifyInitialURL(path: path)
    }
    
    public init(url: @escaping Compute<String>) {
        self.initialURL = ModifyInitialURL(url: url)
    }
}

