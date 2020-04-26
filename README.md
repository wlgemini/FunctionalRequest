# FunctionalRequest

这个项目是用来尝试将网络请求表示成函数调用的

### 思路

理论上来说，任何一个确定的API（在返回结果正常的情况下）都应该是有：
- 确定结构的参数
- 确定结构的返回值

这其实就和函数的定义很像，任何一个确定功的函数有：
- 确定类型的入参（可能为Void）
- 确定类型的返回值（可能为Void）

那么应该是可以定义一个函数来代表一个API的。
一个理想的API定义如下：

```swift
struct APIs {
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
}
```

其使用如下：
```swift
// login
let account = Account(email: "xxxyyy@xy.com", password: "123456")
let userInfo = await APIs.login(account)

// get friends
let page = Page(index: 0, total: 10)
let friends = await APIs.friends(page)
```

> 以上使用是在Swift 6.0支持`async`/`await`特性后才能用的
> 目前还写不出这种形式，不过这应该是以后的发展方向。

## 在Swift 5.2版本的尝试

在Swift 5.2中新增了`callAsFunction`函数，可以让一个实例作为函数被调用。比如：
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
let a = addTwo(0) // 2
let b = addTwo(1) // 3
let c = addTwo(5) // 7
```

可以看出来，这和设想中的样子很像了（除了`async`/`await`这个特性）

由于没有`async`/`await`这个特性，现在的异步回调还是需要使用closure。就像这样：

```swift
APIs.login(account) { response in // 这里是一个尾随闭包
  	let friends = response.value
}
```

但这里存在一个问题，目前编译器对`callAsFunction`的智能提示还是很弱，导致提示有些情况下提示不出来，书写代码时体验上会比较差。所以目前暂时不使用`callAsFunction`这个特性。

## 设计方案

通过类型名直接区分出不同的网络请求：

```swift
/// 从服务器取出资源（一项或多项）
struct GET<Input, Output>

/// 在服务器新建一个资源
struct POST<Input, Output>

/// 在服务器更新资源（客户端提供改变后的完整资源）
struct PUT<Input, Output>

/// 在服务器更新资源（客户端提供改变的属性）
struct PATCH<Input, Output>

/// 从服务器删除资源
struct DELETE<Input, Output>
```

范型参数`Input`表示网络请求的参数类型

范型参数`Output`表示网络请求的返回值类型

理想状态下`Input`应该是`Encodable`的，而`Output`应该是`Decodable`的。

但也会存在更为一般的情况：

- `<Input, Output>`可能为空，也就是网络请求不需要参数，或者不关心返回值。
- `<Input, Output>`可能是`JSON`类型，也就是一个`Any`。

对于这些情况，请求方法的也应该区分成不同的形式，使得在调用时不会调用错误的请求方法。

为了区分出这些不同的情况，这里定义了:

```swift
enum None // 用于表示：Input/Output为空，也就是网络请求不需要参数，或者不关心返回值。

enum JSON // 用于表示：Input/Output可能是JSON类型，也就是一个Any。
```

由于这些请求类型(`GET/POST/...`)都有相同的功能，所以用`protocol Requestable`来抽取这些功能。

```swift
protocol Requestable {
    
    /// Input type (aka params)
    associatedtype Input
    
    /// Output type (aka response data)
    associatedtype Output
  
  	/// the request method
    var method: HTTPMethod { get }
    
    /// the request api
    var api: String { get }
}
```

`Requestable.api`需要和一个`Configuration.base`来组成一个请求的URL。`Configuration`用于做一些全局的配置，后面会提到。

之后，所有的请求类型都遵守这个协议就可以了，比如：

```swift
struct GET<Input, Output>: Requestable

struct POST<Input, Output>: Requestable
```

针对不同的`Input/Output`类型，使用Swift的`Conditional Conformance`特性来划分不同的请求方法。这使得不同类型的`Input/Output`都有属于自己的请求方法：

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
    func request(completion: @escaping (DataResponse<Output, AFError>) -> Void)
}

extension Requestable where Input == JSON, Output == JSON {
    func request(_ params: [String: Any], completion: @escaping (AFDataResponse<Any>) -> Void)
}

extension Requestable where Input == JSON, Output: Decodable {
    func request(_ params: [String: Any], completion: @escaping (DataResponse<Output, AFError>) -> Void)
}

extension Requestable where Input: Encodable, Output == JSON {
    func request(_ params: Input, completion: @escaping (AFDataResponse<Any>) -> Void)
}

extension Requestable where Input: Encodable, Output: Decodable {
    func request(_ params: Input, completion: @escaping (DataResponse<Output, AFError>) -> Void)
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

#### 请求类型的可扩展性

如果有自定义请求类型，直接遵守`Requestable`协议就可以了，比如:

```swift
struct CUSTOM<Input, Output>: Requestable {
		let method: HTTPMethod = .custom 
  	// ...
}
```

除了自定义请求这种情况，一个网络请求还应该会用更多的可配置项。比如：请求超时时间，设置额外的headers，做mock等等。

这些配置项都可以进行全局配置，使用`Configuration`来存储这些全局配置。

```swift
Configuration.timeoutInterval = 60
// Configuration.headers
```

而不同的请求也可能会有不同的配置项，需要允许不同的请求有不同的配置项。

```swift
login
	.setTimeoutInterval(2)
	.setMocking("http://www.mocking.com/login")
	.request()
```

### 推荐用法

在使用网络请求之前，首先要配置`Configuration`，至少配置一个`base`(基地址)

定义网络请求（推荐定义在一个类型内，这里定义在了`APIs`中）:

```swift
struct APIs {
    // 登录
    static let login = POST<Account, UserInfo>("api/v1/login")

    // 获取好友
    static let friends = GET<Page, [Friend]>("api/v1/friends")
}
```

使用:

```swift
// 登录
let account = Account(email: "xxxyyy@xy.com", password: "123456")
APIs.login.request(account) {
  	print($0.value) // UserInfo
}

/// 获取好友
let page = Page(index: 0, total: 10)
APIs.friends.request(page) {
  	print($0.value) // [Friend]
}

/// mock获取好友
APIs.friends
	.setMocking("http://www.mocking.com/friends")
	.request(page) {
    print($0.value) // [Friend]
  }
```



