//
//  Methods.swift
//


public struct GET<Parameters, Returns>: API {

    public let initialURL: InitialURL
    
    public var m0: some Modifier {
        Tuple2(Method(method: .get), self.initialURL)
    }
    
    public init(_ path: @escaping Compute<String>) {
        self.initialURL = InitialURL(path: path)
    }
    
    public init(url: @escaping Compute<String>) {
        self.initialURL = InitialURL(url: url)
    }
}


public struct POST<Parameters, Returns>: API {
    
    public let initialURL: InitialURL
    
    public var m0: some Modifier {
        Tuple2(Method(method: .post), self.initialURL)
    }
    
    public init(_ path: @escaping Compute<String>) {
        self.initialURL = InitialURL(path: path)
    }
    
    public init(url: @escaping Compute<String>) {
        self.initialURL = InitialURL(url: url)
    }
}


public struct PUT<Parameters, Returns>: API {
    
    public let initialURL: InitialURL
    
    public var m0: some Modifier {
        Tuple2(Method(method: .put), self.initialURL)
    }
    
    public init(_ path: @escaping Compute<String>) {
        self.initialURL = InitialURL(path: path)
    }
    
    public init(url: @escaping Compute<String>) {
        self.initialURL = InitialURL(url: url)
    }
}


public struct PATCH<Parameters, Returns>: API {
    
    public let initialURL: InitialURL
    
    public var m0: some Modifier {
        Tuple2(Method(method: .patch), self.initialURL)
    }
    
    public init(_ path: @escaping Compute<String>) {
        self.initialURL = InitialURL(path: path)
    }
    
    public init(url: @escaping Compute<String>) {
        self.initialURL = InitialURL(url: url)
    }
}


public struct DELETE<Parameters, Returns>: API {

    public let initialURL: InitialURL
    
    public var m0: some Modifier {
        Tuple2(Method(method: .delete), self.initialURL)
    }
    
    public init(_ path: @escaping Compute<String>) {
        self.initialURL = InitialURL(path: path)
    }
    
    public init(url: @escaping Compute<String>) {
        self.initialURL = InitialURL(url: url)
    }
}

