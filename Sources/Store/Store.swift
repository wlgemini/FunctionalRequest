//
//  Store.swift
//

import Foundation
import Alamofire


/// namespace for `Store`
public enum Store { }


// MARK: - Session
extension Store {
    
    static var _session = Session()
    
    static var _sessionFinalized: Bool = false
    
    static var _sessionRaw: Alamofire.Session = {
        Self._sessionFinalized = true
        return Alamofire.Session(configuration: Self._session.configuration,
                                             delegate: Self._session.delegate,
                                             rootQueue: Self._session.rootQueue,
                                             startRequestsImmediately: Self._session.startRequestsImmediately,
                                             requestQueue: Self._session.requestQueue,
                                             serializationQueue: Self._session.serializationQueue,
                                             interceptor: Self._session.interceptor,
                                             serverTrustManager: Self._session.serverTrustManager,
                                             redirectHandler: Self._session.redirectHandler,
                                             cachedResponseHandler: Self._session.cachedResponseHandler,
                                             eventMonitors: Self._session.eventMonitors ?? [])
    }()
}

// MARK: - API
extension Store {
    
    static var _api = API()
}
