//
//  HTTPClientTests.swift
//  Re-CounterTests
//
//  Created by Andrés Alexis Rivas Solorzano on 7/30/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import XCTest
@testable import movs

//ISOLATED TESTS WITH A STUB
class URLSessionHTTPClientTests: XCTestCase  {
    
    //Yo prefiero hacer un system under test en cada prueba sin embargo el urlprotocol se crea en tiempo de ejecución por el sistema, por lo que es mala practica instanciar una subclase, en este caso 'URLProtocolStub', directamente.
    //En cambio se registra para que el sistema la instancie según sea necesario.
    override func setUp() {
        super.setUp()
        URLProtocolStub.startInterceptingRequests()
    }
    
    override func tearDown() {
        super.tearDown()
        URLProtocolStub.stopInterceptingRequests()
    }
    
    func test_client_performsRequest() {
        let request = someURLRequest()
        let exp = expectation(description: "wait for request")
        URLProtocolStub.observeRequests { receivedRequest in
            XCTAssertEqual(request.url, receivedRequest.url)
            exp.fulfill()
        }
        
        makeSUT().executeRequest(request: request){ _ in }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_client_failsOnRequestError() {
        let requestError = someError()
        let receivedError = resultErrorFor(data: nil, response: nil, error: requestError)
        XCTAssertEqual(receivedError as NSError?, requestError)
    }
    
    func test_client_failsOnAllInvalidRepresentationCases() {
        XCTAssertNotNil(resultErrorFor(data: nil, response: nil, error: nil))
        XCTAssertNotNil(resultErrorFor(data: nil, response: nonHTTPURLResponse(), error: nil))
        XCTAssertNotNil(resultErrorFor(data: someData(), response: nil, error: nil))
        XCTAssertNotNil(resultErrorFor(data: someData(), response: nil, error: someError()))
        XCTAssertNotNil(resultErrorFor(data: nil, response: nonHTTPURLResponse(), error: someError()))
        XCTAssertNotNil(resultErrorFor(data: nil, response: anyHTTPURLResponse(), error: someError()))
        XCTAssertNotNil(resultErrorFor(data: someData(), response: nonHTTPURLResponse(), error: someError()))
        XCTAssertNotNil(resultErrorFor(data: someData(), response: anyHTTPURLResponse(), error: someError()))
        XCTAssertNotNil(resultErrorFor(data: someData(), response: nonHTTPURLResponse(), error: nil))
    }
    
    func test_client_succeedsOnHTTPURLResponseWithData() {
        let data = someData()
        let response = anyHTTPURLResponse()
        
        let receivedValues = resultValuesFor(data: data, response: response, error: nil)
        
        XCTAssertEqual(receivedValues?.data, data)
        XCTAssertEqual(receivedValues?.response.url, response.url)
        XCTAssertEqual(receivedValues?.response.statusCode, response.statusCode)
    }
    
    func test_client_succeedsWithEmptyDataOnHTTPURLResponseWithNilData() {
        let response = anyHTTPURLResponse()
        
        let receivedValues = resultValuesFor(data: nil, response: response, error: nil)
        
        let emptyData = Data()
        XCTAssertEqual(receivedValues?.data, emptyData)
        XCTAssertEqual(receivedValues?.response.url, response.url)
        XCTAssertEqual(receivedValues?.response.statusCode, response.statusCode)
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> HTTPClient {
        return URLSessionHTTPClient()
    }
    
    private func resultValuesFor(data: Data?, response: URLResponse?, error: Error?) -> (data: Data, response: HTTPURLResponse)? {
        let result = resultFor(data: data, response: response, error: error)
        
        switch result {
        case let .success(data, response):
            return (data, response)
        default:
            XCTFail("Expected success, got \(result) instead")
            return nil
        }
    }
    
    private func resultErrorFor(data: Data?, response: URLResponse?, error: Error?) -> Error? {
        let result = resultFor(data: data, response: response, error: error)
        
        switch result {
        case let .failure(error):
            return error
        default:
            XCTFail("Expected failure, got \(result) instead")
            return nil
        }
    }
    
    private func resultFor(data: Data?, response: URLResponse?, error: Error?) -> HTTPClient.Result {
        URLProtocolStub.stub(data: data, response: response, error: error)
        let sut = makeSUT()
        let exp = expectation(description: "Wait for completion")
        
        var receivedResult: HTTPClient.Result!
        sut.executeRequest(request: someURLRequest()) { result in
            receivedResult = result
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
        return receivedResult
    }
    
    private func someData() -> Data {
        return Data("any data".utf8)
    }
    
    private func someError() -> NSError {
        return NSError(domain: "any error", code: 0)
    }
    
    private func someURLRequest() -> URLRequest {
        return URLRequest(url: URL(string: "http://any-url.com")!)
    }
    
    private func anyHTTPURLResponse() -> HTTPURLResponse {
        return HTTPURLResponse(url: someURLRequest().url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    }
    
    private func nonHTTPURLResponse() -> URLResponse {
        return URLResponse(url: someURLRequest().url!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
    }
    
    private class URLProtocolStub: URLProtocol {
        private static var stub: Stub?
        private static var requestObserver: ((URLRequest) -> Void)?
        
        private struct Stub {
            let data: Data?
            let response: URLResponse?
            let error: Error?
        }
        
        static func stub(data: Data?, response: URLResponse?, error: Error?) {
            stub = Stub(data: data, response: response, error: error)
        }
        
        static func observeRequests(observer: @escaping (URLRequest) -> Void) {
            requestObserver = observer
        }
        
        static func startInterceptingRequests() {
            URLProtocol.registerClass(URLProtocolStub.self)
        }
        
        static func stopInterceptingRequests() {
            URLProtocol.unregisterClass(URLProtocolStub.self)
            stub = nil
            requestObserver = nil
        }
        
        override class func canInit(with request: URLRequest) -> Bool {
            return true
        }
        
        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            return request
        }
        
        override func startLoading() {
            if let requestObserver = URLProtocolStub.requestObserver {
                client?.urlProtocolDidFinishLoading(self)
                return requestObserver(request)
            }
            
            if let data = URLProtocolStub.stub?.data {
                client?.urlProtocol(self, didLoad: data)
            }
            
            if let response = URLProtocolStub.stub?.response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            
            if let error = URLProtocolStub.stub?.error {
                client?.urlProtocol(self, didFailWithError: error)
            }
            
            client?.urlProtocolDidFinishLoading(self)
        }
        
        override func stopLoading() {}
    }
    

    
}
