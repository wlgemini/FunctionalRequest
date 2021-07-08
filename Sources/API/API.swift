//
//  API.swift
//

public protocol API {
    
    /// Parameters
    associatedtype Parameters
    
    /// Result
    associatedtype Result
    
    /// Body
    associatedtype Body: Modifier
    
    /// body
    var body: Self.Body { get }
}


public extension API {
    
    /// modifier
    func modifier<M>(_ m: M) -> some API
    where M: Modifier {
        let tuple2 = TupleModifier2(m0: self.body, m1: m)
        return _API<Parameters, Result, TupleModifier2>(body: tuple2)
    }
    
    /// modifier
    func modifier<M0, M1>(_ m0: M0, _ m1: M1) -> some API
    where M0: Modifier, M1: Modifier {
        let tuple3 = TupleModifier3(m0: self.body, m1: m0, m2: m1)
        return _API<Parameters, Result, TupleModifier3>(body: tuple3)
    }
    
    /// modifier
    func modifier<M0, M1, M2>(_ m0: M0, _ m1: M1, _ m2: M2) -> some API
    where M0: Modifier, M1: Modifier, M2: Modifier {
        let tuple4 = TupleModifier4(m0: self.body, m1: m0, m2: m1, m3: m2)
        return _API<Parameters, Result, TupleModifier4>(body: tuple4)
    }
}


// MARK: - Internal
struct _API<Parameters, Result, Body: Modifier>: API {
    
    /// body
    let body: Body
}
