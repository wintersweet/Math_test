//
//  SomeReview.c
//  MathAlgorithm
//
//  Created by Leo on 2019/7/25.
//  Copyright © 2019 dongdonghu. All rights reserved.
//

#include "SomeReview.h"
/*
1.__block 修饰符作用？
•    _block可以用于解决block内部无法修改auto变量值的问题
•    __block不能修饰全局变量、静态变量（static）
•    编译器会将__block变量包装成一个对象
2.：block可以向NSMutableArray添加元素么？
可以，因为是addObject是使用NSMutableArray变量，而不是通过指针改变NSMutableArray，如果是arr = nil，这就是改变了NSMutableArray变量，会报错
3.block的属性修饰词为什么是copy？
block一旦没有进行copy操作，就不会在堆上
block在堆上，程序员就可以对block做内存管理等操作，可以控制block的生命周期
4.当block被copy到堆时，对__block修饰的变量做了什么？
会调用block内部的copy函数，copy函数内部会调用_Block_object_assign函数 ，_Block_object_assign函数会对__block变量形成强引用（retain）
5.当block从堆中移除时，对__block修饰的变量做了什么？
会调用block内部的dispose函数，dispose函数内部会调用_Block_object_dispose函数，_Block_object_dispose函数会自动释放引用的__block变量（release）

*/
