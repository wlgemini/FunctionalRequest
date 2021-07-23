//
//  Store.Session.swift
//

import Foundation
import Alamofire


extension Store {
    
    /// Session
    public struct Session {
        
        public var configuration: URLSessionConfiguration = URLSessionConfiguration.af.default
        
        public let delegate: SessionDelegate = SessionDelegate()
        
        public let rootQueue: DispatchQueue = DispatchQueue(label: "FunctionalRequest.Session.rootQueue")
        
        public let startRequestsImmediately: Bool = true
        
        public var requestQueue: DispatchQueue? = nil
        
        public var serializationQueue: DispatchQueue? = nil
        
        public var interceptor: RequestInterceptor? = nil
        
        public var serverTrustManager: ServerTrustManager? = nil
        
        public var redirectHandler: RedirectHandler? = nil
        
        public var cachedResponseHandler: CachedResponseHandler? = nil
        
        public var eventMonitors: [EventMonitor]? = nil
        
        public var shared: Alamofire.Session? {
            get {
                if Store._sessionFinalized {
                    return Store._sessionRaw
                } else {
                    return nil
                }
            }
            
            nonmutating set { _ = newValue }
        }
        
        init() { }
    }
}
