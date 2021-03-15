//
//  GCD.m
//  MathAlgorithm
//
//  Created by Leo on 2020/4/9.
//  Copyright © 2020 dongdonghu. All rights reserved.
//

#import "GCD.h"
@interface GCD ()

@end

@implementation GCD
// 串行队列（Serial Dispatch Queue
// 并发队列（Concurrent Dispatch Queue）
+ (instancetype)shareInstance {
    static GCD *_shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_shareInstance == nil) {
            _shareInstance = [[self alloc] init];
        }
    });
    return _shareInstance;
}

- (void)gcdGroup1 {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
    });
    dispatch_group_async(group, queue, ^{
    });
    dispatch_group_async(group, queue, ^{
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
    });
}

- (void)gcdgroup2 {
    dispatch_group_t group =  dispatch_group_create();
    dispatch_group_enter(group);

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_group_leave(group);
    });

    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
    });
}

- (void)timer {
    //  时间延后 使用 dispatch_source_t 来提高时间精度。
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    if (timer) {
        dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), 1 * NSEC_PER_SEC, (1ull * NSEC_PER_SEC) / 10);
        dispatch_source_set_event_handler(timer, ^{
            NSLog(@"延时打印了");
        });
        dispatch_resume(timer);
    }

    NSTimer *tiemr = [[NSTimer alloc]initWithFireDate:[NSDate date] interval:1 repeats:YES block:^(NSTimer *_Nonnull timer) {
    }];
}

//6.多个网络请求完成后执行下一步
//1.使用GCD的dispatch_group_t
//2.使用GCD的信号量dispatch_semaphore_t
- (void)testGCD_dispatch_semaphore_t
{
    __block NSInteger count = 0;
    NSString *str = @"";
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);

    for (int i = 0; i < 10; i++) {
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {
            count++;
            if (count == 10) {
                dispatch_semaphore_signal(sem);
                count = 0;
            }
        }];
        [task resume];
    }
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"end");
    });
}

//7.多个网络请求顺序执行后执行下一步
//上个例子中的  dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER); 放到for 循环里面
//8.异步操作两组数据时, 执行完第一组之后, 才能执行第二组
- (void)test8 {
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"第一次任务的主线程为: %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"第二次任务的主线程为: %@", [NSThread currentThread]);
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"第一次任务, 第二次任务执行完毕, 继续执行");
    });
    dispatch_async(queue, ^{
        NSLog(@"第三次任务的主线程为: %@", [NSThread currentThread]);
    });
}

//9.多线程中的死锁？
/*
互斥条件 ： 指进程对所分配到的资源进行排它性使用，即在一段时间内某资源只由一个进程占用。如果此时还有其它进程请求资源，则请求者只能等待，直至占有资源的进程用毕释放。
请求和保持条件 ： 指进程已经保持至少一个资源，但又提出了新的资源请求，而该资源已被其它进程占有，此时请求进程阻塞，但又对自己已获得的其它资源保持不放。
不可剥夺条件 ： 指进程已获得的资源，在未使用完之前，不能被剥夺，只能在使用完时由自己释放。
环路等待条件 ： 指在发生死锁时，必然存在一个进程——资源的环形链，即进程集合{P0，P1，P2，···，Pn}中的P0正在等待一个P1占用的资源；P1正在等待P2占用的资源，……，Pn正在等待已被P0占用的资源。
*/
// 同步函数 +主队列  队列阻塞
- (void)deadThread {
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"111");
    });
    NSLog(@"222");
}
//GCD NSOperation NSThread的异同点




@end
