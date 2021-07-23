//
//  DataRequestable+RequestFunction.swift
//

import Foundation
import Alamofire


// MARK: - Request Function
// MARK: Input/Output Argument
/// 表示一个`DataRequestable`的`Input`和`Output`的范型参数
///
/// 可以表示请求没有参数，或者忽略返回值
///
 //public typealias None = Void


/// 表示一个`DataRequestable`的`Input`和`Output`的范型参数
///
/// 可以表示请求参数为`JSON`(也就是一个`[String: Any]`)，或者返回值为`JSON`(也就是一个`[String: Any]`)
///
 public typealias ex = [String: Any]


// MARK: Function
public extension DataRequestable {
    
    // Input == None, Output == None
    func request() where Input == None, Output == None {
        guard let url = self._url() else { return }

        let req = _FR.request(url,
                              method: self.modifier.method,
                              parameters: nil,
                              headers: self._headers(),
                              requestModifier: self._modifyURLRequest())
        
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        
        req.response(queue: self._queue(), completionHandler: { _ in })
    }
    
    // Input == JSON, Output == None
    func request(_ params: [String: Any]) where Input == JSON, Output == None {
        guard let url = self._url() else { return }
        
        let req = _FR.request(url,
                              method: self.modifier.method,
                              parameters: params,
                              encoding: self._encoding(),
                              headers: self._headers(),
                              requestModifier: self._modifyURLRequest())
        
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        
        req.response(queue: self._queue(), completionHandler: { _ in })
    }
    
    // Input: Encodable, Output == None
    func request(_ params: Input) where Input: Encodable, Output == None {
        guard let url = self._url() else { return }
        
        let req = _FR.request(url,
                              method: self.modifier.method,
                              parameters: params,
                              encoder: self._encoder(),
                              headers: self._headers(),
                              requestModifier: self._modifyURLRequest())
        
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        
        req.response(queue: self._queue(), completionHandler: { _ in })
    }
    
    // Input == None, Output == Data
    func request(completion: @escaping (Alamofire.AFDataResponse<Data>) -> Void) where Input == None, Output == Data {
        guard let url = self._url() else { return }
        
        let req = _FR.request(url,
                              method: self.modifier.method,
                              parameters: nil,
                              headers: self._headers(),
                              requestModifier: self._modifyURLRequest())
        
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        
        req.responseData(queue: self._queue(),
                         dataPreprocessor: self._dataDataPreprocessor(),
                         emptyResponseCodes: self._dataEmptyResponseCodes(),
                         emptyRequestMethods: self._dataEmptyRequestMethods(),
                         completionHandler: completion)
    }
    
    // Input == None, Output == JSON
    func request(completion: @escaping (Alamofire.AFDataResponse<Any>) -> Void) where Input == None, Output == JSON {
        guard let url = self._url() else { return }
        
        let req = _FR.request(url,
                              method: self.modifier.method,
                              parameters: nil,
                              headers: self._headers(),
                              requestModifier: self._modifyURLRequest())
        
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        
        req.responseJSON(queue: self._queue(),
                         dataPreprocessor: self._jsonDataPreprocessor(),
                         emptyResponseCodes: self._jsonEmptyResponseCodes(),
                         emptyRequestMethods: self._jsonEmptyRequestMethods(),
                         options: self._options(),
                         completionHandler: completion)
    }
    
    // Input == None, Output: Decodable
    func request(completion: @escaping (Alamofire.AFDataResponse<Output>) -> Void) where Input == None, Output: Decodable {
        guard let url = self._url() else { return }
        
        let req = _FR.request(url,
                              method: self.modifier.method,
                              parameters: nil,
                              headers: self._headers(),
                              requestModifier: self._modifyURLRequest())
        
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        
        req.responseDecodable(of: Output.self,
                              queue: self._queue(),
                              dataPreprocessor: self._decodableDataPreprocessor(),
                              decoder: self._decoder(),
                              emptyResponseCodes: self._decodableEmptyResponseCodes(),
                              emptyRequestMethods: self._decodableEmptyRequestMethods(),
                              completionHandler: completion)
    }
    
    
}
