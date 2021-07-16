//
//  Method.swift
//

import Alamofire


/// Method
public protocol Method: API { }


/// Method + modifier
extension Method {
    
    /// modifier
    public func modifier<M>(_ m: M) -> some Method
    where M: URLModifier {
        _Method<Parameters, Returns, ModifyTuple2>(m0: self.body, m1: m)
    }
    
    /// foo.dataRequest(
    ///     DataRequest().bar()
    /// )
    public func request() {
        
    }
}


// MARK: - Internal
struct _Method<Parameters, Returns, Body: Modifier>: Method {
    
    /// body
    let body: Body
    
    /// init
    init<M0, M1>(m0: M0, m1: M1)
    where M0: Modifier, M1: Modifier, Body == ModifyTuple2<M0, M1> {
        self.body = ModifyTuple2(m0: m0, m1: m1)
    }
}

