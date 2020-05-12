//
//  Configuration.swift
//

import Foundation
import Alamofire


/// 网络请求的相关设置
///
/// 每个请求都会即时的应用Configuration的设置
/// 但Configuration的配置优先级低于具体接口的单独配置
///
/// 比如`login`接口设置了单独的timeoutInterval，那么就会优先使用`login`的timeoutInterval
public enum Configuration {
    
    /// 基地址，适用于所有请求都使用同一个的基地址的情况
    ///
    ///     let login = GET<Account, UserInfo>("v1/login")
    ///
    ///     // 等价于
    ///     let login = GET<Account, UserInfo>("v1/login", base: Configuration.base)
    ///
    ///     // 其中url为:
    ///     let url = base + api
    ///
    public static var base: String?
    
    /// 要添加的头信息，会和`DataRequest.swift`中的`additionalHeaders`进行merge
    /// 但`DataRequest.swift`中的`additionalHeaders`优先级更高，会覆盖掉冲突的key-value
    public static var headers = HTTPHeaders()
    
    /// 超时时长, 用于修改`URLRequest.timeoutInterval`
    /// `DataRequest.swift`中的`timeoutInterval`优先级更高，会覆盖掉冲突的`timeoutInterval`
    public static var timeoutInterval: TimeInterval?
    
    /// 重定向策略，可以使用内置的重定向策略`Redirector`，也可以自定义对`RedirectHandler`的实现
    /// `DataRequest.swift`中的`redirectHandler`优先级更高，会覆盖掉冲突的`redirectHandler`
    public static var redirectHandler: RedirectHandler?

    /// 缓存策略，可以使用内置的缓存策略`ResponseCacher`，也可以自定义对`CachedResponseHandler`的实现
    /// `DataRequest.swift`中的`cachedResponseHandler`优先级更高，会覆盖掉冲突的`cachedResponseHandler`
    public static var cachedResponseHandler: CachedResponseHandler?
}
