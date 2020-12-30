//
//  Block.m
//  MathAlgorithm
//
//  Created by Leo on 2020/12/30.
//  Copyright © 2020 dongdonghu. All rights reserved.
//

#import "Block.h"

@implementation Block

/*
Q1.什么是Block，Block的本质是什么？
  block本质上也是一个OC对象，它内部也有个isa指针
  block是封装了函数调用以及函数调用环境的OC对象
  block是封装函数及其上下文的OC对象
Q2.在ARC环境下，编译器会根据情况自动将栈上的block复制到堆上的几种情况？
  1.block作为函数返回值时
  2.将block赋值给__strong指针时
  3.block作为Cocoa API中方法名含有usingBlock的方法参数时
  4.block作为GCD API的方法参数时

Q3：当block内部访问了对象类型的auto变量时，是否会强引用？
  栈block
  a) 如果block是在栈上，将不会对auto变量产生强引用
  b) 栈上的block随时会被销毁，也没必要去强引用其他对象

  堆block
  1.如果block被拷贝到堆上：
  a) 会调用block内部的copy函数
  b) copy函数内部会调用_Block_object_assign函数
  c) _Block_object_assign函数会根据auto变量的修饰符（__strong、__weak、__unsafe_unretained）做出相应的操作，
      形成强引用（retain）或者弱引用
  2.如果block从堆上移除
  a) 会调用block内部的dispose函数
  b) dispose函数内部会调用_Block_object_dispose函数
  c) _Block_object_dispose函数会自动释放引用的auto变量（release）

  如果block在栈空间，不管外部变量是强引用还是弱引用，block都会弱引用访问对象
  如果block在堆空间，如果外部强引用，block内部也是强引用；如果外部弱引用，block内部也是弱引用
/////  _block修饰符
Q：block在修改NSMutableArray，需不需要添加__block？
  :不需要。
  
Q：为什么block对auto和static变量捕获有差异？
   auto自动变量可能会销毁的，内存可能会消失，不采用指针访问；static变量一直保存在内存中，指针访问即可
Q：block对全局变量的捕获方式是？  为什么局部变量需要捕获？
   block不需要对全局变量捕获，都是直接采用取值的.   考虑作用域的问题，需要跨函数访问，就需要捕获


*/

@end
