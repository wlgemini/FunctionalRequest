//
//  API+DataRequest.swift
//

import Foundation
import Alamofire


public extension API {
    
    // P == [String: Any], R == Data
    func request(_ params: [String: Any], completion: @escaping (Alamofire.AFDataResponse<Data>) -> Void) where P == [String: Any], R == Data {
        
        guard let url = self._url() else { return }
        
        let req = _FR.request(url,
                              method: self.modifier.method,
                              parameters: params,
                              encoding: self._encoding(),
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
    
    // P == [String: Any], R == [String: Any]
    func request(_ params: [String: Any], completion: @escaping (Alamofire.AFDataResponse<Any>) -> Void) where P == [String: Any], R == [String: Any] {
        guard let url = self._url() else { return }
        
        let req = _FR.request(url,
                              method: self.modifier.method,
                              parameters: params,
                              encoding: self._encoding(),
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
    
    // P == [String: Any], R: Decodable
    func request(_ params: [String: Any], completion: @escaping (Alamofire.AFDataResponse<R>) -> Void) where P == [String: Any], R: Decodable {
        guard let url = self._url() else { return }
        
        let req = _FR.request(url,
                              method: self.modifier.method,
                              parameters: params,
                              encoding: self._encoding(),
                              headers: self._headers(),
                              requestModifier: self._modifyURLRequest())
        
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        
        req.responseDecodable(of: R.self,
                              queue: self._queue(),
                              dataPreprocessor: self._decodableDataPreprocessor(),
                              decoder: self._decoder(),
                              emptyResponseCodes: self._decodableEmptyResponseCodes(),
                              emptyRequestMethods: self._decodableEmptyRequestMethods(),
                              completionHandler: completion)
    }
    
    // P: Encodable, R == Data
    func request(_ params: P, completion: @escaping (Alamofire.AFDataResponse<Data>) -> Void) where P: Encodable, R == Data  {
        guard let url = self._url() else { return }
        
        let req = _FR.request(url,
                              method: self.modifier.method,
                              parameters: params,
                              encoder: self._encoder(),
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
    
    // P: Encodable, R == [String: Any]
    func request(_ params: P, completion: @escaping (Alamofire.AFDataResponse<Any>) -> Void) where P: Encodable, R == [String: Any] {
        guard let url = self._url() else { return }
        
        let req = _FR.request(url,
                              method: self.modifier.method,
                              parameters: params,
                              encoder: self._encoder(),
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
    
    // P: Encodable, R: Decodable
    func request(_ params: P, completion: @escaping (Alamofire.AFDataResponse<R>) -> Void) where P: Encodable, R: Decodable {
        guard let url = self._url() else { return }
        
        let req = _FR.request(url,
                              method: self.modifier.method,
                              parameters: params,
                              encoder: self._encoder(),
                              headers: self._headers(),
                              requestModifier: self._modifyURLRequest())
        
        self._modifyRequest(req)
        self._modifyDataRequest(req)
        
        req.responseDecodable(of: R.self,
                              queue: self._queue(),
                              dataPreprocessor: self._decodableDataPreprocessor(),
                              decoder: self._decoder(),
                              emptyResponseCodes: self._decodableEmptyResponseCodes(),
                              emptyRequestMethods: self._decodableEmptyRequestMethods(),
                              completionHandler: completion)
    }
}


extension API {
    
    func _method(for ctx: Context) -> Alamofire.HTTPMethod? {
        guard let method = ctx.dataRequest.api.method else {
            _Log.error("HTTPMethod not set, request won't start", location: ctx.requestLocation)
            return nil
        }
        
        return method
    }
    
    func _url(for ctx: Context) -> String? {
        guard let initialURL = ctx.dataRequest.api.initialURL else {
            _Log.error("Initial URL not set, request won't start", location: ctx.requestLocation)
            return nil
        }
        
        var url: String?
        switch initialURL {
        case .full(let fullURL):
            url = fullURL()
            
        case .path(let pathURL):
            guard let baseURL = ctx.dataRequest.api.base else {
                _Log.error("Base URL not set, request won't start", location: ctx.requestLocation)
                return nil
            }
            
            let appendPath = ctx.dataRequest.api.appendPaths.reduce("", { $0 + $1() })
            
            url = baseURL() + pathURL() + appendPath
        }
        
        // mock only in debug mode
        #if DEBUG
        if let mock = ctx.dataRequest.api.mock, let _url = url {
            _Log.warning("Using mock `\(mock())` for `\(_url)`", location: ctx.requestLocation)
            url = mock()
        }
        #endif
        
        return url
    }
}
