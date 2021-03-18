//
//  NSProxyTimer.m
//  MathAlgorithm
//
//  Created by Leo on 2021/3/15.
//  Copyright © 2021 dongdonghu. All rights reserved.
//

#import "NSProxyTimer.h"

@interface NSProxyTimer ()

@property (nonatomic, weak) id target;

@end

@implementation NSProxyTimer
- (id)initWithTarget:(id)target {
    self.target = target;
    return self;
}

/*
 这个函数让重载方有机会抛出一个函数的签名，再由后面的forwardInvocation:去执行
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self methodSignatureForSelector:sel];
}

/*
 将消息转发给其他对象，这里转发给控制器
 */
- (void)forwardInvocation:(NSInvocation *)invocation {
    SEL sel = [invocation selector];
    if ([self.target respondsToSelector:sel]) {
        [invocation invokeWithTarget:self.target];
    }
}

@end

@interface TestTimer ()
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, assign) NSInteger count;

@end

@implementation TestTimer

- (void)porxy {
    NSProxyTimer *proxy = [[NSProxyTimer alloc]initWithTarget:self];
    _timer = [NSTimer timerWithTimeInterval:1 target:proxy selector:@selector(timeAction) userInfo:nil repeats:YES];
}

- (void)timeAction {
    _count++;
}

- (void)dealloc {
    [_timer invalidate];
}

@end
