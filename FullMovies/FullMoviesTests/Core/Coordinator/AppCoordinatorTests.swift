import Foundation
import XCTest
@testable import FullMovies

class AppCoordinatorTests: TestCase {
    
    var sut : AppCoordinator!
    let windowMock = UIWindowMock()
    let navigationMock = NavigationControllerMock()
    
    override func setUp() {
        sut = AppCoordinator(window: windowMock, navigationController: navigationMock)
    }
    
    func testInitCoordinator(){
        XCTAssertEqual(windowMock.makesKeyAndVisible, true)
        XCTAssertEqual(windowMock.rootViewController, navigationMock)
    }
    
    func testStarterCoordinator(){
        
        let coordinatorMock = CoordinatorMock()
        sut.starterCoordinator = coordinatorMock
        sut.start()
        XCTAssertEqual(coordinatorMock.hasStarted, true)
    }
}
