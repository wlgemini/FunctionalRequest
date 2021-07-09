//
//  URLType.swift
//

enum URLType {
    
    /// append path url
    case appendPath(String)
    
    /// base url
    case base(Compute<String>)
    
    /// mock url
    case mock(Compute<String>)
}
