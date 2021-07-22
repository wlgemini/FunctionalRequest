//
//  API.swift
//

// MARK: - API
public protocol API {
    
    /// Parameters
    associatedtype P
    
    /// Returns
    associatedtype R
    
    /// Modifiers
    associatedtype M: Modify
    
    /// modifiers
    var modifiers: Self.M { get }
}


extension API {
    
    public func modifier<M1>(_ m1: M1) -> _API<P, R, T2<M, M1>>
    where M1: Modify {
        _API(T2(self.modifiers, m1))
    }
    
    public func modifier<M1, M2>(_ m1: M1, _ m2: M2) -> _API<P, R, T3<M, M1, M2>>
    where M1: Modify, M2: Modify {
        _API(T3(self.modifiers, m1, m2))
    }
    
    public func modifier<M1, M2, M3>(_ m1: M1, _ m2: M2, _ m3: M3) -> _API<P, R, T4<M, M1, M2, M3>>
    where M1: Modify, M2: Modify, M3: Modify {
        _API(T4(self.modifiers, m1, m2, m3))
    }
}


// MARK: - _API
public struct _API<P, R, M: Modify>: API {
    
    public let modifiers: M
    
    // MARK: Internal
    init(_ m: M) {
        self.modifiers = m
    }
}


// MARK: - Tuple + Modifier
extension T2: Modify
where C0: Modify, C1: Modify {
    
    public func modify(context: Context) {
        self.c0.modify(context: context)
        self.c1.modify(context: context)
    }
}


extension T3: Modify
where C0: Modify, C1: Modify, C2: Modify {
    
    public func modify(context: Context) {
        self.c0.modify(context: context)
        self.c1.modify(context: context)
        self.c2.modify(context: context)
    }
}


extension T4: Modify
where C0: Modify, C1: Modify, C2: Modify, C3: Modify {
    
    public func modify(context: Context) {
        self.c0.modify(context: context)
        self.c1.modify(context: context)
        self.c2.modify(context: context)
        self.c3.modify(context: context)
    }
}
