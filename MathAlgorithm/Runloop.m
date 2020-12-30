//
//  Runloop.m
//  MathAlgorithm
//
//  Created by Leo on 2020/4/9.
//  Copyright © 2020 dongdonghu. All rights reserved.
//

#import "Runloop.h"

@implementation Runloop
/*
1.Runloop 和线程的关系？
  一个线程对应一个 Runloop ,主线程的默认就有了 Runloop。子线程的 Runloop 以懒加载的形式创建
  Runloop 存储在一个全局的可变字典里，线程是 key ，Runloop 是 value
2.RunLoop的运行模式
  RunLoop的运行模式共有5种
3.runloop内部逻辑？
  实际上 RunLoop 就是这样一个函数，其内部是一个 do-while 循环。当你调用 CFRunLoopRun() 时，线程就会一直停留在这个循环里；直到超时或被手动停止，该函数才会返回
  
5.GCD 在Runloop中的使用？
  GCD由子线程返回到主线程,只有在这种情况下才会触发RunLoop。会触发 RunLoop的 Source 1 事件
  
6.AFNetworking 中如何运用 Runloop?
 AFURLConnectionOperation 这个类是基于NSURLConnection 构建的，其希望能在后台线程接收Delegate回调。为此AFNetworking 单独创建了一个线程，并在这个线程中启动了一个 RunLoop：
 
7.PerformSelector 的实现原理？
  当调用 NSObject 的 performSelecter:afterDelay: 后，实际上其内部会创建一个 Timer 并添加到当前线程的 RunLoop 中。所以如果当前线程没有 RunLoop，则这个方法会失效。
 当调用 performSelector:onThread: 时，实际上其会创建一个 Timer 加到对应的线程去，同样的，如果对应线程没有 RunLoop 该方法也会失效。
8.PerformSelector:afterDelay:这个方法在子线程中是否起作用？
 不起作用，子线程默认没有 Runloop，也就没有 Timer。可以使用 GCD的dispatch_after来实现
 
9.事件响应的过程？
10.手势识别的过程？
11.CADispalyTimer和Timer哪个更精确
  iOS设备的屏幕刷新频率是固定的，CADisplayLink在正常情况下会在每次刷新结束都被调用，精确度相当高。
  NSTimer的精确度就显得低了点，比如NSTimer的触发时间到的时候，runloop如果在阻塞状态，触发时间就会推迟到下一个runloop周期。并且 NSTimer新增了tolerance属性，让用户可以设置可以容忍的触发的时间的延迟范围
  CADisplayLink使用场合相对专一，适合做UI的不停重绘，比如自定义动画引擎或者视频播放的渲染。
  NSTimer的使用范围要广泛的多，各种需要单次或者循环定时处理的任务都可以使用。在UI相关的动画或者显示内容使用 CADisplayLink比起用NSTimer的好处就是我们不需要在格外关心屏幕的刷新频率了，因为它本身就是跟屏幕刷新同步的
  
  
11.下场景是需要启动RunLoop的：
使用NSPort或者自定义输入源与其它线程通信。
在线程上使用计时器。
在一个Cocoa应用中使用performSelector相关方法。
使线程常驻，在该线程定期执行任务。


*/
+(void)testRunloop
{
  NSArray * arr= [NSArray arrayWithObjects:@"1",@"3", nil];
  [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
       NSLog(@"11");
   }];
   
}
-(void)testPool
{
   @autoreleasepool {
     @autoreleasepool {
     
     }
   }
   @autoreleasepool {
     
     }
}
@end
