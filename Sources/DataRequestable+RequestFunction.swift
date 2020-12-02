//
//  DataRequestable+RequestFunction.swift
//

import Foundation
import Alamofire


// MARK: - Request Function
// MARK: Input/Output Argument
/// 表示一个Requestable的Input和Output的范型参数
///
/// 可以表示请求没有参数，或者忽略返回值
///
public enum None {}


/// 表示一个Requestable的Input和Output的范型参数
///
/// 可以表示请求参数为JSON(也就是一个Any)，或者返回值为JSON(也就是一个Any)
///
public enum JSON {}


// MARK: Function
public extension DataRequestable {
    
    // Input == None, Output == None
    func request() where Input == None, Output == None {
        guard let url = self._url else { return }
        
        let req = _DataSession.request(url,
                                       method: self.configuration.method,
                                       parameters: nil,
                                       headers: self._headers,
                                       requestModifier: self._modifyURLRequest)
        
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        
        req._response(queue: nil, completionHandler: { _ in })
    }
    
    // Input == JSON, Output == None
    func request(_ params: [String: Any]) where Input == JSON, Output == None {
        guard let url = self._url else { return }
        
        let req = _DataSession.request(url,
                                       method: self.configuration.method,
                                       parameters: params,
                                       encoding: self._encoding,
                                       headers: self._headers,
                                       requestModifier: self._modifyURLRequest)
        
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        
        req._response(queue: nil, completionHandler: { _ in })
    }
    
    // Input: Encodable, Output == None
    func request(_ params: Input) where Input: Encodable, Output == None {
        guard let url = self._url else { return }
        
        let req = _DataSession.request(url,
                                       method: self.configuration.method,
                                       parameters: params,
                                       encoder: self._encoder,
                                       headers: self._headers,
                                       requestModifier: self._modifyURLRequest)
        
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        
        req._response(queue: nil, completionHandler: { _ in })
    }
    
    // Input == None, Output == Data
    func request(queue: DispatchQueue? = nil,
                 dataPreprocessor: Alamofire.DataPreprocessor? = nil,
                 emptyResponseCodes: Set<Int>? = nil,
                 emptyRequestMethods: Set<Alamofire.HTTPMethod>? = nil,
                 completion: @escaping (Alamofire.AFDataResponse<Data>) -> Void) where Input == None, Output == Data {
        guard let url = self._url else { return }
        
        let req = _DataSession.request(url,
                                       method: self.configuration.method,
                                       parameters: nil,
                                       headers: self._headers,
                                       requestModifier: self._modifyURLRequest)
        
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        
        req._responseData(queue: queue,
                          dataPreprocessor: dataPreprocessor,
                          emptyResponseCodes: emptyResponseCodes,
                          emptyRequestMethods: emptyRequestMethods,
                          completionHandler: completion)
    }
    
    // Input == None, Output == JSON
    func request(queue: DispatchQueue? = nil,
                 dataPreprocessor: Alamofire.DataPreprocessor? = nil,
                 emptyResponseCodes: Set<Int>? = nil,
                 emptyRequestMethods: Set<Alamofire.HTTPMethod>? = nil,
                 options: JSONSerialization.ReadingOptions? = nil,
                 completion: @escaping (Alamofire.AFDataResponse<Any>) -> Void) where Input == None, Output == JSON {
        guard let url = self._url else { return }
        
        let req = _DataSession.request(url,
                                       method: self.configuration.method,
                                       parameters: nil,
                                       headers: self._headers,
                                       requestModifier: self._modifyURLRequest)
        
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        
        req._responseJSON(queue: queue,
                          dataPreprocessor: dataPreprocessor,
                          emptyResponseCodes: emptyResponseCodes,
                          emptyRequestMethods: emptyRequestMethods,
                          options: options,
                          completionHandler: completion)
    }
   
    // Input == None, Output: Decodable
    func request(queue: DispatchQueue? = nil,
                 dataPreprocessor: Alamofire.DataPreprocessor? = nil,
                 decoder: Alamofire.DataDecoder? = nil,
                 emptyResponseCodes: Set<Int>? = nil,
                 emptyRequestMethods: Set<Alamofire.HTTPMethod>? = nil,
                 completion: @escaping (Alamofire.AFDataResponse<Output>) -> Void) where Input == None, Output: Decodable {
        guard let url = self._url else { return }
        
        let req = _DataSession.request(url,
                                       method: self.configuration.method,
                                       parameters: nil,
                                       headers: self._headers,
                                       requestModifier: self._modifyURLRequest)
        
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        
        req._responseDecodable(of: Output.self,
                               queue: queue,
                               dataPreprocessor: dataPreprocessor,
                               decoder: decoder,
                               emptyResponseCodes: emptyResponseCodes,
                               emptyRequestMethods: emptyRequestMethods,
                               completionHandler: completion)
    }
   
    // Input == JSON, Output == Data
    func request(_ params: [String: Any],
                 queue: DispatchQueue? = nil,
                 dataPreprocessor: Alamofire.DataPreprocessor? = nil,
                 emptyResponseCodes: Set<Int>? = nil,
                 emptyRequestMethods: Set<Alamofire.HTTPMethod>? = nil,
                 completion: @escaping (Alamofire.AFDataResponse<Data>) -> Void) where Input == JSON, Output == Data {
        guard let url = self._url else { return }
        
        let req = _DataSession.request(url,
                                       method: self.configuration.method,
                                       parameters: params,
                                       encoding: self._encoding,
                                       headers: self._headers,
                                       requestModifier: self._modifyURLRequest)
        
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        
        req._responseData(queue: queue,
                          dataPreprocessor: dataPreprocessor,
                          emptyResponseCodes: emptyResponseCodes,
                          emptyRequestMethods: emptyRequestMethods,
                          completionHandler: completion)
    }
   
