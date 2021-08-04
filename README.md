# FunctionalRequest

将网络请求表示成函数调用的形式

## 接入

### Cocoapods

```
target 'MyApp' do
  pod 'FunctionalRequest', '~> 5.4.0'
end
```

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/wlgemini/FunctionalRequest.git", .upToNextMajor(from: "5.4.0"))
]
```

## 使用

- 设置`Setting.Session`的相关参数：由于`Setting.Session`的相关参数都有默认值，所以设置`Setting.Session`是可选的

  ```swift
  // 声明要设置哪些参数
  @Setting.Session(\.redirectHandler)
  var redirectHandler
      
  @Setting.Session(\.cachedResponseHandler)
  var cachedResponseHandler
  
  ...
  
  
  // 设置相关参数
  self.redirectHandler(Alamofire.Redirector.doNotFollow)
  self.cachedResponseHandler(Alamofire.ResponseCacher.doNotCache)

- 配置`Setting.API`相关参数：由于`Setting.API`的相关参数都有默认值，所以设置`Setting.API`是可选的。`Setting.API`有与`Setting.Session`重复的设置，但`Setting.API`的优先级高于`Setting.Session`

  ```swift
  // 声明要设置哪些参数
  @Setting.API(\.dataRequest.base)
  var base // base url
      
  @Setting.API(\.dataRequest.headers)
  var headers // default headers
  
  ...
  
  
  // 设置相关参数
  self.base("https://www.xyz.com/")
  self.headers([
    "key1": "value1",
    "key2": "value2",
    ...
  ])
  ```

- 定义请求接口:

  ```swift
  let login = POST<Account, UserInfo>("v1/login") // url = base + path = "https://www.xyz.com/" + "v1/login"
  let friends = GET<Page, [Friend]>("v1/friends") // url = base + path = "https://www.xyz.com/" + "v1/friends"
  ```

- 修饰接口：修饰接口有与`Setting.API`重复的设置，但修饰接口的优先级高于`Setting.API`

  ```swift
  let account = Account(name: "Jack", password: "*******")
  
  login
  	.timeoutInterval(2)
  	.mock("http://www.mocking.com/login")
  	.request(account) { response in
    		// some logic here
  	}
  ```

- 访问`Alamofire.Session`和它的相关参数

  ```swift
  // 定义访问的参数
  @Getting.Session(\.redirectHandler)
  var redirectHandler
  
  // 访问Alamofire.Session.redirectHandler
  self.redirectHandler
  
  // 访问Alamofire.Session
  self.$redirectHandler
  ```

- 访问`Alamofire.DataRequest`和它的相关参数

  ```swift
  @Getting.DataRequest(login)
  var login
  
  // 访问Alamofire.DataRequest
  self.$login.request
  
  // 当前对象deinit时，自动取消请求
  self.$login.isCanncelRequestWhenDeinit = true // 默认true
  ```

  

