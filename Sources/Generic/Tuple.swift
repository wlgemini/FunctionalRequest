//
//  Tuple.swift
//


public struct Tuple2<T0, T1> {
    
    // MARK: Internal
    let t0: T0
    let t1: T1
    
    init(_ t0: T0, _ t1: T1) {
        self.t0 = t0
        self.t1 = t1
    }
}


public struct Tuple3<T0, T1, T2> {

    // MARK: Internal
    let t0: T0
    let t1: T1
    let t2: T2
    
    init(_ t0: T0, _ t1: T1, _ t2: T2) {
        self.t0 = t0
        self.t1 = t1
        self.t2 = t2
    }
}


public struct Tuple4<T0, T1, T2, T3> {
    
    // MARK: Internal
    let t0: T0
    let t1: T1
    let t2: T2
    let t3: T3
    
    init(_ t0: T0, _ t1: T1, _ t2: T2, _ t3: T3) {
        self.t0 = t0
        self.t1 = t1
        self.t2 = t2
        self.t3 = t3
    }
}
