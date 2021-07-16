//
//  API.swift
//

// MARK: - API
public protocol API {
    
    /// Parameters
    associatedtype Parameters
    
    /// Returns
    associatedtype Returns
    
    /// M0
    associatedtype M0: Modifier
    
    /// M0
    var m0: Self.M0 { get }
}


extension API {
    
    public func modifier<M1>(_ m1: M1) -> ModifiedAPI<Parameters, Returns, Tuple2<Self.M0, M1>>
    where M1: Modifier {
        ModifiedAPI(Tuple2(self.m0, m1))
    }
    
    public func modifier<M1, M2>(_ m1: M1, _ m2: M2) -> ModifiedAPI<Parameters, Returns, Tuple3<Self.M0, M1, M2>>
    where M1: Modifier, M2: Modifier {
        ModifiedAPI(Tuple3(self.m0, m1, m2))
    }
    
    public func modifier<M1, M2, M3>(_ m1: M1, _ m2: M2, _ m3: M3) -> ModifiedAPI<Parameters, Returns, Tuple4<Self.M0, M1, M2, M3>>
    where M1: Modifier, M2: Modifier, M3: Modifier {
        ModifiedAPI(Tuple4(self.m0, m1, m2, m3))
    }
}


// MARK: - ModifiedAPI
public struct ModifiedAPI<Parameters, Returns, M0: Modifier>: API {
    
    public let m0: M0
    
    init(_ m0: M0) {
        self.m0 = m0
    }
}


// MARK: - Tuple + Modifier
extension Tuple2: Modifier
where T0: Modifier, T1: Modifier {
    
    public func apply(to context: Context) {
        self.t0.apply(to: context)
        self.t1.apply(to: context)
    }
}


extension Tuple3: Modifier
where T0: Modifier, T1: Modifier, T2: Modifier {
    
    public func apply(to context: Context) {
        self.t0.apply(to: context)
        self.t1.apply(to: context)
        self.t2.apply(to: context)
    }
}


extension Tuple4: Modifier
where T0: Modifier, T1: Modifier, T2: Modifier, T3: Modifier {
    
    public func apply(to context: Context) {
        self.t0.apply(to: context)
        self.t1.apply(to: context)
        self.t2.apply(to: context)
        self.t3.apply(to: context)
    }
}
