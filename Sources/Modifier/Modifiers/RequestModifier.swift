//
//  RequestModifier.swift
//  

import Alamofire
import Foundation



struct UploadProgressModifier: Modifier {
    
    let queue: DispatchQueue = .main
    let closure: Alamofire.Request.ProgressHandler
    
    func apply(to context: Context) {
        //AF.request("").uploadProgress(queue: <#T##DispatchQueue#>, closure: <#T##Request.ProgressHandler##Request.ProgressHandler##(Progress) -> Void#>)
    }
}


struct DownloadProgressModifier: Modifier {
    
    let queue: DispatchQueue = .main
    let closure: Alamofire.Request.ProgressHandler
    
    func apply(to context: Context) {
        //AF.request("").downloadProgress(queue: <#T##DispatchQueue#>, closure: <#T##Request.ProgressHandler##Request.ProgressHandler##(Progress) -> Void#>)
    }
}


struct RedirectModifier: Modifier {
    
    let redirectHandler: Alamofire.RedirectHandler
    
    func apply(to context: Context) {
        //AF.request("").redirect(using: <#T##RedirectHandler#>)
    }
}

struct CacheResponseModifier {
    
    let handler: Alamofire.CachedResponseHandler
    
    func apply(to context: Context) {
        //AF.request("").cacheResponse(using: CachedResponseHandler)
    }
}

struct AuthenticateModifier: Modifier {
    
    let credential: URLCredential
    
    func apply(to context: Context) {
        //AF.request("").authenticate(with: <#T##URLCredential#>)
        //AF.request("").authenticate(username: <#T##String#>, password: <#T##String#>))
        //AF.request("").authenticate(username: <#T##String#>, password: <#T##String#>, persistence: <#T##URLCredential.Persistence#>)
    }
}


//- modify default Request's property:
//   - Progress:
//       - uploadProgress
//       - downloadProgress
//   - Handling Redirects
//   - Customizing Caching
//   - Credentials
