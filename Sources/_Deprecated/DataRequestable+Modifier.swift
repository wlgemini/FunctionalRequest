//
//  DataRequestable+Modifier.swift
//

import Foundation
import Alamofire


// MARK: - DataRequestable Modifier
// MARK: API
public extension DataRequestable {
    
    /// 设置sub api
    func setSubApi(_ subApi: String) -> Self {
        var copy = self
        copy.modifier.subApi = subApi
        return copy
    }
    
    /// mock到指定url，需要使用绝对地址
    func setMock(_ mock: String) -> Self {
        var copy = self
        copy.modifier.mock = mock
        return copy
    }
}

// MARK: DataRequest
public extension DataRequestable {
    
    /// 添加额外的headers
    func setAdditionalHeaders(_ additionalHeaders: Alamofire.HTTPHeaders) -> Self {
        var copy = self
        copy.modifier.dataRequest.additionalHeaders = additionalHeaders
        return copy
    }
    
    /// 设置单独超时时间
    func setTimeoutInterval(_ timeoutInterval: TimeInterval) -> Self {
        var copy = self
        copy.modifier.dataRequest.timeoutInterval = timeoutInterval
        return copy
    }
    
    /// set credential
    func setCredential(username: String, password: String, persistence: URLCredential.Persistence = .forSession) -> Self {
        let credential = URLCredential(user: username, password: password, persistence: persistence)
        return self.setCredential(credential)
    }
    
    /// set credential
    func setCredential(_ credential: URLCredential) -> Self {
        var copy = self
        copy.modifier.dataRequest.credential = credential
        return copy
    }
    
    /// 设置重定向策略，可以使用内置的重定向策略`Redirector`
    func setRedirectHandler(_ redirectHandler: Alamofire.RedirectHandler) -> Self {
        var copy = self
        copy.modifier.dataRequest.redirectHandler = redirectHandler
        return copy
    }
    
    /// 设置encoding方式
    func setEncoding(_ encoding: Alamofire.ParameterEncoding) -> Self where Input == JSON {
        var copy = self
        copy.modifier.dataRequest.encoding = encoding
        return copy
    }
    
    /// 设置encoder
    func setEncoder(_ encoder: Alamofire.ParameterEncoder) -> Self where Input: Encodable {
        var copy = self
        copy.modifier.dataRequest.encoder = encoder
        return copy
    }
}


// MARK: DataResponse
public extension DataRequestable {
    
    /// 设置回调的队列
    func setQueue(_ queue: DispatchQueue) -> Self {
        var copy = self
        copy.modifier.dataResponse.queue = queue
        return copy
    }
    
    /// set validation
    func setValidation(_ validation: @escaping Alamofire.DataRequest.Validation) -> Self {
        var copy = self
        copy.modifier.dataResponse.validation = validation
        return copy
    }
    
    /// 设置缓存策略，可以使用内置的缓存策略`ResponseCacher`
    func setCachedResponseHandler(_ cachedResponseHandler: Alamofire.CachedResponseHandler) -> Self {
        var copy = self
        copy.modifier.dataResponse.cachedResponseHandler = cachedResponseHandler
        return copy
    }
    
    /// 设置JSON的JSONSerialization.ReadingOptions
    func setOptions(_ options: JSONSerialization.ReadingOptions) -> Self where Output == JSON {
        var copy = self
        copy.modifier.dataResponse.options = options
        return copy
    }
    
    /// 设置Decoder
    func setDecoder(_ decoder: Alamofire.DataDecoder) -> Self where Output: Decodable {
        var copy = self
        copy.modifier.dataResponse.decoder = decoder
        return copy
    }
    
    /// 设置Alamofire.DataPreprocessor
    func setDataPreprocessor(_ dataPreprocessor: Alamofire.DataPreprocessor) -> Self {
        var copy = self
        copy.modifier.dataResponse.dataPreprocessor = dataPreprocessor
        return copy
    }
    
    /// 设置emptyResponseCodes
    func setEmptyResponseCodes(_ emptyResponseCodes: Set<Int>) -> Self {
        var copy = self
        copy.modifier.dataResponse.emptyResponseCodes = emptyResponseCodes
        return copy
    }
    
    /// 设置emptyRequestMethods
    func setEmptyRequestMethods(_ emptyRequestMethods: Set<Alamofire.HTTPMethod>) -> Self {
        var copy = self
        copy.modifier.dataResponse.emptyRequestMethods = emptyRequestMethods
        return copy
    }
}
