//
//  HeadNews.m
//  MathAlgorithm
//
//  Created by Leo on 2020/12/25.
//  Copyright © 2020 dongdonghu. All rights reserved.
//

#import "HeadNews.h"

@implementation HeadNews
//头条的面试
/**

1、如何高效的切圆角？

切圆角共有以下三种方案：

cornerRadius + masksToBounds：适用于单个视图或视图不在列表上且量级较小的情况，会导致离屏渲染。
CAShapeLayer+UIBezierPath：会导致离屏渲染，性能消耗严重，不推荐使用。
Core Graphics：不会导致离屏渲染，推荐使用。
2、什么是隐式动画和显式动画？

隐式动画指的是改变属性值而产生的默认的过渡动画（如background、cornerRadius等），不需要初始化任何类，系统自己处理的动画属性；显式动画是指自己创建一个动画对象并附加到layer上，如 CAAnimation、CABasicAnimation、CAKeyframeAnimation。

3、UIView 和 CALayer 的区别？

UIView 是 CALayer 的 delegate，UIView 可以响应事件，而 CALayer 则不能。

4、离屏渲染？

iOS 在不进行预合成的情况下不会直接在屏幕上绘制该图层，这意味着 CPU 和 GPU 必须先准备好屏幕外上下文，然后才能在屏幕上渲染，这会造成更多时间时间和更多的内存的消耗。

5、Objective - C 是否支持方法重载(overloading)？

不支持。方法重载(overloading)：允许创建多项名称相同但输入输出类型或个数不同的方法。

// 这两个方法名字是不一样的，虽然都是writeToFile开头
-(void) writeToFile:(NSString *)path fromInt:(int)anInt;
-(void) writeToFile:(NSString *)path fromString:(NSString *)aString;
1
2
3
注：Swift 是支持的。

func testFunc() {}
func testFunc(num: Int) {}
1
2
6、KVC 的应用场景及注意事项

KVC（key-Value coding） 键值编码，指iOS开发中，可以允许开发者通过Key名直接访问对象的属性，或者给对象的属性赋值。不需要调用明确的存取方法，这样就可以在运行时动态访问和修改对象的属性，而不是在编译时确定。

它的四个主要方法：

- (nullable id)valueForKey:(NSString *)key;                          //直接通过Key来取值
- (void)setValue:(nullable id)value forKey:(NSString *)key;          //通过Key来设值
- (nullable id)valueForKeyPath:(NSString *)keyPath;                  //通过KeyPath来取值
- (void)setValue:(nullable id)value forKeyPath:(NSString *)keyPath;  //通过KeyPath来设值
1
2
3
4
应用场景：

动态取值和设值
访问和改变私有变量
修改控件的内部属性
注意事项：

key 不要传 nil，会导致崩溃，可以通过重写setNilValueForKey:来避免。
传入不存在的 key 也会导致崩溃，可以通过重写valueForUndefinedKey:来避免。
7、如何异步下载多张小图最后合成一张大图？

//使用Dispatch Group追加block到Global Group Queue,这些block如果全部执行完毕，就会执行Main Dispatch Queue中的结束处理的block。
//dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//dispatch_group_t group = dispatch_group_create();
//dispatch_group_async(group, queue, ^{ /*加载图片1 */ });
//dispatch_group_async(group, queue, ^{ /*加载图片2 */ });
//dispatch_group_async(group, queue, ^{ /*加载图片3 */ });
//dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        // 合并图片
//});
/*
8、NSTimer 有什么注意事项？在 dealloc 中调用 [timer invalidate];会避免循环引用吗？
时间延后。如果 timer 处于耗时较长的 runloop 中，或者当前 runloop 处于不监视 timer 的 mode 时（如 scrollView 滑动时）。它在下次 runloop 才会触发，所以可能会导致比预期时间要晚。
循环引用。target 强引用 timer，timer 强引用 target。
时间延后
使用 dispatch_source_t 来提高时间精度。
dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
if (timer) {
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC), interval * NSEC_PER_SEC, (1ull * NSEC_PER_SEC) / 10);
    dispatch_source_set_event_handler(timer, block);
    dispatch_resume(timer);

循环引用的问题
在 dealloc 中调用 [timer invalidate];不会避免循环引用。因为 timer 会对 target 进行强引用，所以在 timer 没被释放之前，根本不会走 target 的 dealloc 方法。

可以通过以下几种方法来避免：
如果 iOS 10 及以上，可以使用init(timeInterval:repeats:block:)。target 不再强引用 timer。记得在 dealloc 中调用 [timer invalidate];，否则会造成内存泄漏。
timer = Timer(timeInterval: 1.0, repeats: true, block: { [weak self] (timer) in
    self?.timerFunc()
})
1
2
3
使用中间件的方式来避免循环引用。
// 定义
@implementation WeakTimerTarget
{
    __weak target;
    SEL selector;
}

- (void)timerDidFire:(NSTimer *)timer {
    if(target) {
        [target performSelector:selector withObject:timer];
    } else{
        [timer invalidate];
    }
}
@end

// 使用
WeakTimerTarget *target = [[WeakTimerTarget alloc] initWithTarget:self selector:@selector(tick)];
timer = [NSTimer scheduledTimerWithTimeInterval:30.0 target:target selector:@selector(timerDidFire:) ...];
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
9、对 property 的理解

@property = ivar + getter + setter;
1
10、Notification 的注意事项

在哪个线程发送通知，就在哪个线程接受通知。

11、Runloop的理解

一般来讲，一个线程一次只能执行一个任务，执行完成后线程就会退出。如果我们需要一个机制，让线程能随时处理事件但并不退出，通常的代码逻辑 是这样的：

function loop() {
    initialize();
    do {
        var message = get_next_message();
        process_message(message);
    } while (message != quit);
}
1
2
3
4
5
6
7
12、对 OC 中 Class 的源码理解？其中 cache 的理解？

Class 的底层用 struct 实现，源码如下：

struct _class_t {
    struct _class_t *isa;
    struct _class_t *superclass;
    void *cache;
    void *vtable;
    struct _class_ro_t *ro;
};
1
2
3
4
5
6
7
Cache用于缓存最近使用的方法。一个类只有一部分方法是常用的，每次调用一个方法之后，这个方法就被缓存到cache中，下次调用时 runtime 会先在 cache 中查找，如果 cache 中没有，才会去 methodList 中查找。以此提升性能。

13、项目优化做了哪些方面？

删除无用资源文件及代码
在合适的地方加缓存
耗时长的代码异步执行
14、如何一劳永逸的检测包的裂变（检测包的大小）？

这个不知道，希望了解的朋友可以在评论区指出来。

15、实现一个判断 IP 地址是否合法的方法

func isIPAddress(str: String) -> Bool {
    guard !str.isEmpty else { return false }
    var isIPAddress = false
    let coms = str.components(separatedBy: ".")
    for com in coms {
        if let intCom = Int(com), intCom >= 0, intCom <= 255 {
            isIPAddress = true
        } else {
            isIPAddress = false
            return isIPAddress
        }
    }
    return isIPAddress
}

 */

@end
