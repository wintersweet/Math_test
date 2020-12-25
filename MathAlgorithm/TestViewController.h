//
//  TestViewController.h
//  MathAlgorithm
//
//  Created by Leo on 2019/7/29.
//  Copyright © 2019 dongdonghu. All rights reserved.
//

#import <UIKit/UIKit.h>
//这里介绍一下static define、const、extern的用法、优劣以及要注意的地方。
/* static：
   静态变量
   define:预处理指令，在编译之前替换宏值
   宏define是定义一个变量，没有类型信息。define定义的常量在内存中有若干个拷贝。
   define可以定义常量，但是建议不要这么做，因为用define定以了的常量，其值可以改变
   const:
   const修饰的变量是不可变.const定义的常量在程序运行过程中只有一份拷贝
   extern：
   extern用来修饰全局变量。extern用在变量声明中常常有这样一个作用，
   你在*.c文件中声明了一个全局的变量，这个全局的变量如果要被引用，就放在*.h中并用extern来声明。
*/
//下面的例子：const定义的右边的是不可以改变的，也就是说const修饰的是它右边的部分。
static const int kCount = 1; //此处定义的kCount后面都不能改变值，如果改变，则报错

static const NSString *kStr1 = @"alun1";//此处定义的kStr1可修改其值，但是修改过后他们的内存地址一样。
//static NSString const *kStr1 = @"alun1";//跟上面的定义写法不同，但是结果一样

static NSString* const kStr2 = @"alun2";//此处定义的kStr2不能改变，否则会发生错误

@interface TestViewController : UIViewController

@end



