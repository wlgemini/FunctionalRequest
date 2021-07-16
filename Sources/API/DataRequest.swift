//
//  DataRequest.swift
//  


/// DataRequest
public protocol DataRequest: Request { }


public extension DataRequest {
    
    /// modifier
    func modifier<M>(_ m: M) -> some DataRequest
    where M: Modifier {
        let tuple2 = ModifyTuple2(m0: self.body, m1: m)
        return _DataRequest<Parameters, Returns, ModifyTuple2>(body: tuple2)
    }
}


// MARK: - Internal
struct _DataRequest<Parameters, Returns, Body: Modifier>: DataRequest {
    
    /// body
    let body: Body
}
