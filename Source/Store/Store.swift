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
        return Alamofire.Session(configuration: Self._session.configuration._value,
                                 delegate: Self._session.delegate._value,
                                 rootQueue: Self._session.rootQueue._value,
                                 startRequestsImmediately: Self._session.startRequestsImmediately._value,
                                 requestQueue: Self._session.requestQueue._value,
                                 serializationQueue: Self._session.serializationQueue._value,
                                 interceptor: Self._session.interceptor._value,
                                 serverTrustManager: Self._session.serverTrustManager._value,
                                 redirectHandler: Self._session.redirectHandler._value,
                                 cachedResponseHandler: Self._session.cachedResponseHandler._value,
                                 eventMonitors: Self._session.eventMonitors._value ?? [])
    }()
}

// MARK: - API
extension Store {
    
    static var _api = API()
}
