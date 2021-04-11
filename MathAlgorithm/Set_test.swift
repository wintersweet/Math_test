//
//  Set.swift
//  MathAlgorithm
//
//  Created by Leo on 2019/11/13.
//  Copyright © 2019 dongdonghu. All rights reserved.
//

import UIKit

class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}
//弱引用
class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}
//无主引用
class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}
//闭包的循环强引用
class HTMLElement {

    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
   

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit {
        print("\(name) is being deinitialized")
    }
}
//////////***********////////
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var wdith = 0.0,height = 0.0
}
struct Rect {
    var orgin = Point()
    var size = Size()
    var center :Point {
      get{
         let centerX = orgin.x + size.wdith/2
         let centerY = orgin.y + size.height/2
         return Point(x: centerX, y: centerY)
      }
      set{
        orgin.x = newValue.x - size.wdith/2
        orgin.y = newValue.y - size.height/2
      }
    }
}
class Set_test {
   var john : Person?
   var apart : Apartment?
   init() {
       john = Person(name: "John")
       apart = Apartment(unit: "A")
       john?.apartment = apart
       apart?.tenant = john
       john = nil
       apart = nil
   }
   init(_city:String) {
    
   }
   
   func sortArray(_ array:Array<Any>) {
       let user1 = User(name:"小傻逼",age:10)
       let user2 = User(name:"小逗逼",age:10)
       let users:Set = [user1,user2]
       _ = users.filter({
          $0.age >= 20
       })
       
    }
    //MARK: Set 独有的方法有哪些？
    func setPrivateFunction(){
        let setA: Set<Int> = [1,2,3,4,4] // 顺序可能不一致, 同一个元素
        let setB: Set<Int> = [1,3,5,7,9]
        // 取并集 A | B
        let setUnion = setA.union(setB) // {1, 2, 3, 4, 5, 7, 9}
        //去交集 A& B
        let setINtersect = setA.intersection(setB)// {1, 3}
        _ = setA.filter{ $0/2 == 0}
        // 取差集 A - B
        let setRevers = setA.subtracting(setB)
        // 取对称差集, A XOR B = A - B | B - A
        let setXor = setA.symmetricDifference(setB) //{2, 4, 5, 7, 9}
        print("setUnion==\(setUnion)\n setINtersect=[\(setINtersect),\n setRevers==\(setRevers),\n setXor==\(setXor)")
        
    }
}

struct  User {
    var name :String
    var age :Int
    func testInit() {
        guard 1 > 2 else {
           print("1 小于 2")
           return
       }
    }
   
    
}
extension User:Hashable{
    var hashValue: Int {
        return 1
    }
    
   
    
   //由于Hashable协议又符合Equatable协议，所以还要提供一个"是否相等"运算符(==)的实现
   static func ==(lhs: User, rhs: User) -> Bool {
       return lhs.name == rhs.name && lhs.age == rhs.age
   }
}
