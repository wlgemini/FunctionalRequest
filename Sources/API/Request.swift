//
//  Request.swift
//


/// Request
public protocol Request: API { }


/// Request + modifier
extension Request {
    
    /// modifier
    func modifier<M>(_ m: M) -> some Request
    where M: RequestModifier {
        let tuple2 = ModifyTuple2(m0: self.body, m1: m)
        return _Request<Parameters, Returns, ModifyTuple2>(body: tuple2)
    }
}


// MARK: - Internal
struct _Request<Parameters, Returns, Body: Modifier>: Request {
    
    /// body
    let body: Body
}
