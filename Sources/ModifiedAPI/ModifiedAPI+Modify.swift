//
//  ModifiedAPI+Modify.swift
//

// MARK: - URL Modifier
extension ModifiedAPI {
    
    func scheme(_ scheme: String) -> some ModifiedAPI {
        self.modifier(SchemeModifier(scheme: scheme))
    }
    
    func authority(domain: String, port: Int? = nil) -> some ModifiedAPI {
        self.modifier(AuthorityModifier(domain: domain, port: port))
    }
    
    func parameters(_ parameters: [String: Any]) -> some ModifiedAPI {
        self.modifier(ParametersModifier(parameters: parameters))
    }
    
    func anchor(_ anchor: String) -> some ModifiedAPI {
        self.modifier(AnchorModifier(anchor: anchor))
    }
}
