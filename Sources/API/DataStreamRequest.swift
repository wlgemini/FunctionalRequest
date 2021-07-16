//
//  DataStreamRequest.swift
//  


/// DataStreamRequest
public protocol DataStreamRequest: Request { }


public extension DataStreamRequest {
    
    
}


// MARK: - Internal
struct _DataStreamRequest<Parameters, Returns, Body: Modifier>: DataStreamRequest {
    
    /// body
    let body: Body
}
