//
//  HTTPMethod.swift
//


// MARK: - Parameters/Result Type
public typealias None = Void


public typealias JSON = [String : Any]


// MARK: - Method
public struct GET<Parameters, Result>: API {

    public let urlModifier: URLModifier
    
    public var body: some Modifier {
        TupleModifier2(m0: MethodModifier(method: "GET"),
                       m1: self.urlModifier)
    }
    
    init(_ path: String) {
        self.urlModifier = URLModifier(path: { path })
    }
    
    init(url: String) {
        self.urlModifier = URLModifier(url: { url })
    }
}


public struct POST<Parameters, Result>: API {
    
    public let urlModifier: URLModifier
    
    public var body: some Modifier {
        TupleModifier2(m0: MethodModifier(method: "POST"),
                       m1: self.urlModifier)
    }
    
    init(_ path: String) {
        self.urlModifier = URLModifier(path: { path })
    }
    
    init(url: String) {
        self.urlModifier = URLModifier(url: { url })
    }
}


public struct PUT<Parameters, Result>: API {
    
    public let urlModifier: URLModifier
    
    public var body: some Modifier {
        TupleModifier2(m0: MethodModifier(method: "PUT"),
                       m1: self.urlModifier)
    }
    
    init(_ path: String) {
        self.urlModifier = URLModifier(path: { path })
    }
    
    init(url: String) {
        self.urlModifier = URLModifier(url: { url })
    }
}


public struct PATCH<Parameters, Result>: API {
    
    public let urlModifier: URLModifier
    
    public var body: some Modifier {
        TupleModifier2(m0: MethodModifier(method: "PATCH"),
                       m1: self.urlModifier)
    }
    
    init(_ path: String) {
        self.urlModifier = URLModifier(path: { path })
    }
    
    init(url: String) {
        self.urlModifier = URLModifier(url: { url })
    }
}


public struct DELETE<Parameters, Result>: API {

    public let urlModifier: URLModifier
    
    public var body: some Modifier {
        TupleModifier2(m0: MethodModifier(method: "DELETE"),
                       m1: self.urlModifier)
    }
    
    init(_ path: String) {
        self.urlModifier = URLModifier(path: { path })
    }
    
    init(url: String) {
        self.urlModifier = URLModifier(url: { url })
    }
}
