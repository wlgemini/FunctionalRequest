//
//  MethodModifier.swift
//

import Alamofire


/// MethodModifier
public struct MethodModifier {
    
    public init(method: Alamofire.HTTPMethod) {
        self.method = method
    }
    
    // MARK: Internal
    let method: Alamofire.HTTPMethod
}


// MARK: - Modifier
extension MethodModifier: Modifier {
    
    public func apply(to context: Context) {
        if context.forAPI.method == nil {
            context.forAPI.method = self.method
        } else {
            fatalError("Can not modify `API.method`")
        }
    }
}
