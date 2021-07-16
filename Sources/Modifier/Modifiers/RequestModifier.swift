//
//  RequestModifier.swift
//  

import Alamofire
import Foundation


/// ModifyUploadProgress
public struct ModifyUploadProgress: RequestModifier {
    
    public init(queue: DispatchQueue, closure: @escaping Alamofire.Request.ProgressHandler) {
        self._queue = queue
        self._closure = closure
    }
    
    // MARK: RequestModifier
    public func apply(to context: Context) {
        context.forRequest.uploadProgress = (self._queue, self._closure)
    }
    
    // MARK: Internal
    let _queue: DispatchQueue
    let _closure: Alamofire.Request.ProgressHandler
}


/// ModifyDownloadProgress
public struct ModifyDownloadProgress: RequestModifier {
    
    public init(queue: DispatchQueue, closure: @escaping Alamofire.Request.ProgressHandler) {
        self._queue = queue
        self._closure = closure
    }
    
    // MARK: RequestModifier
    public func apply(to context: Context) {
        context.forRequest.downloadProgress = (self._queue, self._closure)
    }
    
    // MARK: Internal
    let _queue: DispatchQueue
    let _closure: Alamofire.Request.ProgressHandler
}


/// ModifyRedirect
public struct ModifyRedirect: RequestModifier {
    
    public init(using handler: Alamofire.RedirectHandler) {
        self.redirectHandler = handler
    }
    
    // MARK: RequestModifier
    public func apply(to context: Context) {
        context.forRequest.redirectUsing = self.redirectHandler
    }
    
    // MARK: Internal
    let redirectHandler: Alamofire.RedirectHandler
}


/// ModifyCacheResponse
public struct ModifyCacheResponse: RequestModifier {
    
    public init(using handler: Alamofire.CachedResponseHandler) {
        self.cachedResponseHandler = handler
    }
    
    // MARK: RequestModifier
    public func apply(to context: Context) {
        context.forRequest.cacheResponseUsing = self.cachedResponseHandler
    }
    
    // MARK: Internal
    let cachedResponseHandler: Alamofire.CachedResponseHandler
}


/// ModifyAuthenticate
public struct ModifyAuthenticate: RequestModifier {
    
    public init(with credential: URLCredential) {
        self.authenticate = .authenticate(with: credential)
    }
    
    public init(username: String, password: String, persistence: URLCredential.Persistence) {
        self.authenticate = .authenticate(username: username, password: password, persistence: persistence)
    }
    
    // MARK: RequestModifier
    public func apply(to context: Context) {
        context.forRequest.authenticate = self.authenticate
    }
    
    // MARK: Internal
    let authenticate: AuthenticateType
}


// MARK: - Request
public extension Request {
    
    func uploadProgress(queue: DispatchQueue = .main, closure: @escaping Alamofire.Request.ProgressHandler) -> some Request {
        self.modifier(UploadProgressModifier(queue: queue, closure: closure))
    }
    
    func downloadProgress(queue: DispatchQueue = .main, closure: @escaping Alamofire.Request.ProgressHandler) -> some Request {
        self.modifier(DownloadProgressModifier(queue: queue, closure: closure))
    }
    
    func redirect(using handler: Alamofire.RedirectHandler) -> some Request {
        self.modifier(RedirectModifier(using: handler))
    }
    
    func cacheResponse(using handler: Alamofire.CachedResponseHandler) -> some Request {
        self.modifier(CacheResponseModifier(using: handler))
    }
    
    func authenticate(username: String, password: String, persistence: URLCredential.Persistence = .forSession) -> some Request {
        self.modifier(AuthenticateModifier(username: username, password: password, persistence: persistence))
    }
    
    func authenticate(with credential: URLCredential) -> some Request {
        self.modifier(AuthenticateModifier(with: credential))
    }
}
