


//@propertyWrapper
//@dynamicMemberLookup
//struct KeyPathProperty<O, V> {
//
//    let value: O
//
//    public subscript<V>(dynamicMember keyPath: ReferenceWritableKeyPath<O, V>) -> Binding<V> {
//        return value[keyPath]
//    }
//}



/*
 Store:
 1. Session
 
 
 Property:
 1. Session:
    - access default Session
    - modify default Session's property before session initiate
 
 2. Request:
     - make function call:
        - resume()
        - suspend()
        - cancel()
        - etc
     - modify default DataRequest's property:
        - Progress:
            - uploadProgress
            - downloadProgress
        - Handling Redirects
        - Customizing Caching
        - Credentials
        - Lifetime Values
            - URLRequests
            - URLSessionTasks
        - Response
 
    1. DataRequest
 
    2. UploadRequest
 
    3. DownloadRequest
 
 */

