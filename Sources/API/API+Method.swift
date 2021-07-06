//
//  API+Method.swift
//

public struct GET<Parameter, Result>: API, ModifiedAPI {
    public let method: String = "GET"
    public let path: String
}


public struct POST<Parameter, Result>: API, ModifiedAPI {
    public let method: String = "POST"
    public let path: String
}


public struct PUT<Parameter, Result>: API, ModifiedAPI {
    public let method: String = "PUT"
    public let path: String
}


public struct PATCH<Parameter, Result>: API, ModifiedAPI {
    public let method: String = "PATCH"
    public let path: String
}


public struct DELETE<Parameter, Result>: API, ModifiedAPI {
    public let method: String = "DELETE"
    public let path: String
}
