//
//  API.swift
//

public protocol API {
    
    /// Parameters
    associatedtype Parameters
    
    /// Result
    associatedtype Result
    
    /// method
    var method: String { get }
    
    /// path
    var path: String { get }
}
