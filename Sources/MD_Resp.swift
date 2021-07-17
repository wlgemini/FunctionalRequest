
/* Response

DataRequest: Request
func response(queue: DispatchQueue,
              completionHandler: @escaping (AFDataResponse<Data?>) -> Void) -> Self
func response<Serializer: DataResponseSerializerProtocol>(queue: DispatchQueue,
                                                          responseSerializer: Serializer,
                                                          completionHandler: @escaping (AFDataResponse<Serializer.SerializedObject>) -> Void) -> Self
 DataResponseSerializer
 StringResponseSerializer
 JSONResponseSerializer
 DecodableResponseSerializer


 
 
 
 
 
 



DataStreamRequest: Request
func responseStream(on queue: DispatchQueue,
                    stream: @escaping Handler<Data, Never>) -> Self
func responseStreamString(on queue: DispatchQueue,
                          stream: @escaping Handler<String, Never>) -> Self
func responseStream<Serializer: DataStreamSerializer>(using serializer: Serializer,
                                                      on queue: DispatchQueue,
                                                      stream: @escaping Handler<Serializer.SerializedObject, AFError>) -> Self
 DecodableStreamSerializer
 




 




DownloadRequest: Request
func response(queue: DispatchQueue,
              completionHandler: @escaping (AFDownloadResponse<URL?>) -> Void) -> Self
func response<Serializer: DownloadResponseSerializerProtocol>(queue: DispatchQueue,
                                                              responseSerializer: Serializer,
                                                              completionHandler: @escaping (AFDownloadResponse<Serializer.SerializedObject>) -> Void) -> Self
 URLResponseSerializer
 DataResponseSerializer
 StringResponseSerializer
 JSONResponseSerializer
 DecodableResponseSerializer
 
 
 
 
 
 



UploadRequest: DataRequest

*/
























/*
 
 UploadRequest/DataRequest: Request
 Modify:
 .responseQueue()
 .serializeDataResponse<Serializer: DataResponseSerializerProtocol>(using: Serializer)
    DataResponseSerializer
    StringResponseSerializer
    JSONResponseSerializer
    DecodableResponseSerializer
 
 Handy Mody: cond
 .serializeDataResponse(DataResponseSerializer)
 .serializeStringResponse(StringResponseSerializer)
 .serializeJSONResponse(JSONResponseSerializer)
 .serializeDecodableResponse(DecodableResponseSerializer)
  

  Call: cond
  completionHandler(Data)
  completionHandler<DataResponseSerializerProtocol>
 
 
 
 
 
 
 
 
 DataStreamRequest: Request
 Modify:
  .responseQueue(Data)
  .serializeDataStream<Serializer: DataStreamSerializer>(using: Serializer)
    DecodableStreamSerializer
 
 Handy Mody:
  .serializeDataStream(DecodableStreamSerializer)
  

  Call:
  completionHandler(Data)
  completionHandler(String)
  completionHandler<DataStreamSerializer>

 
 
 
 
 
 
 DownloadRequest: Request
 Modify:
  .responseQueue(Data)
  .serializeDownloadResponse<Serializer: DownloadResponseSerializerProtocol>(using: Serializer)
    URLResponseSerializer
    DataResponseSerializer
    StringResponseSerializer
    JSONResponseSerializer
    DecodableResponseSerializer
 
 Handy Mody:
 .serializeURLResponse(URLResponseSerializer)
 .serializeDataResponse(DataResponseSerializer)
 .serializeStringResponse(StringResponseSerializer)
 .serializeJSONResponse(JSONResponseSerializer)
 .serializeDecodableResponse(DecodableResponseSerializer)
  
  

  Call:
  completionHandler(URL)
  completionHandler<DownloadResponseSerializerProtocol>
 */



























/*
 Modify:
 .responseQueue()
 
 
 Modify:
 UploadRequest/DataRequest: Request
 .serializeDataResponse<Serializer: DataResponseSerializerProtocol>(using: Serializer)
    DataResponseSerializer
    StringResponseSerializer
    JSONResponseSerializer
    DecodableResponseSerializer
 
 DataStreamRequest: Request
  .serializeDataStream<Serializer: DataStreamSerializer>(using: Serializer)
    DecodableStreamSerializer
 
 DownloadRequest: Request
  .serializeDownloadResponse<Serializer: DownloadResponseSerializerProtocol>(using: Serializer)
    URLResponseSerializer
    DataResponseSerializer
    StringResponseSerializer
    JSONResponseSerializer
    DecodableResponseSerializer
 
 
 
 
 Handy Mody:
 .serializeDataResponse(DataResponseSerializer)             // DownloadRequest/UploadRequest/DataRequest
 .serializeStringResponse(StringResponseSerializer)         // DownloadRequest/UploadRequest/DataRequest
 .serializeJSONResponse(JSONResponseSerializer)             // DownloadRequest/UploadRequest/DataRequest
 .serializeDecodableResponse(DecodableResponseSerializer)   // DownloadRequest/UploadRequest/DataRequest
 .serializeURLResponse(URLResponseSerializer)               // DownloadRequest
 .serializeDataStream(DecodableStreamSerializer)            // DataStreamRequest

 
 
 CompletionHandler
 UploadRequest/DataRequest
  completionHandler(Data)
  completionHandler<DataResponseSerializerProtocol>

 DataStreamRequest: Request
  completionHandler(Data)
  completionHandler(String)
  completionHandler<DataStreamSerializer>

 DownloadRequest: Request
  completionHandler(URL)
  completionHandler<DownloadResponseSerializerProtocol>
 
 */
