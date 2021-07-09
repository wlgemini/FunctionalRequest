//
//  DataRequestModifier.swift
//

import Alamofire


public struct StatusCodeValidationModifier<S>: Modifier
where S: Sequence, S.Iterator.Element == Int {
    
    let acceptableStatusCodes: S
    
    public func apply(to context: Context) {
        //AF.request("").validate()
    }
    
    init(_ acceptableStatusCodes: S) {
        self.acceptableStatusCodes = acceptableStatusCodes
    }
}



public struct ContentTypeValidationModifier<S>: Modifier
where S: Sequence, S.Iterator.Element == String {
    
    let acceptableContentTypes: () -> S
    
    public func apply(to context: Context) {
        //AF.request("").validate()
        
    }
    
    init(_ acceptableContentTypes: @escaping @autoclosure () -> S) {
        self.acceptableContentTypes = acceptableContentTypes
    }
}

public struct ValidationModifier: Modifier {
    
    let validation: Alamofire.DataRequest.Validation
    
    public func apply(to context: Context) {
        //AF.request("").validate(<#T##validation: DataRequest.Validation##DataRequest.Validation##(URLRequest?, HTTPURLResponse, Data?) -> DataRequest.ValidationResult#>)
        
    }
    
    init(_ validation: @escaping Alamofire.DataRequest.Validation) {
        self.validation = validation
    }
}
