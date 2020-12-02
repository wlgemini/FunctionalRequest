//
//  DataRequestable+Modifier.swift
//

import Foundation
import Alamofire


// MARK: - DataRequestable Modifier
public extension DataRequestable {
    
    /// 设置sub api
    func setSubApi(_ subApi: String) -> Self {
        var new = self
        new.configuration.subApi = subApi
        return new
    }
    
    /// mock到指定url，需要使用绝对地址
    func setMock(_ mock: String) -> Self {
        var new = self
        new.configuration.mock = mock
        return new
    }
    
    /// 添加额外的headers
    func setAdditionalHeaders(_ headers: Alamofire.HTTPHeaders) -> Self {
        var new = self
        new.configuration.additionalHeaders = headers
        return new
    }
    
    /// 设置单独超时时间
    func setTimeoutInterval(_ timeout: TimeInterval) -> Self {
        var new = self
        new.configuration.timeoutInterval = timeout
        return new
    }
    
    /// set credential
    func setCredential(username: String, password: String, persistence: URLCredential.Persistence = .forSession) -> Self {
        let credential = URLCredential(user: username, password: password, persistence: persistence)
        return self.setCredential(credential)
    }
    
    /// set credential
    func setCredential(_ credential: URLCredential) -> Self {
        var new = self
        new.configuration.credential = credential
        return new
    }
    
    /// 设置重定向策略，可以使用内置的重定向策略`Redirector`
    func setRedirectHandler(_ handler: Alamofire.RedirectHandler) -> Self {
        var new = self
        new.configuration.redirectHandler = handler
        return new
    }
    
    /// set validation
    func setValidation(_ validation: @escaping Alamofire.DataRequest.Validation) -> Self {
        var new = self
        new.configuration.validation = validation
        return new
    }
    
    /// 设置缓存策略，可以使用内置的缓存策略`ResponseCacher`
    func setCachedResponseHandler(_ handler: Alamofire.CachedResponseHandler) -> Self {
        var new = self
        new.configuration.cachedResponseHandler = handler
        return new
    }
    
    /// 设置encoding方式
    func setEncoding(_ encoding: Alamofire.ParameterEncoding) -> Self where Input == JSON {
        var new = self
        new.configuration.encoding = encoding
        return new
    }
    
    /// 设置encoder
    func setEncoder(_ encoder: Alamofire.ParameterEncoder) -> Self where Input: Encodable {
        var new = self
        new.configuration.encoder = encoder
        return new
    }
}
