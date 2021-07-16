//
//  DataRequestModifier.swift
//

import Foundation
import Alamofire


/// StatusCodeValidationModifier
public struct StatusCodeValidationModifier<S>
where S: Sequence, S.Iterator.Element == Int {

    public init(_ acceptableStatusCodes: S) {
        self._acceptableStatusCodes = acceptableStatusCodes
    }
    
    // MARK: Internal
    let _acceptableStatusCodes: S
}


/// ContentTypeValidationModifier
public struct ContentTypeValidationModifier<S>
where S: Sequence, S.Iterator.Element == String {
    
    public init(_ acceptableContentTypes: @escaping () -> S) {
        self._acceptableContentTypes = acceptableContentTypes
    }
    
    // MARK: Internal
    let _acceptableContentTypes: () -> S
}


/// ValidationModifier
public struct ValidationModifier {
    
    public init(_ validation: @escaping Alamofire.DataRequest.Validation) {
        self._validation = validation
    }
    
    // MARK: Internal
    let _validation: Alamofire.DataRequest.Validation
}


// MARK: - Modifier
extension StatusCodeValidationModifier: Modifier {
    
    public func apply(to context: Context) {
        
    }
}


extension ContentTypeValidationModifier: Modifier {
    
    public func apply(to context: Context) {
        
    }
}


extension ValidationModifier: Modifier {
    
    
    public func apply(to context: Context) {
        AF.request("")
    }
}


// MARK: - DataRequestModifier
public extension DataRequestModifier {
    
    func validate<S: Sequence>(statusCode acceptableStatusCodes: S) -> some API
    where S.Iterator.Element == Int {
        self.modifier(StatusCodeValidationModifier(acceptableStatusCodes))
    }
    
    func validate<S: Sequence>(contentType acceptableContentTypes: @escaping @autoclosure () -> S) -> some API
    where S.Iterator.Element == String {
        self.modifier(ContentTypeValidationModifier(acceptableContentTypes))
    }
    
    func validate(_ validation: @escaping Alamofire.DataRequest.Validation) -> some API {
        self.modifier(ValidationModifier(validation))
    }
}
