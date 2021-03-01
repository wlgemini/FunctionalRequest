//
//  DataRequestable.swift
//

import Foundation
import Alamofire


// MARK: - DataRequestable
public protocol DataRequestable: Any {
    
    /// Input type (aka params)
    associatedtype Input
    
    /// Output type (aka response data)
    associatedtype Output
    
    /// a data request config, some of which propertys will override `Configuration`
    var internalConfiguration: InternalConfiguration { get set }
    
    /// init a request
    /// - Parameters:
    ///   - api: request path
    ///   - base: base url
    init(_ api: String, base: @escaping @autoclosure Compute<String?>)
}


