//
//  RequestModifier.swift
//  

import Alamofire
import Foundation


/// UploadProgressModifier
public struct UploadProgressModifier {
    
    public init(queue: DispatchQueue, closure: @escaping Alamofire.Request.ProgressHandler) {
        self._queue = queue
        self._closure = closure
    }
    
    // MARK: Internal
    let _queue: DispatchQueue
    let _closure: Alamofire.Request.ProgressHandler
}


/// DownloadProgressModifier
public struct DownloadProgressModifier {
    
    public init(queue: DispatchQueue, closure: @escaping Alamofire.Request.ProgressHandler) {
        self._queue = queue
        self._closure = closure
    }
    
    // MARK: Internal
    let _queue: DispatchQueue
    let _closure: Alamofire.Request.ProgressHandler
}


/// RedirectModifier
public struct RedirectModifier {
    
    let redirectHandler: Alamofire.RedirectHandler
    
    public init(using handler: Alamofire.RedirectHandler) {
        self.redirectHandler = handler
    }
}


/// CacheResponseModifier
public struct CacheResponseModifier {
    
    let cachedResponseHandler: Alamofire.CachedResponseHandler
    
    public init(using handler: Alamofire.CachedResponseHandler) {
        self.cachedResponseHandler = handler
    }
}


/// AuthenticateModifier
public struct AuthenticateModifier {
    
    let authenticate: AuthenticateType
    
    public init(with credential: URLCredential) {
        self.authenticate = .authenticate(with: credential)
    }
    
    public init(username: String, password: String, persistence: URLCredential.Persistence) {
        self.authenticate = .authenticate(username: username, password: password, persistence: persistence)
    }
}


// MARK: - Modifier
extension UploadProgressModifier: Modifier {
    
    public func apply(to context: Context) {
        context.forRequest.uploadProgress = (self._queue, self._closure)
    }
}


extension DownloadProgressModifier: Modifier {
    
    public func apply(to context: Context) {
        context.forRequest.downloadProgress = (self._queue, self._closure)
    }
}


extension RedirectModifier: Modifier {
    
    public func apply(to context: Context) {
        context.forRequest.redirectUsing = self.redirectHandler
    }
}


extension CacheResponseModifier: Modifier {
    
    public func apply(to context: Context) {
        context.forRequest.cacheResponseUsing = self.cachedResponseHandler
    }
}


extension AuthenticateModifier: Modifier {
    
    public func apply(to context: Context) {
        context.forRequest.authenticate = self.authenticate
    }
}


// MARK: - API
public extension API {
    
    func uploadProgress(queue: DispatchQueue = .main, closure: @escaping Alamofire.Request.ProgressHandler) -> some API {
        self.modifier(UploadProgressModifier(queue: queue, closure: closure))
    }
    
    func downloadProgress(queue: DispatchQueue = .main, closure: @escaping Alamofire.Request.ProgressHandler) -> some API {
        self.modifier(DownloadProgressModifier(queue: queue, closure: closure))
    }
    
    func redirect(using handler: Alamofire.RedirectHandler) -> some API {
        self.modifier(RedirectModifier(using: handler))
    }
    
    func cacheResponse(using handler: Alamofire.CachedResponseHandler) -> some API {
        self.modifier(CacheResponseModifier(using: handler))
    }
    
    func authenticate(username: String, password: String, persistence: URLCredential.Persistence = .forSession) -> some API {
        self.modifier(AuthenticateModifier(username: username, password: password, persistence: persistence))
    }
    
    func authenticate(with credential: URLCredential) -> some API {
        self.modifier(AuthenticateModifier(with: credential))
    }
}
