//
//  API+Modify.swift
//

import Foundation
import Alamofire


public extension API {

    /// modify base url
    func base(_ base: @escaping @autoclosure Compute<String>) -> _API<P, R, T2<M, RM.URL>> {
        self.modifier(RM.URL(base: base))
    }

    /// append path
    func appendPath(_ appendPath: @escaping @autoclosure Compute<String>) -> _API<P, R, T2<M, RM.URL>> {
        self.modifier(RM.URL(appendPath: appendPath))
    }

    /// mocking with full url
    func mock(_ mock: @escaping @autoclosure Compute<String>) -> _API<P, R, T2<M, RM.URL>> {
        self.modifier(RM.URL(mock: mock))
    }
    
    /// set additional headers
    func headers(_ headers: Alamofire.HTTPHeaders) -> _API<P, R, T2<M, RM.HTTPHeaders>> {
        self.modifier(RM.HTTPHeaders(headers))
    }
    
    /// modify encoder
    func encoder(_ encoder: Alamofire.ParameterEncoder) -> _API<P, R, T2<M, RM.Encoder>>
    where Self.P: Encodable {
        self.modifier(RM.Encoder(encoder))
    }
    
    /// modify encoding
    func encoding(_ encoding: Alamofire.ParameterEncoding) -> _API<P, R, T2<M, RM.Encoding>>
    where Self.P == [String: Any] {
        self.modifier(RM.Encoding(encoding))
    }
    
    /// modify authenticate
    func authenticate(username: String, password: String, persistence: URLCredential.Persistence = .forSession) -> _API<P, R, T2<M, RM.Authenticate>> {
        self.modifier(RM.Authenticate(username: username, password: password, persistence: persistence))
    }
    
    /// modify authenticate
    func authenticate(credential: URLCredential) -> _API<P, R, T2<M, RM.Authenticate>> {
        self.modifier(RM.Authenticate(credential: credential))
    }
    
    /// modify redirect
    func redirect(using handler: Alamofire.RedirectHandler) -> _API<P, R, T2<M, RM.Redirect>> {
        self.modifier(RM.Redirect(using: handler))
    }
    
    /// modify cache response
    func cacheResponse(using handler: Alamofire.CachedResponseHandler) -> _API<P, R, T2<M, RM.CacheResponse>> {
        self.modifier(RM.CacheResponse(using: handler))
    }
    
    /// validate statusCode
    func validate<S: Sequence>(statusCode acceptableStatusCodes: S) -> _API<P, R, T2<M, RM.Validation<S>>>
    where S.Iterator.Element == Int {
        self.modifier(RM.Validation(statusCode: acceptableStatusCodes))
    }
    
    /// validate contentType
    func validate<S: Sequence>(contentType acceptableContentTypes: @escaping @autoclosure () -> S) -> _API<P, R, T2<M, RM.Validation<S>>>
    where S.Iterator.Element == String {
        self.modifier(RM.Validation(contentType: acceptableContentTypes))
    }
}

