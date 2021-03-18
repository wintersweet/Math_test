//
//  Spinlock.swift
//  MathAlgorithm
//
//  Created by Leo on 2021/3/16.
//  Copyright © 2021 dongdonghu. All rights reserved.
//
// 实现一个自旋锁
import Foundation
//如果共享数据已经有其他线程加锁了，线程会以死循环的方式等待锁，一旦被访问的资源被解锁，则等待资源的线程会立即执
struct Spinlock {
    var flag = 0
    mutating func lock() {
        while setFlag() != 0 {
        }
    }

    mutating func unlock() {
        flag = 0
    }

    private mutating func setFlag() -> Int {
        if flag == 0 {
            flag = 1
            return 0
        } else {
            return 1
        }
    }
}

class TestLock: NSObject {
    var spinlock: Spinlock?
    var num = 0
    @objc func inits() {
        spinlock = Spinlock(flag: 0)
        
    }
    @objc func start(){
      DispatchQueue.global().async {
        self.action("111")
      }
        DispatchQueue.global().async {
        self.action("222")
      }
    }

    @objc  func action(_ tag:String) {
        while true {
            spinlock?.lock()
            if num >= 50 {
                spinlock?.unlock()
                print("解锁了1111  \(tag)")
                break
            }
            num += 1
            print("tag==\(tag)->\(num)----\(Thread.current)")
            spinlock?.unlock()
        }
    }
}
