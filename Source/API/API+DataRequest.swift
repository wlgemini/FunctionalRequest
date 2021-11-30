//
//  API+DataRequest.swift
//

import Foundation
import Alamofire


public extension API {
    
    // MARK: P == [String: Any], R == Data
    func request(_ parameters: P?,
                 completion: @escaping (Alamofire.AFDataResponse<R>) -> Void,
                 file: String = #fileID,
                 line: UInt = #line)
    where P == [String: Any], R == Data {
        let context = self._context(file: file, line: line)
        guard let request = self._request(parameters: parameters, context: context) else { return }
        self._requestModify(request: request, context: context)
        self._responseModify(request: request, context: context)
        self._response(request: request, context: context, completion: completion)
        self._requestAccessing(request: request, context: context)
    }
    
    // MARK: P == [String: Any], R == String
    func request(_ parameters: P?,
                 completion: @escaping (Alamofire.AFDataResponse<R>) -> Void,
                 file: String = #fileID,
                 line: UInt = #line)
    where P == [String: Any], R == String {
        let context = self._context(file: file, line: line)
        guard let request = self._request(parameters: parameters, context: context) else { return }
        self._requestModify(request: request, context: context)
        self._responseModify(request: request, context: context)
        self._response(request: request, context: context, completion: completion)
        self._requestAccessing(request: request, context: context)
    }
    
    // MARK: P == [String: Any], R == Any
    func request(_ parameters: P?,
                 completion: @escaping (Alamofire.AFDataResponse<R>) -> Void,
                 file: String = #fileID,
                 line: UInt = #line)
    where P == [String: Any], R == Any {
        let context = self._context(file: file, line: line)
        guard let request = self._request(parameters: parameters, context: context) else { return }
        self._requestModify(request: request, context: context)
        self._responseModify(request: request, context: context)
        self._response(request: request, context: context, completion: completion)
        self._requestAccessing(request: request, context: context)
    }
    
    // MARK: P == [String: Any], R: Decodable
    func request(_ parameters: P?,
                 completion: @escaping (Alamofire.AFDataResponse<R>) -> Void,
                 file: String = #fileID,
                 line: UInt = #line)
    where P == [String: Any], R: Decodable {
        let context = self._context(file: file, line: line)
        guard let request = self._request(parameters: parameters, context: context) else { return }
        self._requestModify(request: request, context: context)
        self._responseModify(request: request, context: context)
        self._response(request: request, context: context, completion: completion)
        self._requestAccessing(request: request, context: context)
    }
    
    // MARK: P == Encodable, R == Data
    func request(_ parameters: P?,
                 completion: @escaping (Alamofire.AFDataResponse<R>) -> Void,
                 file: String = #fileID,
                 line: UInt = #line)
    where P: Encodable, R == Data {
        let context = self._context(file: file, line: line)
        guard let request = self._request(parameters: parameters, context: context) else { return }
        self._requestModify(request: request, context: context)
        self._responseModify(request: request, context: context)
        self._response(request: request, context: context, completion: completion)
        self._requestAccessing(request: request, context: context)
    }
    
    // MARK: P == Encodable, R == String
    func request(_ parameters: P?,
                 completion: @escaping (Alamofire.AFDataResponse<R>) -> Void,
                 file: String = #fileID,
                 line: UInt = #line)
    where P: Encodable, R == String {
        let context = self._context(file: file, line: line)
        guard let request = self._request(parameters: parameters, context: context) else { return }
        self._requestModify(request: request, context: context)
        self._responseModify(request: request, context: context)
        self._response(request: request, context: context, completion: completion)
        self._requestAccessing(request: request, context: context)
    }
    
    // MARK: P == Encodable, R == Any
    func request(_ parameters: P?,
                 completion: @escaping (Alamofire.AFDataResponse<R>) -> Void,
                 file: String = #fileID,
                 line: UInt = #line)
    where P: Encodable, R == Any {
        let context = self._context(file: file, line: line)
        guard let request = self._request(parameters: parameters, context: context) else { return }
        self._requestModify(request: request, context: context)
        self._responseModify(request: request, context: context)
        self._response(request: request, context: context, completion: completion)
        self._requestAccessing(request: request, context: context)
    }
    
    // MARK: P == Encodable, R: Decodable
    func request(_ parameters: P?,
                 completion: @escaping (Alamofire.AFDataResponse<R>) -> Void,
                 file: String = #fileID,
                 line: UInt = #line)
    where P: Encodable, R: Decodable {
        let context = self._context(file: file, line: line)
        guard let request = self._request(parameters: parameters, context: context) else { return }
        self._requestModify(request: request, context: context)
        self._responseModify(request: request, context: context)
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
    func _request(parameters: P?, context: Context) -> Alamofire.DataRequest?
    where P == [String: Any] {
        guard let method = context._method() else { return nil }
        guard let url = context._url() else { return nil }
        let headers = context._headers()
        let encoding = context._encoding()
        let requestModifier = context._urlRequestModifier()
        return Store._sessionRaw.request(url,
                                         method: method,
                                         parameters: parameters,
                                         encoding: encoding,
                                         headers: headers,
                                         interceptor: nil,
                                         requestModifier: requestModifier)
    }
    
    /// request encodable
    func _request(parameters: P?, context: Context) -> Alamofire.DataRequest?
    where P: Encodable {
        guard let method = context._method() else { return nil }
        guard let url = context._url() else { return nil }
        let headers = context._headers()
        let encoder = context._encoder()
        let requestModifier = context._urlRequestModifier()
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
        if let credential = context._authenticate() {
            request.authenticate(with: credential)
        }
        
        // redirect
        if let redirectHandler = context._redirectHandler() {
            request.redirect(using: redirectHandler)
        }
    }
    
    /// response modify
    func _responseModify(request: Alamofire.DataRequest, context: Context) {
        // validation
        let (acceptableStatusCodes, acceptableContentTypes, validations) = context._validation()
        
        // statusCodes validation
        if let statusCodes = acceptableStatusCodes {
            request.validate(statusCode: statusCodes)
        } else {
            request.validate(statusCode: 200 ..< 300)
        }
        
        // contentTypes validation
        if let contentTypes = acceptableContentTypes {
            request.validate(contentType: contentTypes)
        } else {
            if let accept = request.request?.value(forHTTPHeaderField: "Accept") {
                let contentTypes = accept.components(separatedBy: ",")
                request.validate(contentType: contentTypes)
            } else {
                request.validate(contentType: ["*/*"])
            }
        }
        
        // custom validations
        validations.values.forEach {
            request.validate($0)
        }
        
        // cacheResponse
        if let cachedResponseHandler = context._cachedResponseHandler() {
            request.cacheResponse(using: cachedResponseHandler)
        }
    }
    
    /// response data
    func _response(request: Alamofire.DataRequest,
                   context: Context,
                   completion: @escaping (Alamofire.AFDataResponse<R>) -> Void)
    where R == Data {
        let queue = context._queue()
        let serializer = context._dataResponseSerializer()
        request.response(queue: queue,
                         responseSerializer: serializer,
                         completionHandler: completion)
    }
    
    /// response string
    func _response(request: Alamofire.DataRequest,
                   context: Context,
                   completion: @escaping (Alamofire.AFDataResponse<R>) -> Void)
    where R == String {
        let queue = context._queue()
        let serializer = context._stringResponseSerializer()
        request.response(queue: queue,
                         responseSerializer: serializer,
                         completionHandler: completion)
    }
    
    /// response json
    func _response(request: Alamofire.DataRequest,
                   context: Context,
                   completion: @escaping (Alamofire.AFDataResponse<R>) -> Void)
    where R == Any {
        let queue = context._queue()
        let serializer = context._jsonResponseSerializer()
        request.response(queue: queue,
                         responseSerializer: serializer,
                         completionHandler: completion)
    }
    
    /// response decodable
    func _response(request: Alamofire.DataRequest,
                   context: Context,
                   completion: @escaping (Alamofire.AFDataResponse<R>) -> Void)
    where R: Decodable {
        let queue = context._queue()
        let serializer: Alamofire.DecodableResponseSerializer<R> = context._decodableResponseSerializer()
        request.response(queue: queue,
                         responseSerializer: serializer,
                         completionHandler: completion)
    }
    
    /// accessing data request
    func _requestAccessing(request: Alamofire.DataRequest, context: Context) {
        // onRequestAvailable
        if let onRequestAvailable = context._accessingRequest() {
            onRequestAvailable(request)
        }
    }
}
