//
//  TupleModifier.swift
//

public struct TupleModifier2<M0, M1>: Modifier
where M0: Modifier, M1: Modifier {
    
    public let m0: M0
    public let m1: M1
    
    public func apply(to context: ModifierContext) {
        self.m0.apply(to: context)
        self.m1.apply(to: context)
    }
}


public struct TupleModifier3<M0, M1, M2>: Modifier
where M0: Modifier, M1: Modifier, M2: Modifier {
    
    public let m0: M0
    public let m1: M1
    public let m2: M2
    
    public func apply(to context: ModifierContext) {
        self.m0.apply(to: context)
        self.m1.apply(to: context)
        self.m2.apply(to: context)
    }
}


public struct TupleModifier4<M0, M1, M2, M3>: Modifier
where M0: Modifier, M1: Modifier, M2: Modifier, M3: Modifier {
    
    public let m0: M0
    public let m1: M1
    public let m2: M2
    public let m3: M3
    
    public func apply(to context: ModifierContext) {
        self.m0.apply(to: context)
        self.m1.apply(to: context)
        self.m2.apply(to: context)
        self.m3.apply(to: context)
    }
}
