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
    
    static let _sessionRaw: Alamofire.Session = {
        Self._sessionFinalized = true
        return Alamofire.Session(configuration: Self._session.configuration.value,
                                 delegate: Self._session.delegate.value,
                                 rootQueue: Self._session.rootQueue.value,
                                 startRequestsImmediately: Self._session.startRequestsImmediately.value,
                                 requestQueue: Self._session.requestQueue.value,
                                 serializationQueue: Self._session.serializationQueue.value,
                                 interceptor: Self._session.interceptor.value,
                                 serverTrustManager: Self._session.serverTrustManager.value,
                                 redirectHandler: Self._session.redirectHandler.value,
                                 cachedResponseHandler: Self._session.cachedResponseHandler.value,
                                 eventMonitors: Self._session.eventMonitors.value ?? [])
    }()
}

// MARK: - API
extension Store {
    
    static var _api = API()
}
