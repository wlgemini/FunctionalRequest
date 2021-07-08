//
//  URLType.swift
//

enum URLType {
    
    /// a url path
    case path(Compute<String>)
    
    /// base url
    case base(Compute<String>)
    
    /// full url
    case url(Compute<String>)
    
    /// mock url
    case mock(Compute<String>)
}
