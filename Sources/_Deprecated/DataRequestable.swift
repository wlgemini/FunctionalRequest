//
//  DataRequestable.swift
//

import Foundation
import Alamofire


// MARK: - DataRequestable
public protocol DataRequestable: Requestable {
    
    /// a data request modifier, some of which propertys will override `Configuration`
    var modifier: ConfigurationModifier { get set }
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


