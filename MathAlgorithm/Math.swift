//
//  Math.swift
//  MathAlgorithm
//
//  Created by Leo on 2019/7/25.
//  Copyright © 2019 dongdonghu. All rights reserved.
//

import UIKit
/*
斐波那契数列是一系列数字，除了第一个和第二个数字之外，任何数字都是前两个数字之和：
0、1、1、2、3、5、8、13、21......
数列中的第一个斐波那契数的值为0，第四个斐波那契数为2，第n个斐波那契数的值可以通过下述公式计算：
fib(n) = fib(n-1) + fib(n-2)
*/
class Math:NSObject {
  

     /*
     *  prev与curr分别代表f(n-1)和f(n)
     *  计算prev+curr赋值给curr，curr赋值给prev，经过n次赋值后可以算出结果
     */
    //解决斐波那契数列问题的最优算法，计算出fib(n)只需要n-1次循环即可
    func fib(_ n: UInt) -> UInt {
        var (prev, curr) = (0, 1)
        for _ in 0..<n {
            (curr, prev) = (curr + prev, curr)
        }
        return UInt(curr)
    }
    /*
     *  斐波那契数列的数字都是基于fib(0)和fib(1)计算出来的，所以在递归方法里面，只要计算出fib(0)和fib(1)，其他情况调用递归即可。
     */
    func fib1(_ n: UInt) -> UInt {
        if n < 2 {
            return n
        }
        return fib1(n-1) + fib1(n-2)
    }
    //MARK: 实现一个 min 函数，返回两个元素较小的元素
    func min<T :Comparable>(_ a:T, _ b: T) ->T{
        return a < b ? a:b
    }
    //MARK: Set 独有的方法有哪些？
    func setPrivateFunction(){
        let setA: Set<Int> = [1,2,3,4,4] // 顺序可能不一致, 同一个元素
        let setB: Set<Int> = [1,3,5,7,9]
        // 取并集 A | B
        let setUnion = setA.union(setB) // {1, 2, 3, 4, 5, 7, 9}
        //取交集 A & B
        let setINtersect = setA.intersection(setB)// {1, 3}
        _ = setA.filter{ $0/2 == 0}
        // 取差集 A - B
        let setRevers = setA.subtracting(setB)
        // 取对称差集, A XOR B = A - B | B - A
        let setXor = setA.symmetricDifference(setB) //{2, 4, 5, 7, 9}
        
        print("setUnion==\(setUnion)\n setINtersect=[\(setINtersect),\n setRevers==\(setRevers),\n setXor==\(setXor)")
        
    }
    //MARK: map、filter、reduce 的作用
@objc public func mapAndFilterAndREduce(){
        //map 用于映射, 可以将一个列表转换为另一个列表
        let a = [1, 2, 3]
        let b = a.map{"\($0+1)"}// 数字数组转换为字符串数组
        //filter 用于过滤, 可以筛选出想要的元素
        let c =  a.filter{$0 % 2 == 0} // 筛选偶数
        //reduce 合并
        let d =  a.reduce(""){$0 + "\($1)"}// 转换为字符串并拼接
        let e = a.reduce("") { (x, y) in
            x + "\(y)"
        }
        print(a,b,c,d)

    }
    //MARK: map 与 flatmap 的区别
@objc public  func flapAndFalpMap(){
        let a = ["1", "@", "2", "3", "a"]
        ///1...flatmap 会丢掉那些返回值为 nil 的值
        let b = 0 //a.compactMap{Int($0)}
        // [1, 2, 3]
        let c = a.map{Int($0) ?? -1}
        //[Optional(1), nil, Optional(2), Optional(3), nil]
        print(a,b,c)
        
        //2... flapmap 返回的对象则是一个与自己元素类型相同的数组
        let  aa = [[1], [2, 3], [4, 5, 6]]
        // [[1], [2, 3], [4, 5, 6]]
        let bb = aa.flatMap(someFunc)
        let cc = aa.flatMap { (array)  in
            return array
        }
        _ =  aa.map(someFunc)
    }
    func someFunc(_ array:[Int]) -> [Int] {
        return array
    }
@objc public class func testXX(){
      var mutableArray = [1,2,3]
      for _ in mutableArray {
         mutableArray.removeLast()
      }
      let countDown = CountDown(count: 5)
      print("begin for in 1")
      for c in countDown {
          print(c)
      }
      print("end for in 1")
      print("begin for in 2")
      for c in countDown {
          print(c)
      }
      print("end for in 2")
      ObserverClass().observer()
  }
 @objc func foo() {
       defer {
         print("finally")
       }
       do {
         throw NSError()
         print("impossible")
       } catch {
         print("handle error")
       }
     }
  @objc func foo1() {
        do {
        defer {
           print("finally")
         }
          throw NSError()
          print("impossible")
        } catch {
          print("handle error")
        }
      }
    
}
class CountDown: Sequence,IteratorProtocol {
    var count :Int
    init(count:Int) {
        self.count = count
    }
    func next() -> Int?{
         if count == 0 {
            return nil
         }else{
           defer {count -= 1}
           return count
         }
     }
}
//MARK: 1.什么是 copy on write时候写时复制, 指的是 swift 中的值类型, 并不会在一开始赋值的时候就去复制,
//只有在需要修改的时候, 才去复制.
//这里有详细的说明 http://www.jianshu.com/p/7e8ba0659646
//MARK: 2.如何获取当前代码的函数名和行号
/*
#file 用于获取当前文件文件名
#line 用于获取当前行号
#column 用于获取当前列编号
#function 用于获取当前函数名
以上这些都是特殊的字面量, 多用于调试输出日志*/
func logFunctionName(string: String = #function) {
    print(string)
}
func myFunction() {
    logFunctionName()
}
/*
1、class 和 struct 的区别
   1. 内存管理方式不一样， 类->引用类型， 分配在堆上。 结构体->值类型，分配在栈上。
   2. 类, 有析构。 结构体不能有析构， playground中测试直接卡死。
   3. 结构体构造函数, 会自动生成带参数的构造器。类不会对有初始化赋值的属性, 生成带参数的构造器。
   4. 类有继承特性，结构体没有继承特性，自然也不存在对成员属性和成员方法, 类属性和类方法的重载
 *******
2、不通过继承，代码复用（共享）的方式有哪些 (扩展，全局函数)
3、Set 独有的方法有哪些？
4、实现一个 min 函数，返回两个元素较小的元素
5、map、filter、reduce 的作用
6、map 与 flatmap 的区别
7、什么是 copy on write
8、如何获取当前代码的函数名和行号
9、如何声明一个只能被类 conform 的 protocol
10、guard 使用场景
11、defer 使用场景
12、String 与 NSString 的关系与区别 (String 是结构体, 值类型, NSString 是类, 引用类型.)
13、怎么获取一个 String 的长度
14、如何截取 String 的某段字符串
15、throws 和 rethrows 的用法与作用
16、try？ 和 try！是什么意思
17、associatedtype 的作用
18、什么时候使用 final (final 用于限制继承和重写)
19、public 和 open 的区别
20、声明一个只有一个参数没有返回值闭包的别名
22、Self 的使用场景
23、dynamic 的作用
24、什么时候使用 @objc
25、Optional（可选型） 是用什么实现的  (Optional 是一个泛型枚举)
26、如何自定义下标获取
27、?? 的作用
28、lazy 的作用
29、一个类型表示选项，可以同时表示有几个选项选中（类似 UIViewAnimationOptions ），用什么类型表示
30、inout 的作用
31、Error 如果要兼容 NSError 需要做什么操作
32、下面的代码都用了哪些语法糖
[1, 2, 3].map{ $0 * 2 }
33、什么是高阶函数
34、如何解决引用循环
35、下面的代码会不会崩溃，说出原因
 var mutableArray = [1,2,3]
 for _ in mutableArray {
 mutableArray.removeLast()
 }
 36、给集合中元素是字符串的类型增加一个扩展方法，应该怎么声明
 extension Array where Element == String {
     var isStringElement:Bool {
         return true
     }
 }
 37、定义静态方法时关键字 static 和 class 有什么区别  static 定义的方法不可以被子类继承, class 则可以

 高级
 38、、一个 Sequence 的索引是不是一定从 0 开始？ (不一定, 两个 for in 并不能保证都是从 0 开始, 且输出结果一致,CountDown class)
 39、数组都实现了哪些协议 (1.MutableCollection, 实现了可修改的数组, 2.ExpressibleByArrayLiteral, 实现了数组可以从[1, 2, 3] 这种字面值初始化的能力)
 40、如何自定义模式匹配
 41、autoclosure 的作用 (自动闭包, 会自动将某一个表达式封装为闭包)
 42、编译选项 whole module optmization 优化了什么
 43、下面代码中 mutating 的作用是什么
 struct Person {
          var name: String {
           mutating get {
          return store
         }
       }
   }
 44、如何让自定义对象支持字面量初始化
 45、dynamic framework 和 static framework 的区别是什么
 46、为什么数组索引越界会崩溃，而字典用下标取值时 key 没有对应值的话返回的是 nil 不会崩溃。
 47、一个函数的参数类型只要是数字（Int、Float）都可以，要怎么表示。
*/
