//
//  API+DataRequest.swift
//

import Foundation
import Alamofire


public extension API {
    
    // MARK: P == [String: Any], R == Data
    func request(_ parameters: P,
                 completion: @escaping (Alamofire.AFDataResponse<R>) -> Void,
                 file: String = #fileID,
                 line: UInt = #line)
    where P == [String: Any], R == Data {
        let context = self._context(file: file, line: line)
        guard let request = self._request(parameters: parameters, context: context) else { return }
        self._requestModify(request: request, context: context)
        self._response(request: request, context: context, completion: completion)
        self._requestAccessing(request: request, context: context)
    }
    
    // MARK: P == [String: Any], R == String
    func request(_ parameters: P,
                 completion: @escaping (Alamofire.AFDataResponse<R>) -> Void,
                 file: String = #fileID,
                 line: UInt = #line)
    where P == [String: Any], R == String {
        let context = self._context(file: file, line: line)
        guard let request = self._request(parameters: parameters, context: context) else { return }
        self._requestModify(request: request, context: context)
        self._response(request: request, context: context, completion: completion)
        self._requestAccessing(request: request, context: context)
    }
    
    // MARK: P == [String: Any], R == Any
    func request(_ parameters: P,
                 completion: @escaping (Alamofire.AFDataResponse<R>) -> Void,
                 file: String = #fileID,
                 line: UInt = #line)
    where P == [String: Any], R == Any {
        let context = self._context(file: file, line: line)
        guard let request = self._request(parameters: parameters, context: context) else { return }
        self._requestModify(request: request, context: context)
        self._response(request: request, context: context, completion: completion)
        self._requestAccessing(request: request, context: context)
    }
    
    // MARK: P == [String: Any], R: Decodable
    func request(_ parameters: P,
                 completion: @escaping (Alamofire.AFDataResponse<R>) -> Void,
                 file: String = #fileID,
                 line: UInt = #line)
    where P == [String: Any], R: Decodable {
        let context = self._context(file: file, line: line)
        guard let request = self._request(parameters: parameters, context: context) else { return }
        self._requestModify(request: request, context: context)
        self._response(request: request, context: context, completion: completion)
        self._requestAccessing(request: request, context: context)
    }
    
    // MARK: P == Encodable, R == Data
    func request(_ parameters: P,
                 completion: @escaping (Alamofire.AFDataResponse<R>) -> Void,
                 file: String = #fileID,
                 line: UInt = #line)
    where P: Encodable, R == Data {
        let context = self._context(file: file, line: line)
        guard let request = self._request(parameters: parameters, context: context) else { return }
        self._requestModify(request: request, context: context)
        self._response(request: request, context: context, completion: completion)
        self._requestAccessing(request: request, context: context)
    }
    
    // MARK: P == Encodable, R == String
    func request(_ parameters: P,
                 completion: @escaping (Alamofire.AFDataResponse<R>) -> Void,
                 file: String = #fileID,
                 line: UInt = #line)
    where P: Encodable, R == String {
        let context = self._context(file: file, line: line)
        guard let request = self._request(parameters: parameters, context: context) else { return }
        self._requestModify(request: request, context: context)
        self._response(request: request, context: context, completion: completion)
        self._requestAccessing(request: request, context: context)
    }
    
    // MARK: P == Encodable, R == Any
    func request(_ parameters: P,
                 completion: @escaping (Alamofire.AFDataResponse<R>) -> Void,
                 file: String = #fileID,
                 line: UInt = #line)
    where P: Encodable, R == Any {
        let context = self._context(file: file, line: line)
        guard let request = self._request(parameters: parameters, context: context) else { return }
        self._requestModify(request: request, context: context)
        self._response(request: request, context: context, completion: completion)
        self._requestAccessing(request: request, context: context)
    }
    
    // MARK: P == Encodable, R: Decodable
    func request(_ parameters: P,
                 completion: @escaping (Alamofire.AFDataResponse<R>) -> Void,
                 file: String = #fileID,
                 line: UInt = #line)
    where P: Encodable, R: Decodable {
        let context = self._context(file: file, line: line)
        guard let request = self._request(parameters: parameters, context: context) else { return }
        self._requestModify(request: request, context: context)
        self._response(request: request, context: context, completion: completion)
        self._requestAccessing(request: request, context: context)
    }
}


// MARK: - Request Helper
extension API {
    
    /// context
    func _context(file: String, line: UInt) -> Context {
        let ctx = Context(requestLocation: _Location(file, line))
        self.modifier.modify(context: ctx)
        return ctx
    }
    
    /// request encoding
    func _request(parameters: P, context: Context) -> Alamofire.DataRequest?
    where P == [String: Any] {
        guard let url = self._url(context) else { return nil }
        guard let method = self._method(context) else { return nil }
        let encoding = self._encoding(context)
        let headers = self._headers(context)
        let requestModifier = self._urlRequestModifier(context)
        return Store._sessionRaw.request(url,
                                         method: method,
                                         parameters: parameters,
                                         encoding: encoding,
                                         headers: headers,
                                         interceptor: nil,
                                         requestModifier: requestModifier)
    }
    
    /// request encodable
    func _request(parameters: P, context: Context) -> Alamofire.DataRequest?
    where P: Encodable {
        guard let url = self._url(context) else { return nil }
        guard let method = self._method(context) else { return nil }
        let encoder = self._encoder(context)
        let headers = self._headers(context)
        let requestModifier = self._urlRequestModifier(context)
        return Store._sessionRaw.request(url,
                                         method: method,
                                         parameters: parameters,
                                         encoder: encoder,
                                         headers: headers,
                                         interceptor: nil,
                                         requestModifier: requestModifier)
    }
    
    /// request modify
    func _requestModify(request: Alamofire.DataRequest, context: Context) {
        // authentication
        if let credential = self._authenticate(context) {
            request.authenticate(with: credential)
        }
        
        // redirect
        if let redirect = self._redirectHandler(context) {
            request.redirect(using: redirect)
        }
        
        // validation
        let validation = self._validation(context)
        switch validation {
        case (.some(let statusCode), .some(let contentType)):
            request.validate(statusCode: statusCode).validate(contentType: contentType)
            
        case (.some(let statusCode), .none):
            request.validate(statusCode: statusCode)
            
        case (.none, .some(let contentType)):
            request.validate(contentType: contentType)
            
        case (.none, .none):
            request.validate()
        }
    }
    
    /// response data
    func _response(request: Alamofire.DataRequest,
                   context: Context,
                   completion: @escaping (Alamofire.AFDataResponse<R>) -> Void)
    where R == Data {
        let queue = self._queue(context)
        let serializer = self._dataResponseSerializer(context)
        request.response(queue: queue,
                         responseSerializer: serializer,
                         completionHandler: completion)
    }
    
    /// response string
    func _response(request: Alamofire.DataRequest,
                   context: Context,
                   completion: @escaping (Alamofire.AFDataResponse<R>) -> Void)
    where R == String {
        let queue = self._queue(context)
        let serializer = self._stringResponseSerializer(context)
        request.response(queue: queue,
                         responseSerializer: serializer,
                         completionHandler: completion)
    }
    
    /// response json
    func _response(request: Alamofire.DataRequest,
                   context: Context,
                   completion: @escaping (Alamofire.AFDataResponse<R>) -> Void)
    where R == Any {
        let queue = self._queue(context)
        let serializer = self._jsonResponseSerializer(context)
        request.response(queue: queue,
                         responseSerializer: serializer,
                         completionHandler: completion)
    }
    
    /// response decodable
    func _response(request: Alamofire.DataRequest,
                   context: Context,
                   completion: @escaping (Alamofire.AFDataResponse<R>) -> Void)
    where R: Decodable {
        let queue = self._queue(context)
        let serializer = self._decodableResponseSerializer(context)
        request.response(queue: queue,
                         responseSerializer: serializer,
                         completionHandler: completion)
    }
    
    /// accessing data request
    func _requestAccessing(request: Alamofire.DataRequest, context: Context) {
        // onRequestAvailable
        if let onRequestAvailable = self._accessingRequest(context) {
            onRequestAvailable(request)
        }
    }
}