    // Input == JSON, Output == JSON
    func request(_ params: [String: Any],
                 queue: DispatchQueue? = nil,
                 dataPreprocessor: Alamofire.DataPreprocessor? = nil,
                 emptyResponseCodes: Set<Int>? = nil,
                 emptyRequestMethods: Set<Alamofire.HTTPMethod>? = nil,
                 options: JSONSerialization.ReadingOptions? = nil,
                 completion: @escaping (Alamofire.AFDataResponse<Any>) -> Void) where Input == JSON, Output == JSON {
        guard let url = self._url else { return }
        
        let req = _DataSession.request(url,
                                       method: self.configuration.method,
                                       parameters: params,
                                       encoding: self._encoding,
                                       headers: self._headers,
                                       requestModifier: self._modifyURLRequest)
        
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        
        req._responseJSON(queue: queue,
                          dataPreprocessor: dataPreprocessor,
                          emptyResponseCodes: emptyResponseCodes,
                          emptyRequestMethods: emptyRequestMethods,
                          options: options,
                          completionHandler: completion)
    }
   
    // Input == JSON, Output: Decodable
    func request(_ params: [String: Any],
                 queue: DispatchQueue? = nil,
                 dataPreprocessor: Alamofire.DataPreprocessor? = nil,
                 decoder: Alamofire.DataDecoder? = nil,
                 emptyResponseCodes: Set<Int>? = nil,
                 emptyRequestMethods: Set<Alamofire.HTTPMethod>? = nil,
                 completion: @escaping (Alamofire.AFDataResponse<Output>) -> Void) where Input == JSON, Output: Decodable {
        guard let url = self._url else { return }
        
        let req = _DataSession.request(url,
                                       method: self.configuration.method,
                                       parameters: params,
                                       encoding: self._encoding,
                                       headers: self._headers,
                                       requestModifier: self._modifyURLRequest)
        
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        
        req._responseDecodable(of: Output.self,
                               queue: queue,
                               dataPreprocessor: dataPreprocessor,
                               decoder: decoder,
                               emptyResponseCodes: emptyResponseCodes,
                               emptyRequestMethods: emptyRequestMethods,
                               completionHandler: completion)
    }
    
    // Input: Encodable, Output == Data
    func request(_ params: Input,
                 queue: DispatchQueue? = nil,
                 dataPreprocessor: Alamofire.DataPreprocessor? = nil,
                 emptyResponseCodes: Set<Int>? = nil,
                 emptyRequestMethods: Set<Alamofire.HTTPMethod>? = nil,
                 completion: @escaping (Alamofire.AFDataResponse<Data>) -> Void) where Input: Encodable, Output == Data  {
        guard let url = self._url else { return }
        
        let req = _DataSession.request(url,
                                       method: self.configuration.method,
                                       parameters: params,
                                       encoder: self._encoder,
                                       headers: self._headers,
                                       requestModifier: self._modifyURLRequest)
        
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        
        req._responseData(queue: queue,
                          dataPreprocessor: dataPreprocessor,
                          emptyResponseCodes: emptyResponseCodes,
                          emptyRequestMethods: emptyRequestMethods,
                          completionHandler: completion)
    }
   
    // Input: Encodable, Output == JSON
    func request(_ params: Input,
                 queue: DispatchQueue? = nil,
                 dataPreprocessor: Alamofire.DataPreprocessor? = nil,
                 emptyResponseCodes: Set<Int>? = nil,
                 emptyRequestMethods: Set<Alamofire.HTTPMethod>? = nil,
                 options: JSONSerialization.ReadingOptions? = nil,
                 completion: @escaping (Alamofire.AFDataResponse<Any>) -> Void) where Input: Encodable, Output == JSON {
        guard let url = self._url else { return }
        
        let req = _DataSession.request(url,
                                       method: self.configuration.method,
                                       parameters: params,
                                       encoder: self._encoder,
                                       headers: self._headers,
                                       requestModifier: self._modifyURLRequest)
        
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        
        req._responseJSON(queue: queue,
                          dataPreprocessor: dataPreprocessor,
                          emptyResponseCodes: emptyResponseCodes,
                          emptyRequestMethods: emptyRequestMethods,
                          options: options,
                          completionHandler: completion)
    }

    // Input: Encodable, Output: Decodable
    func request(_ params: Input,
                 queue: DispatchQueue? = nil,
                 dataPreprocessor: Alamofire.DataPreprocessor? = nil,
                 decoder: Alamofire.DataDecoder? = nil,
                 emptyResponseCodes: Set<Int>? = nil,
                 emptyRequestMethods: Set<Alamofire.HTTPMethod>? = nil,
                 completion: @escaping (Alamofire.AFDataResponse<Output>) -> Void) where Input: Encodable, Output: Decodable {
        guard let url = self._url else { return }
        
        let req = _DataSession.request(url,
                                       method: self.configuration.method,
                                       parameters: params,
                                       encoder: self._encoder,
                                       headers: self._headers,
                                       requestModifier: self._modifyURLRequest)
        
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        
        req._responseDecodable(of: Output.self,
                               queue: queue,
                               dataPreprocessor: dataPreprocessor,
                               decoder: decoder,
                               emptyResponseCodes: emptyResponseCodes,
                               emptyRequestMethods: emptyRequestMethods,
                               completionHandler: completion)
    }
}
