//
//  Modifier.swift
//


/// Modifier
public protocol Modifier {

    func modify(context: Context)
}


/// Context
public typealias Context = Store._Context


/// AnyModifier
public struct AnyModifier: Modifier {
    
    public func modify(context: Context) {
        self.m0.modify(context: context)
        self.m1.modify(context: context)
    }
    
    let m0: Modifier
    let m1: Modifier
    
    init<M0, M1>(_ m0: M0, _ m1: M1)
    where M0: Modifier, M1: Modifier {
        self.m0 = m0
        self.m1 = m1
    }
}
