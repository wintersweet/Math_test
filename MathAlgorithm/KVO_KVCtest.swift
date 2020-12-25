//
//  KVO_KVCtest.swift
//  MathAlgorithm
//
//  Created by Leo on 2019/12/4.
//  Copyright © 2019 dongdonghu. All rights reserved.
//

import UIKit

protocol CustomStringConvertible {
  var description: String { get }
}

enum Trade: CustomStringConvertible {
   case Buy, Sell
   var description: String {
       switch self {
        case .Buy: return "We're buying something"
        case .Sell: return "We're selling something"
       }
   }
}

enum Account {
  case Empty
  case Funds(remaining: Int)
 
  var remainingFunds: Int {
    switch self {
    case .Empty: return 0
    case .Funds(let remaining): return remaining
    }
  }
}
class KVO_KVCtest: NSObject {

}
class KVOClass:NSObject {
    @objc dynamic var someValue: String = "123"
    var someOtherValue: String = "abc"
}
class ObserverClass: NSObject {
   @objc func observer() {
        let kvo = KVOClass()
        kvo.addObserver(self, forKeyPath: "someValue", options: .new, context: nil)
        kvo.addObserver(self, forKeyPath: "someOtherValue", options: .new, context: nil)
        kvo.someValue = "456"
        kvo.someOtherValue = "def"
        kvo.removeObserver(self, forKeyPath: "someValue")
        kvo.removeObserver(self, forKeyPath: "someOtherValue")
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print("\(keyPath!) change to \(change![.newKey] as! String)")
    }
}
