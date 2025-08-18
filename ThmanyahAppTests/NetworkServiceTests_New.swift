import XCTest
@testable import ThmanyahApp

final class NetworkServiceTests_New: XCTestCase {
    var session: URLSession!
    var sut: NetworkService!

    override func setUp() {
        super.setUp()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: config)
        sut = NetworkService(session: session)
    }

    override func tearDown() {
        sut = nil
        session = nil
        MockURLProtocol.requestHandler = nil
        super.tearDown()
    }

    func test_request_success_decodes_HomeSectionsResponseDTO() async throws {
        let url = APIEndpoint.homeSections(page: 1).url
        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.url?.host, url.host)
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type":"application/json"])!
            return (response, TestJSON.homeSuccess)
        }

        let dto: HomeSectionsResponseDTO = try await sut.request(.homeSections(page: 1))
        XCTAssertEqual(dto.sections.count, 2)
        XCTAssertEqual(dto.pagination.totalPages, 3)
    }

    func test_request_notFound_maps_to_error() async {
        let url = APIEndpoint.homeSections(page: 1).url
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: url, statusCode: 404, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }

        do {
            let _: HomeSectionsResponseDTO = try await sut.request(.homeSections(page: 1))
            XCTFail("Expected error")
        } catch let e as NetworkError {
            XCTAssertEqual(e, .notFound)
        } catch {
            XCTFail("Unexpected error \(error)")
        }
    }

    func test_request_decoding_error_is_surfaced() async {
        let url = APIEndpoint.homeSections(page: 1).url
        MockURLProtocol.requestHandler = { _ in
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: ["Content-Type":"application/json"])!
            return (response, TestJSON.invalid)
        }

        do {
            let _: HomeSectionsResponseDTO = try await sut.request(.homeSections(page: 1))
            XCTFail("Expected decoding error")
        } catch let e as NetworkError {
            switch e {
            case .decodingError(_): XCTAssertTrue(true)
            default: XCTFail("Expected decodingError, got \(e)")
            }
        } catch { XCTFail("Unexpected error \(error)") }
    }
}
