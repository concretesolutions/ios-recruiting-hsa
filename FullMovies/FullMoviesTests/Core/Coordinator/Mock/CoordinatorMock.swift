import Foundation
@testable import FullMovies

class CoordinatorMock: Coordinator {
  
  var hasStarted = false
  
  func start() {
    hasStarted = true
  }
}
