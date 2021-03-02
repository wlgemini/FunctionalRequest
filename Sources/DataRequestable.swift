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
    
    /// a data request modifier, some of which propertys will override `Configuration`
    var modifier: ConfigurationModifier { get set }
    
    /// init a request
    /// - Parameters:
    ///   - api: request path
    ///   - base: base url
    init(_ api: String, base: @escaping @autoclosure Compute<String?>)
}


public extension DataRequestable {
    
    /// init a request
    ///
    /// base url is `Configuration.DataRequest.base()`
    ///
    /// - Parameters:
    ///   - api: request path
    init(_ api: String) {
        self.init(api, base: Configuration.DataRequest.base())
    }
}


