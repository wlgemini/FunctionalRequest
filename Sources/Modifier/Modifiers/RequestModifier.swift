//
//  RequestModifier.swift
//  

import Alamofire
import Foundation


/// UploadProgress
public struct UploadProgress: RequestModifier {
    
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


/// DownloadProgress
public struct DownloadProgress: RequestModifier {
    
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


/// Redirect
public struct Redirect: RequestModifier {
    
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


/// CacheResponse
public struct CacheResponse: RequestModifier {
    
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


/// Authenticate
public struct Authenticate: RequestModifier {
    
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
    
    func uploadProgress(queue: DispatchQueue = .main, closure: @escaping Alamofire.Request.ProgressHandler) -> ModifiedAPI<Parameters, Returns, Tuple2<M0, UploadProgress>> {
        self.modifier(UploadProgress(queue: queue, closure: closure))
    }
    
    func downloadProgress(queue: DispatchQueue = .main, closure: @escaping Alamofire.Request.ProgressHandler) -> ModifiedAPI<Parameters, Returns, Tuple2<M0, DownloadProgress>> {
        self.modifier(DownloadProgress(queue: queue, closure: closure))
    }
    
    func redirect(using handler: Alamofire.RedirectHandler) -> ModifiedAPI<Parameters, Returns, Tuple2<M0, Redirect>> {
        self.modifier(Redirect(using: handler))
    }
    
    func cacheResponse(using handler: Alamofire.CachedResponseHandler) -> ModifiedAPI<Parameters, Returns, Tuple2<M0, CacheResponse>> {
        self.modifier(CacheResponse(using: handler))
    }
    
    func authenticate(username: String, password: String, persistence: URLCredential.Persistence = .forSession) -> ModifiedAPI<Parameters, Returns, Tuple2<M0, Authenticate>> {
        self.modifier(Authenticate(username: username, password: password, persistence: persistence))
    }
    
    func authenticate(with credential: URLCredential) -> ModifiedAPI<Parameters, Returns, Tuple2<M0, Authenticate>> {
        self.modifier(Authenticate(with: credential))
    }
}
