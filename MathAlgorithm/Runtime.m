//
//  Runtime.m
//  MathAlgorithm
//
//  Created by Leo on 2020/4/9.
//  Copyright © 2020 dongdonghu. All rights reserved.
//

#import "Runtime.h"

@implementation Runtime
/*
 IMP、SEL、Method的区别和使用场景
 SEL : 方法选择器,SEL是函数objc_msgSend第二个参数的数据类型，表示方法选择器
 Method : 就是一个指向objc_method结构体指针，它存储了方法名(method_name)、方法类型(method_types)和一个指向方法实现的函数指针(method_imp)等信息
 IMP : 本质上就是一个函数指针，指向方法的实现的地址,当你向某个对象发送一条信息，可以由这个函数指针来指定方法的实现，它最终就会执行那段代码，这样可以绕开消息传递阶段而去执行另一个方法实现
 */
/*
#1.Category 的实现原理？
Category：实际上是Category_t的结构体，在运行时，新添加的方法，都被以倒序插入到原有方法列表的最前面，所以不同的Category，添加了同一个方法，执行的实际上是最后一个。
 Category 在刚刚编译完的时候，和原来的类是分开的，只有在程序运行起来后，通过 Runtime ，Category 和原来的类才会合并到一起
#2.isa指针的理解，对象的isa指针指向哪里？isa指针有哪两种类型？
isa 等价于 is kind of
 实例对象的 isa 指向类对象
 类对象的 isa 指向元类对象
 元类对象的 isa 指向元类的基类
isa 有两种类型
 纯指针，指向内存地址
 NON_POINTER_ISA，除了内存地址，还存有一些其他信息
# 3.Objective-C 如何实现多重继承？
 Object-c的类没有多继承,只支持单继承,如果要实现多继承的话，可使用如下几种方式间接实现
 通过组合实现：A和B组合，作为C类的组件，
 通过协议实现：C类实现A和B类的协议方法
 消息转发实现：forwardInvocation:方法

# 5.讲一下OC的消息机制
 OC中的方法调用其实都是转成了objc_msgSend函数的调用，给receiver（方法调用者）发送了一条消息（selector方法名）
 objc_msgSend底层有3大阶段，消息发送（当前类、父类中查找）、动态方法解析、消息转发
 # 6.runtime具体应用
 利用关联对象（AssociatedObject）给分类添加属性

 交换方法实现（交换系统的方法）
 利用消息转发机制解决方法找不到的异常问题
 KVC 字典转模型
 8.简述下Objective-C中调用方法的过程
  Objective-C是动态语言，每个方法在运行时会被动态转为消息发送
  objc在向一个对象发送消息时，runtime库会根据对象的isa指针找到该对象实际所属的类
  然后在该类中的方法列表以及其父类方法列表中寻找方法运行
  如果，在最顶层的父类（一般也就NSObject）中依然找不到相应的方法时，程序在运行时会挂掉并抛出异常unrecognized selector sent to XXX
  但是在这之前，objc的运行时会给出三次拯救程序崩溃的机会，
  这三次拯救程序奔溃的说明见问题《什么时候会报unrecognized selector的异常》中的说明
9.load和initialize的区别
  两者都会自动调用父类的，不需要super操作，且仅会调用一次
  load和initialize方法都会在实例化对象之前调用，以main函数为分水岭，前者在main函数之前调用，
  后者在之后调用。这两个方法会被自动调用，不能手动调用它们
  load方法通常用来进行Method Swizzle，initialize方法一般用于初始化全局变量或静态变量
10.怎么理解Objective-C是动态运行时语言
  主要是将数据类型的确定由编译时,推迟到了运行时。这个问题其实浅涉及到两个概念,运行时和多态。
  运行时机制:使我们直到运行时才去决定一个对象的类别,以及调用该类别对象指定方法
  多态:不同对象以自己的方式响应相同的消息的能力叫做多态
 #
 */
@end
