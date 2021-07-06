//
//  Requestable.swift
//

import Foundation


// MARK: - Requestable
public protocol Requestable: Any {
    
    /// Input type (aka params)
    associatedtype Input
    
    /// Output type (aka response data)
    associatedtype Output
    
    /// init a request
    /// - Parameters:
    ///   - api: request path
    ///   - base: base url
    init(_ api: String, base: @escaping @autoclosure Compute<String?>)
}
