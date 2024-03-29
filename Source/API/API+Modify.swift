//
//  API+Modify.swift
//

import Foundation
import Alamofire


// MARK: - Modify DataRequest
public extension API {
    
    /// modify base url
    func base(_ base: @escaping @autoclosure Compute<String>) -> Self {
        self._modifier(DataRequestModifier.URL(base: base))
    }
    
    /// append path
    func appendPath(_ appendPath: @escaping @autoclosure Compute<String>) -> Self {
        self._modifier(DataRequestModifier.URL(appendPath: appendPath))
    }
    
    /// mocking with full url
    func mock(_ mock: @escaping @autoclosure Compute<String>) -> Self {
        self._modifier(DataRequestModifier.URL(mock: mock))
    }
    
    /// set additional header
    func header(name: String, value: String) -> Self {
        self._modifier(DataRequestModifier.HTTPHeader(name: name, value: value))
    }
    
    /// set additional headers
    func headers(_ dictionary: [String: String]) -> Self {
        self._modifier(DataRequestModifier.HTTPHeaders(dictionary))
    }
    
    /// modify encoding
    func encoding(_ encoding: Alamofire.ParameterEncoding) -> Self
    where Self.P == [String: Any] {
        self._modifier(DataRequestModifier.Encoding(encoding))
    }
    
    /// modify encoder
    func encoder(_ encoder: Alamofire.ParameterEncoder) -> Self
    where Self.P: Encodable {
        self._modifier(DataRequestModifier.Encoder(encoder))
    }
    
    /// modify URLRequest.timeoutInterval
    func timeoutInterval(_ timeoutInterval: TimeInterval) -> Self {
        self._modifier(DataRequestModifier.TimeoutInterval(timeoutInterval))
    }
    
    /// modify authenticate
    func authenticate(username: String,
                      password: String,
                      persistence: URLCredential.Persistence = .forSession) -> Self {
        self._modifier(DataRequestModifier.Authenticate(username: username,
                                                        password: password,
                                                        persistence: persistence))
    }
    
    /// modify authenticate
    func authenticate(credential: URLCredential) -> Self {
        self._modifier(DataRequestModifier.Authenticate(credential: credential))
    }
    
    /// modify redirect
    func redirect(using handler: Alamofire.RedirectHandler) -> Self {
        self._modifier(DataRequestModifier.Redirect(using: handler))
    }
}


// MARK: - Modify DataResponse
public extension API {
    
    /// validate statusCode
    func validate(statusCode acceptableStatusCodes: Range<Int>) -> Self {
        self._modifier(DataResponseModifier.Validation(statusCode: acceptableStatusCodes))
    }
    
    /// validate contentType
    func validate(contentType acceptableContentTypes: @escaping @autoclosure Compute<[String]>) -> Self {
        self._modifier(DataResponseModifier.Validation(contentType: acceptableContentTypes))
    }
    
    /// validates the request, using the specified closure.
    /// - Parameters:
    ///   - identifier: Same identifier will be override.
    ///   - validation: Custom validation
    func validate(identifier: String, validation: @escaping Alamofire.DataRequest.Validation) -> Self {
        self._modifier(DataResponseModifier.Validation(identifier: identifier, validation: validation))
    }
    
    /// modify cache response
    func cacheResponse(using handler: Alamofire.CachedResponseHandler) -> Self {
        self._modifier(DataResponseModifier.CacheResponse(using: handler))
    }
    
    /// The queue on which the completion handler is dispatched
    func queue(_ queue: DispatchQueue) -> Self {
        self._modifier(DataResponseModifier.Queue(queue))
    }
    
    /// serialize data
    func serialize(dataPreprocessor: Alamofire.DataPreprocessor = Alamofire.DataResponseSerializer.defaultDataPreprocessor,
                   emptyResponseCodes: Set<Int> = Alamofire.DataResponseSerializer.defaultEmptyResponseCodes,
                   emptyRequestMethods: Set<Alamofire.HTTPMethod> = Alamofire.DataResponseSerializer.defaultEmptyRequestMethods) -> Self
    where R == Data {
        let serializer = Alamofire.DataResponseSerializer(dataPreprocessor: dataPreprocessor,
                                                          emptyResponseCodes: emptyResponseCodes,
                                                          emptyRequestMethods: emptyRequestMethods)
        return self._modifier(DataResponseModifier.SerializeData(serializer))
    }
    
    /// serialize string
    func serialize(dataPreprocessor: Alamofire.DataPreprocessor = Alamofire.StringResponseSerializer.defaultDataPreprocessor,
                   encoding: String.Encoding? = nil,
                   emptyResponseCodes: Set<Int> = Alamofire.StringResponseSerializer.defaultEmptyResponseCodes,
                   emptyRequestMethods: Set<Alamofire.HTTPMethod> = Alamofire.StringResponseSerializer.defaultEmptyRequestMethods) -> Self
    where R == String {
        let serializer = Alamofire.StringResponseSerializer(dataPreprocessor: dataPreprocessor,
                                                            encoding: encoding,
                                                            emptyResponseCodes: emptyResponseCodes,
                                                            emptyRequestMethods: emptyRequestMethods)
        return self._modifier(DataResponseModifier.SerializeString(serializer))
    }
    
    /// serialize json
    func serialize(dataPreprocessor: Alamofire.DataPreprocessor = Alamofire.JSONResponseSerializer.defaultDataPreprocessor,
                   emptyResponseCodes: Set<Int> = Alamofire.JSONResponseSerializer.defaultEmptyResponseCodes,
                   emptyRequestMethods: Set<Alamofire.HTTPMethod> = Alamofire.JSONResponseSerializer.defaultEmptyRequestMethods,
                   options: JSONSerialization.ReadingOptions = .allowFragments) -> Self
    where R == [String: Any] {
        let serializer = Alamofire.JSONResponseSerializer(dataPreprocessor: dataPreprocessor,
                                                          emptyResponseCodes: emptyResponseCodes,
                                                          emptyRequestMethods: emptyRequestMethods,
                                                          options: options)
        return self._modifier(DataResponseModifier.SerializeJSON(serializer))
    }
    
    /// serialize decodable
    func serialize(dataPreprocessor: Alamofire.DataPreprocessor = Alamofire.DecodableResponseSerializer<R>.defaultDataPreprocessor,
                   decoder: Alamofire.DataDecoder = JSONDecoder(),
                   emptyResponseCodes: Set<Int> = Alamofire.DecodableResponseSerializer<R>.defaultEmptyResponseCodes,
                   emptyRequestMethods: Set<Alamofire.HTTPMethod> = Alamofire.DecodableResponseSerializer<R>.defaultEmptyRequestMethods) -> Self
    where R: Decodable {
        let serializer = Alamofire.DecodableResponseSerializer<R>(dataPreprocessor: dataPreprocessor,
                                                                  decoder: decoder,
                                                                  emptyResponseCodes: emptyResponseCodes,
                                                                  emptyRequestMethods: emptyRequestMethods)
        return self._modifier(DataResponseModifier.SerializeDecodable<R>(serializer))
    }
}
