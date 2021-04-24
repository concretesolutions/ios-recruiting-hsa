import UIKit
import Foundation

class UIWindowMock: UIWindow {
  var makesKeyAndVisible = false
  
  open override func makeKeyAndVisible(){
    makesKeyAndVisible = true
  }
}
