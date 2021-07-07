//
//  URLModifier.swift
//

// MARK: - URL Modifier
/*
 * http     :// www.example.com:80  /   path/to/file.html   ?   key1=value1&key2=value2 #   SomewhereInTheDocument
 *
 * scheme   :// authority           /   path                ?   parameters              #   anchor
 */


/// scheme
public struct SchemeModifier: Modifier {

    let scheme: String

    public func apply(to context: ModifierContext) {
        
    }
}

/// authority
public struct AuthorityModifier: Modifier {

    let domain: String
    let port: Int?

    public func apply(to context: ModifierContext) {
        
    }
}

/// path
public struct PathModifier: Modifier {

    let path: String

    public func apply(to context: ModifierContext) {
        
    }
}

/// parameters
public struct ParametersModifier: Modifier {

    let parameters: [String: Any]

    public func apply(to context: ModifierContext) {
        
    }
}

/// anchor
public struct AnchorModifier: Modifier {

    let anchor: String

    public func apply(to context: ModifierContext) {
        
    }
}





