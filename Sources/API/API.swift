//
//  API.swift
//

/// API
public protocol API {
    
    /// Parameters
    associatedtype Parameters
    
    /// Returns
    associatedtype Returns
    
    /// Body
    associatedtype Body: Modifier
    
    /// body
    var body: Self.Body { get }
}
