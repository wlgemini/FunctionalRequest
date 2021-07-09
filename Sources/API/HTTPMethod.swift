//
//  HTTPMethod.swift
//

import Alamofire


// MARK: - Parameters/Returns Type
public typealias None = Void

public typealias JSON = [String : Any]


// MARK: - Method
public struct GET<Parameters, Returns>: API {

    public let urlModifier: URLModifier
    
    public var body: some Modifier {
        TupleModifier2(m0: MethodModifier(method: .get), m1: self.urlModifier)
    }
    
    init(_ path: String) {
        self.urlModifier = URLModifier(path: { path })
    }
    
    init(url: String) {
        self.urlModifier = URLModifier(url: { url })
    }
}


public struct POST<Parameters, Returns>: API {
    
    public let urlModifier: URLModifier
    
    public var body: some Modifier {
        TupleModifier2(m0: MethodModifier(method: .post), m1: self.urlModifier)
    }
    
    init(_ path: String) {
        self.urlModifier = URLModifier(path: { path })
    }
    
    init(url: String) {
        self.urlModifier = URLModifier(url: { url })
    }
}


public struct PUT<Parameters, Returns>: API {
    
    public let urlModifier: URLModifier
    
    public var body: some Modifier {
        TupleModifier2(m0: MethodModifier(method: .put), m1: self.urlModifier)
    }
    
    init(_ path: String) {
        self.urlModifier = URLModifier(path: { path })
    }
    
    init(url: String) {
        self.urlModifier = URLModifier(url: { url })
    }
}


public struct PATCH<Parameters, Returns>: API {
    
    public let urlModifier: URLModifier
    
    public var body: some Modifier {
        TupleModifier2(m0: MethodModifier(method: .patch), m1: self.urlModifier)
    }
    
    init(_ path: String) {
        self.urlModifier = URLModifier(path: { path })
    }
    
    init(url: String) {
        self.urlModifier = URLModifier(url: { url })
    }
}


public struct DELETE<Parameters, Returns>: API {

    public let urlModifier: URLModifier
    
    public var body: some Modifier {
        TupleModifier2(m0: MethodModifier(method: .delete), m1: self.urlModifier)
    }
    
    init(_ path: String) {
        self.urlModifier = URLModifier(path: { path })
    }
    
    init(url: String) {
        self.urlModifier = URLModifier(url: { url })
    }
}
