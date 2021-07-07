//
//  Store.Session.swift
//  
//
//  Created by wangluguang on 2021/7/7.
//

import Foundation
import Alamofire


extension Store {
    
    struct Session {
        var configuration: URLSessionConfiguration = URLSessionConfiguration.af.default
        var delegate: SessionDelegate = SessionDelegate()
        var rootQueue: DispatchQueue = DispatchQueue(label: "org.alamofire.session.rootQueue")
        var startRequestsImmediately: Bool = true
        var requestQueue: DispatchQueue? = nil
        var serializationQueue: DispatchQueue? = nil
        var interceptor: RequestInterceptor? = nil
        var serverTrustManager: ServerTrustManager? = nil
        var redirectHandler: RedirectHandler? = nil
        var cachedResponseHandler: CachedResponseHandler? = nil
        var eventMonitors: [EventMonitor] = []
        
        // session instance init from above propertys
        var session: Alamofire.Session?
    }
}
