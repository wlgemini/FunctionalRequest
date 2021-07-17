//
//  Tuple.swift
//


public struct Tuple2<T0, T1> {
    
    public let t0: T0
    public let t1: T1
    
    public init(_ t0: T0, _ t1: T1) {
        self.t0 = t0
        self.t1 = t1
    }
}


public struct Tuple3<T0, T1, T2> {

    public let t0: T0
    public let t1: T1
    public let t2: T2
    
    public init(_ t0: T0, _ t1: T1, _ t2: T2) {
        self.t0 = t0
        self.t1 = t1
        self.t2 = t2
    }
}


public struct Tuple4<T0, T1, T2, T3> {
    
    public let t0: T0
    public let t1: T1
    public let t2: T2
    public let t3: T3
    
    public init(_ t0: T0, _ t1: T1, _ t2: T2, _ t3: T3) {
        self.t0 = t0
        self.t1 = t1
        self.t2 = t2
        self.t3 = t3
    }
}
