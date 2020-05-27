# FunctionalRequest

将网络请求表示成函数调用的形式

### 思路

理论上来说，任何一个确定的API（在返回结果正常的情况下）都应该是有：
- 确定结构的参数
- 确定结构的返回值

这其实就和函数的定义很像，任何一个确定功的函数有：
- 确定类型的入参（可能为Void）
- 确定类型的返回值（可能为Void）

那么应该是可以定义一个函数来代表一个API的。

一个理想的API的定义方式如下：

```swift
// 登录
// login被定义为一个POST请求
// 它的入参是一个类型为Account的model，用来表示用户名和密码
// 它的返回值是一个类型为UserInfo的model，用来表示用户的一些信息
// 它实际访问的地址为https://www.xxxyyy.com/api/v1/login
//
static let login = POST<Account, UserInfo>("https://www.xxxyyy.com/api/v1/login")

// 获取好友
// friends被定义为一个GET请求
// 它的入参类型为Page，用来表示分页
// 它的返回值类型为[Friend]，用来表示一个Friend数组
// 它实际访问的地址为https://www.xxxyyy.com/api/v1/friends
//
static let friends = GET<Page, [Friend]>("https://www.xxxyyy.com/api/v1/friends")
```

其使用如下：
```swift
// login
let account = Account(email: "xxxyyy@xy.com", password: "123456")
let userInfo = await login(account)

// get friends
let page = Page(index: 0, total: 10)
let friends = await friends(page)
```

> 以上使用是在Swift 6.0支持`async`/`await`特性后才能用的
> 目前还写不出这种形式，不过这应该是以后的发展方向。

## 在Swift 5.2版本的尝试

在Swift 5.2中新增了`callAsFunction()`函数，可以让一个实例作为函数被调用。比如：
```swift
struct Add {
    let adder: Int
  
    init(_ adder: Int) {
        self.adder = adder
    }
  
    func callAsFunction(_ other: Int) -> Int {
        return other + self.adder
    }
}

let addTwo = Add(2)
let a = addTwo(0) // let a = addTwo.callAsFunction(0)
let b = addTwo(1) // let a = addTwo.callAsFunction(1)
let c = addTwo(5) // let a = addTwo.callAsFunction(5)
```

可以看出来，这和设想中的样子很像了（除了`async`/`await`这个特性）

由于没有`async`/`await`这个特性，现在的异步回调还是需要使用closure。就像这样：

```swift
login(account) { response in 
  	let friends = response.value
}

// 等价于
login.callAsFunction(account) { response in
      let friends = response.value
}
```

但这里存在一个问题，目前 (Swift 5.2) 编译器对`callAsFunction()`的智能提示还是很弱，导致提示有些情况下提示不出来，调用方在书写代码时体验上会比较差。所以目前暂时不使用`callAsFunction()`这个特性。
暂时考虑使用显示的调用，比如：使用`request()`作为函数名来代替`callAsFunction()`
```swift
login.request(account) { /* ... */ }
```

## 设计方案

通过类型名直接区分出不同的网络请求：

```swift
struct GET<Input, Output>

struct POST<Input, Output>

struct PUT<Input, Output>

struct PATCH<Input, Output>

struct DELETE<Input, Output>
```

范型参数`Input`表示网络请求的参数类型

范型参数`Output`表示网络请求的返回值类型

理想状态下`Input`应该是`Encodable`的，而`Output`应该是`Decodable`的。

但也会存在更为一般的情况：

- `<Input, Output>`中可能为空，也就是网络请求不需要参数，或者不关心返回值。
- `<Input, Output>`中可能是`JSON`类型，也就是一个`Any`类型。

对于这些情况，请求方法的也应该区分成不同的形式，使得在调用时不会调用到错误的请求方法。

为了区分出这些不同的情况，这里定义了:

```swift
enum None // 用于表示：Input/Output为空，也就是网络请求不需要参数，或者不关心返回值。

enum JSON // 用于表示：Input/Output可能是JSON类型，也就是一个Any。
```

针对不同的`Input/Output`类型，使用Swift的`Conditional Conformance`特性来划分不同的请求方法。这使得不同的`Input/Output`类型组合都有属于自己唯一的请求方法：

```swift
extension Requestable where Input == None, Output == None {
    func request()
}

extension Requestable where Input == JSON, Output == None {
    func request(_ params: [String: Any])
}

extension Requestable where Input: Encodable, Output == None {
    func request(_ params: Input)
}

extension Requestable where Input == None, Output == JSON {
    func request(completion: @escaping (AFDataResponse<Any>) -> Void)
}

extension Requestable where Input == None, Output: Decodable {
    func request(completion: @escaping (AFDataResponse<Output>) -> Void)
}

extension Requestable where Input == JSON, Output == JSON {
    func request(_ params: [String: Any], completion: @escaping (AFDataResponse<Any>) -> Void)
}

extension Requestable where Input == JSON, Output: Decodable {
    func request(_ params: [String: Any], completion: @escaping (AFDataResponse<Output>) -> Void)
}

extension Requestable where Input: Encodable, Output == JSON {
    func request(_ params: Input, completion: @escaping (AFDataResponse<Any>) -> Void)
}

extension Requestable where Input: Encodable, Output: Decodable {
    func request(_ params: Input, completion: @escaping (AFDataResponse<Output>) -> Void)
}
```

