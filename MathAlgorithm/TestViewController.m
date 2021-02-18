//
//  TestViewController.m
//  MathAlgorithm
//
//  Created by Leo on 2019/7/29.
//  Copyright © 2019 dongdonghu. All rights reserved.
//

#import "TestViewController.h"
#import "MathAlgorithm-Swift.h"
#import "Person.h"
#include <objc/runtime.h>

//求最大值 和最小值
#define MAX3(a, b, c) (a > b ? (a > c ? a : c) : (b > c ? b : c))
#define MIN1(A, B)    ( (A) > (B) ? (B) : (A) )
#define MAX1(A, B)    ( (A) > (B) ? (A) : (B) )
/* 一.
 copy将内容拷贝了一份就是深拷贝了，浅拷贝只是将指针拷贝一份，那么copy一定是深拷贝么？并不是，这里我总结了一下
 可变 对象 copy 是深拷贝，会拷贝出一份新的不可变对象
 不可变 对象copy 是浅拷贝，只拷贝指针
 
 copy得到的类型一定是不可变的；mutableCopy得到的类型一定是可变的
  使用mutable，都是深拷贝（不管是拷贝类型还是拷贝方法）；但是copy也有深拷贝（可变对象）；
 *******
 关于mutableCopy:
 copy出来会将可变对象转为不可变对象，需要copy出可变对象要用mutableCopy！
 mutableCopy都是深拷贝，并且copy出一份新的可变对象！
 也就是用mutableCopy会copy出一份新的可变对象，并且原数组修改不会对新数组有影响！
 */
/* 总结：
 1、strong和copy的引用计数器+1特性，体现在给成员变量赋值时，实际调用objc_storeStrong方法，在该方法内会做objc_retain操作。
 2、用copy修饰的属性，当使用系统的setter方法赋值时，得到的对象是不可变对象。 这一特性是因为setter内部不是直接赋值，其根本调用了reallySetProperty方法。
 3、weak引用计数器不加1，即在storeWeak中并没有objc_retain操作。 每个对象都有一个weak表，存储指向这个对象的所有weak指针。
    释放时调用clearDeallocating函数。clearDeallocating函数首先根据对象地址获取这个weak表，
    然后遍历这个数组把其中的数据设为nil，最后清理对象的记录。
 4、assign引用计数器不加1，当对象释放后，指向对象的指针会变成野指针，是因为assign内部就是直接赋值，没有任何操作
  */
/**二.
   内存缓存处理：
   [1]在显示图片之前，先检查缓存中是否有该图片（是否已经下载过）
   [2]如果缓存中有图片，那么就直接使用，不下载
   [3]如果缓存中无图片，那么再去下载，并且把下载完的图片保存到内存缓存
   */
/* SDWebImage 实现原理
   二级（内存-磁盘）缓存处理：
   [1]在显示图片之前，先检查内存缓存中是否有该图片
   [2]如果内存缓存中有图片，那么就直接使用，不下载
   [3]如果内存缓存中无图片，那么再检查是否有磁盘缓存
   [4]如果磁盘缓存中有图片，那么直接使用，还需要保存一份到内存缓存中（方便下一次）
   [5]如果磁盘缓存中无图片，那么再去下载，并且把下载完的图片保存到内存缓存和磁盘缓存
   */
/**
   三.线程 进程的关系
   1.进程 ->进程是指在系统中正在运行的一个应用程序,每个进程之间是独立的，每个进程均运行在其专用且受保护的内存空间内
   2.线程 ->1个进程要想执行任务，必须得有线程（每1个进程至少要有1条线程，称为主线程），一个进程（程序）的所有任务都在线程中执行
   3.进程和线程的比较-> .线程是CPU调用(执行任务)的最小单位。.进程是CPU分配资源的最小单位。
                    .一个进程中至少要有一个线程。.同一个进程内的线程共享进程的资源。

   4.线程的串行 -> 1个线程中任务的执行是串行的 如果要在1个线程中执行多个任务，那么只能一个一个地按顺序执行这些任务,
                也就是说，在同一时间内，1个线程只能执行1个任务
   5.多线程 ->  1个进程中可以开启多条线程，每条线程可以并行（同时）执行不同的任务,多线程技术可以提高程序的执行效率
   6.多线程原理-> 同一时间，CPU只能处理1条线程，只有1条线程在工作（执行），多线程并发（同时）执行，其实是CPU快速地在多条线程之间调度（切换），
               如果CPU调度线程的时间足够快，就造成了多线程并发执行的假象。那么如果线程非常非常多，会发生什么情况？
               CPU会在N多线程之间调度，CPU会累死，消耗大量的CPU资源，同时每条线程被调度执行的频次也会会降低（线程的执行效率降低）。
               因此我们一般只开3-5条线程。
   7.多线程优缺点-> 多线程的优点 = 能适当提高程序的执行效率能适当提高资源利用率（CPU、内存利用率）
                多线程的缺点 =  创建线程是有开销的,如果开启大量的线程，会降低程序的性能，线程越多，CPU在调度线程上的开销就越大。
                程序设计更加复杂：比如线程之间的通信、多线程的数据共享等问题。




   **/

@interface TestViewController ()
@property (nonatomic, strong) NSString *str;
@property (nonatomic, copy) NSMutableString *strCopy;
@property (nonatomic, copy) NSString *strCopy1;

@end

@implementation TestViewController
- (void)setStr:(NSString *)str {
    @synchronized(self) {
        _str = str;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    NSMutableArray *students = [@[@"小二笔"] mutableCopy];
    Person *person = [[Person alloc] init];
    person.studentArray1 = students;
    person.studentArray2 = students;
    [students addObject:@"小傻子"];
    [self testSwiftFunc];
}

- (void)someRuntime
{
    unsigned int count = 0;
    Ivar *varlist = class_copyIvarList([self class], &count);
    for (unsigned int i = 0; i < count; i++) {
        const char *varName = ivar_getName(varlist[i]);
        printf("成员变量----%s\n", varName);
    }
    Method *methodList = class_copyMethodList([self class], &count);
    for (unsigned int i = 0; i < count; i++) {
        SEL methodName = method_getName(methodList[i]);
        NSLog(@"方法-------%@", NSStringFromSelector(methodName));
    }
}

- (void)testSwiftFunc
{
    [Math testXX];
    Math *math = [[Math alloc]init];
    [math mapAndFilterAndREduce];
    [math flapAndFalpMap];
    [math foo];
}

@end
