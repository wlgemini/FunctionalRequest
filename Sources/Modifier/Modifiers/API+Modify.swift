//
//  API+Modify.swift
//

// MARK: - URL Modify
extension API {

    func scheme(_ scheme: String) -> some API {
        self.modifier(SchemeModifier(scheme: scheme))
    }

    func authority(domain: String, port: Int? = nil) -> some API {
        self.modifier(AuthorityModifier(domain: domain, port: port))
    }

    func parameters(_ parameters: [String: Any]) -> some API {
        self.modifier(ParametersModifier(parameters: parameters))
    }

    func anchor(_ anchor: String) -> some API {
        self.modifier(AnchorModifier(anchor: anchor))
    }
}
