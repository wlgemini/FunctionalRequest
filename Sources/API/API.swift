//
//  API.swift
//


public protocol API {
    associatedtype Parameter
    associatedtype Result
    
    var method: String { get }
    var path: String { get }
}


