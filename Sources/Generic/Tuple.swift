//
//  Tuple.swift
//


public struct T2<C0, C1> {
    
    public let c0: C0
    public let c1: C1
    
    public init(_ c0: C0, _ c1: C1) {
        self.c0 = c0
        self.c1 = c1
    }
}


public struct T3<C0, C1, C2> {

    public let c0: C0
    public let c1: C1
    public let c2: C2
    
    public init(_ c0: C0, _ c1: C1, _ c2: C2) {
        self.c0 = c0
        self.c1 = c1
        self.c2 = c2
    }
}


public struct T4<C0, C1, C2, C3> {
    
    public let c0: C0
    public let c1: C1
    public let c2: C2
    public let c3: C3
    
    public init(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3) {
        self.c0 = c0
        self.c1 = c1
        self.c2 = c2
        self.c3 = c3
    }
}