以上请求方法，就是`Input/Output`类型的大部分情况了

当然还有`Output == Data`这种特殊情况，对于希望返回`Data`数据的情况会很有用：

```swift
extension Requestable where Input == None, Output == Data {
    func request(completion: @escaping (AFDataResponse<Data>) -> Void)
}

extension Requestable where Input == JSON, Output == Data {
    func request(_ params: [String: Any], completion: @escaping (AFDataResponse<Data>) -> Void)
}

extension Requestable where Input: Encodable, Output == Data {
    func request(_ params: Input, completion: @escaping (AFDataResponse<Data>) -> Void)
}
```

#### 请求的可配置性

一个网络请求应该有更多的可配置项。比如：修改基地址、设置请求超时时间、缓存请求、设置headers、做mock等。
这些配置项都应该允许进行全局配置，可以使用一个全局的对象来存储这些配置。
这里使用`Config.DataRequest`来存储这些全局配置：
```swift
Config.DataRequest.timeoutInterval = 60
// Config.DataRequest.headers
// Config.DataRequest.base
// ...
```

对于不同的请求也可能需要设置独立的配置项，应该允许不同的请求有不同的配置项。
这里允许一个独立的请求有自己配置项：
```swift
login
     .setTimeoutInterval(2)
     .setMock("http://www.mocking.com/login")
     .request()
```

### 推荐用法

在使用网络请求之前，首先要配置`Config.DataRequest`，至少配置一个`base`(基地址)

定义网络请求（推荐定义在一个`enum`类型内，这样方便归类）:
```swift
Configuration.base = "https://www.xxx.com/"

enum APIs {
	
    // 登录
    static let login = POST<Account, UserInfo>("api/v1/login")

    // 获取好友
    static let friends = GET<Page, [Friend]>("api/v1/friends")
}
```

使用:
```swift
// 登录
let account = Account(email: "mine@xy.com", password: "123456")
APIs.login.request(account) {
  	print($0.value) // UserInfo
}

/// 获取好友
let page = Page(index: 0, total: 10)
APIs.friends.request(page) {
  	print($0.value) // [Friend]
}

/// mock获取好友
APIs
		.friends
		.setMock("http://www.mocking.com/friends")
		.request(page) {
    		print($0.value) // [Friend]
  	}
```

#### 多个base url的情况
对于多个base url情况，使用方式如下：
```swift
enum Bases {
    
    // base 0
    let base0 = "https://www.xxx.com/"
    
    // base 1
    let base1 = "https://www.yyy.com/"
}

enum APIs {
    
    // 登录
    static let login = POST<Account, UserInfo>("api/v1/login", base: Bases.base0)

    // 获取好友
    static let friends = GET<Page, [Friend]>("api/v1/friends", base: Bases.base1)
}
```

#### 需要修改base url的情况
程序运行过程中，有可能需要切换base url的情况。

对于设置`Config.DataRequest.base`的情况:
其实直接修改就可以了，之后的请求就会应用最新的base url。
```swift
// before
Config.DataRequest.base = "https://www.xxx.com/"

// after
Config.DataRequest.base = "https://www.yyy.com/"
```

对于多个base url的情况，也是一样的：
直接修改定义的base就可以了，之后的请求就会应用最新的base url。
```swift
enum Bases {
    
    // base 0
    let base0 = "https://www.xxx.com/"
    
    // base 1
    let base1 = "https://www.yyy.com/"
}

enum APIs {
    
    // 登录
    static let login = POST<Account, UserInfo>("api/v1/login", base: Bases.base0)

    // 获取好友
    static let friends = GET<Page, [Friend]>("api/v1/friends", base: Bases.base1)
}

// after
Bases.base0 = Config.DataRequest.base = "https://www.zzz.com/"
```

#### 网络请求监控
对于需要监控网络请求的情况，可以使用：
```swift
let monitor0: ClosureEventMonitor = /* init ClosureEventMonitor */
let monitor1: ClosureEventMonitor = /* init ClosureEventMonitor */
let monitor2: ClosureEventMonitor = /* init ClosureEventMonitor */

Config.DataRequest.eventMonitors = [monitor0, monitor1, monitor2]

// 登录
APIs.login.request(account) { /* data */ }
```
> ⚠️注意：必须在调用网络请求之前设置`Config.DataRequest.eventMonitors`，并且调用网络请求开始后不能修改

### 接入
使用`Cocoapods`:
```
target 'MyApp' do
  pod 'FunctionalRequest'
end
```
