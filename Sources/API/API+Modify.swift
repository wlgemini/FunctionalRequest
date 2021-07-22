//
//  API+Modify.swift
//

import Foundation
import Alamofire


// MARK: - Modify DataRequest
public extension API {
    
    /// modify base url
    func base(_ base: @escaping @autoclosure Compute<String>)
    -> _API<P, R, T2<M, DataRequestModifier.URL>> {
        self.modifier(DataRequestModifier.URL(base: base))
    }
    
    /// append path
    func appendPath(_ appendPath: @escaping @autoclosure Compute<String>)
    -> _API<P, R, T2<M, DataRequestModifier.URL>> {
        self.modifier(DataRequestModifier.URL(appendPath: appendPath))
    }
    
    /// mocking with full url
    func mock(_ mock: @escaping @autoclosure Compute<String>)
    -> _API<P, R, T2<M, DataRequestModifier.URL>> {
        self.modifier(DataRequestModifier.URL(mock: mock))
    }
    
    /// set additional headers
    func headers(_ headers: Alamofire.HTTPHeaders)
    -> _API<P, R, T2<M, DataRequestModifier.HTTPHeaders>> {
        self.modifier(DataRequestModifier.HTTPHeaders(headers))
    }
    
    /// modify encoder
    func encoder(_ encoder: Alamofire.ParameterEncoder)
    -> _API<P, R, T2<M, DataRequestModifier.Encoder>>
    where Self.P: Encodable {
        self.modifier(DataRequestModifier.Encoder(encoder))
    }
    
    /// modify encoding
    func encoding(_ encoding: Alamofire.ParameterEncoding)
    -> _API<P, R, T2<M, DataRequestModifier.Encoding>>
    where Self.P == [String: Any] {
        self.modifier(DataRequestModifier.Encoding(encoding))
    }
    
    /// modify authenticate
    func authenticate(username: String,
                      password: String,
                      persistence: URLCredential.Persistence = .forSession)
    -> _API<P, R, T2<M, DataRequestModifier.Authenticate>> {
        self.modifier(DataRequestModifier.Authenticate(username: username,
                                                       password: password,
                                                       persistence: persistence))
    }
    
    /// modify authenticate
    func authenticate(credential: URLCredential)
    -> _API<P, R, T2<M, DataRequestModifier.Authenticate>> {
        self.modifier(DataRequestModifier.Authenticate(credential: credential))
    }
    
    /// modify redirect
    func redirect(using handler: Alamofire.RedirectHandler)
    -> _API<P, R, T2<M, DataRequestModifier.Redirect>> {
        self.modifier(DataRequestModifier.Redirect(using: handler))
    }
}


// MARK: - Modify DataResponse
public extension API {
    
    /// validate statusCode
    func validate(statusCode acceptableStatusCodes: Range<Int>)
    -> _API<P, R, T2<M, DataResponseModifier.Validation>> {
        self.modifier(DataResponseModifier.Validation(statusCode: acceptableStatusCodes))
    }
    
    /// validate contentType
    func validate(contentType acceptableContentTypes: @escaping @autoclosure Compute<[String]>)
    -> _API<P, R, T2<M, DataResponseModifier.Validation>> {
        self.modifier(DataResponseModifier.Validation(contentType: acceptableContentTypes))
    }
    
    /// serialize data
    func serialize(dataPreprocessor: Alamofire.DataPreprocessor = Alamofire.DataResponseSerializer.defaultDataPreprocessor,
                   emptyResponseCodes: Set<Int> = Alamofire.DataResponseSerializer.defaultEmptyResponseCodes,
                   emptyRequestMethods: Set<Alamofire.HTTPMethod> = Alamofire.DataResponseSerializer.defaultEmptyRequestMethods)
    -> _API<P, R, T2<M, DataResponseModifier.Serializer<Alamofire.DataResponseSerializer>>>
    where R == Data {
        let serializer = Alamofire.DataResponseSerializer(dataPreprocessor: dataPreprocessor,
                                                          emptyResponseCodes: emptyResponseCodes,
                                                          emptyRequestMethods: emptyRequestMethods)
        return self.modifier(DataResponseModifier.Serializer(serializer))
    }
    
    /// serialize string
    func serialize(dataPreprocessor: Alamofire.DataPreprocessor = Alamofire.StringResponseSerializer.defaultDataPreprocessor,
                   encoding: String.Encoding? = nil,
                   emptyResponseCodes: Set<Int> = Alamofire.StringResponseSerializer.defaultEmptyResponseCodes,
                   emptyRequestMethods: Set<Alamofire.HTTPMethod> = Alamofire.StringResponseSerializer.defaultEmptyRequestMethods)
    -> _API<P, R, T2<M, DataResponseModifier.Serializer<Alamofire.StringResponseSerializer>>>
    where R == String {
        let serializer = Alamofire.StringResponseSerializer(dataPreprocessor: dataPreprocessor,
                                                            encoding: encoding,
                                                            emptyResponseCodes: emptyResponseCodes,
                                                            emptyRequestMethods: emptyRequestMethods)
        return self.modifier(DataResponseModifier.Serializer(serializer))
    }
    
    /// serialize json
    func serialize(dataPreprocessor: Alamofire.DataPreprocessor = Alamofire.JSONResponseSerializer.defaultDataPreprocessor,
                   emptyResponseCodes: Set<Int> = Alamofire.JSONResponseSerializer.defaultEmptyResponseCodes,
                   emptyRequestMethods: Set<Alamofire.HTTPMethod> = Alamofire.JSONResponseSerializer.defaultEmptyRequestMethods,
                   options: JSONSerialization.ReadingOptions = .allowFragments)
    -> _API<P, R, T2<M, DataResponseModifier.Serializer<Alamofire.JSONResponseSerializer>>>
    where R == [String: Any] {
        let serializer = Alamofire.JSONResponseSerializer(dataPreprocessor: dataPreprocessor,
                                                          emptyResponseCodes: emptyResponseCodes,
                                                          emptyRequestMethods: emptyRequestMethods,
                                                          options: options)
        return self.modifier(DataResponseModifier.Serializer(serializer))
    }
    
    /// serialize decodable
    func serialize(dataPreprocessor: Alamofire.DataPreprocessor = Alamofire.DecodableResponseSerializer<R>.defaultDataPreprocessor,
                   decoder: Alamofire.DataDecoder = JSONDecoder(),
                   emptyResponseCodes: Set<Int> = Alamofire.DecodableResponseSerializer<R>.defaultEmptyResponseCodes,
                   emptyRequestMethods: Set<Alamofire.HTTPMethod> = Alamofire.DecodableResponseSerializer<R>.defaultEmptyRequestMethods)
    -> _API<P, R, T2<M, DataResponseModifier.Serializer<Alamofire.DecodableResponseSerializer<R>>>>
    where R: Decodable {
        let serializer = Alamofire.DecodableResponseSerializer<R>(dataPreprocessor: dataPreprocessor,
                                                                  decoder: decoder,
                                                                  emptyResponseCodes: emptyResponseCodes,
                                                                  emptyRequestMethods: emptyRequestMethods)
        return self.modifier(DataResponseModifier.Serializer(serializer))
    }
    
    /// modify cache response
    func cacheResponse(using handler: Alamofire.CachedResponseHandler)
    -> _API<P, R, T2<M, DataResponseModifier.CacheResponse>> {
        self.modifier(DataResponseModifier.CacheResponse(using: handler))
    }
}
