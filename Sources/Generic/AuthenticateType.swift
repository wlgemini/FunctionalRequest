//
//  AuthenticateType.swift
//  


import Foundation


enum AuthenticateType {
    
    case authenticate(with: URLCredential)
    
    case authenticate(username: String, password: String, persistence: URLCredential.Persistence)
}
