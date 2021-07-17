//
//  API.swift
//

// MARK: - API
public protocol API {
    
    /// Parameters
    associatedtype P
    
    /// Returns
    associatedtype R
    
    /// Modifier
    associatedtype M: Modifier
    
    /// modifier
    var m: Self.M { get }
}


extension API {
    
    public func modifier<M1>(_ m1: M1) -> _API<P, R, Tuple2<Self.M, M1>>
    where M1: Modifier {
        _API(Tuple2(self.m, m1))
    }
    
    public func modifier<M1, M2>(_ m1: M1, _ m2: M2) -> _API<P, R, Tuple3<Self.M, M1, M2>>
    where M1: Modifier, M2: Modifier {
        _API(Tuple3(self.m, m1, m2))
    }
    
    public func modifier<M1, M2, M3>(_ m1: M1, _ m2: M2, _ m3: M3) -> _API<P, R, Tuple4<Self.M, M1, M2, M3>>
    where M1: Modifier, M2: Modifier, M3: Modifier {
        _API(Tuple4(self.m, m1, m2, m3))
    }
}


// MARK: - _API
public struct _API<P, R, M: Modifier>: API {
    
    public let m: M
    
    // MARK: Internal
    init(_ m: M) {
        self.m = m
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
