//
//  Store.Session.swift
//

import Foundation
import Alamofire


extension Store {
    
    /// Session
    public final class Session {
        
        public var configuration = Setter.Copy.Nonnil<URLSessionConfiguration>(URLSessionConfiguration.af.default)
        
        public var delegate = Setter.Copy.Nonnil<Alamofire.SessionDelegate>(SessionDelegate())
        
        public var rootQueue = Setter.Copy.Nonnil<DispatchQueue>(DispatchQueue(label: "FunctionalRequest.Session.rootQueue"))
        
        public var startRequestsImmediately = Setter.Copy.Nonnil<Bool>(true)
        
        public var requestQueue = Setter.Copy.Nillable<DispatchQueue>()
        
        public var serializationQueue = Setter.Copy.Nillable<DispatchQueue>()
        
        public var interceptor = Setter.Copy.Nillable<Alamofire.RequestInterceptor>()
        
        public var serverTrustManager = Setter.Copy.Nillable<Alamofire.ServerTrustManager>()
        
        public var redirectHandler = Setter.Copy.Nillable<Alamofire.RedirectHandler>()
        
        public var cachedResponseHandler = Setter.Copy.Nillable<Alamofire.CachedResponseHandler>()
        
        public var eventMonitors = Setter.Copy.Nillable<[Alamofire.EventMonitor]>()
        
        init() { }
    }
}