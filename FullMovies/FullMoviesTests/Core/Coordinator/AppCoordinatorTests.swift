import Foundation
import XCTest
@testable import FullMovies

class AppCoordinatorTests: TestCase {
    
    var sut : AppCoordinator!
    let windowMock = UIWindowMock()
    let tabBarVCMock = TabBarControllerMock()
    
    override func setUp() {
        sut = AppCoordinator(window: windowMock, tabBarController: tabBarVCMock)
    }
    
    func testInitCoordinator(){
        XCTAssertEqual(windowMock.makesKeyAndVisible, true)
        XCTAssertEqual(windowMock.rootViewController, tabBarVCMock)
    }
    
    func testStarterCoordinator(){        
        let coordinatorMock = CoordinatorMock()
        sut.starterCoordinator = coordinatorMock
        sut.start()
        XCTAssertEqual(coordinatorMock.hasStarted, true)
    }
}
