//
//  Modifier.swift
//

/// For user defined custom modifier
public protocol Modifier {

    func apply(to context: ModifierContext)
}


extension Modifier {
    
    public func modifier<M>(_ m: M) -> some Modifier
    where M: Modifier {
        TupleModifier2(m0: self, m1: m)
    }
    
    public func modifier<M0, M1>(_ m0: M0, _ m1: M1) -> some Modifier
    where M0: Modifier, M1: Modifier {
        TupleModifier3(m0: self, m1: m0, m2: m1)
    }
    
    public func modifier<M0, M1, M2>(_ m0: M0, _ m1: M1, _ m2: M2) -> some Modifier
    where M0: Modifier, M1: Modifier, M2: Modifier {
        TupleModifier4(m0: self, m1: m0, m2: m1, m3: m2)
    }
}
