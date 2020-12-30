//
//  ViewController.m
//  MathAlgorithm
//
//  Created by Leo on 2019/7/22.
//  Copyright © 2019 dongdonghu. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
#import "Person.h"
#import "Person+Category.h"
#import "Runloop.h"
#import "MyKVO.h"
@interface ViewController ()<UITextFieldDelegate, PersonProtocol>
{
    Person *person;
}
@property (weak, nonatomic) IBOutlet UITextField *TF;
@property (nonatomic, strong) NSMutableArray *mTempArr;
@property (nonatomic, strong) Animal *ani;

@property (copy, nonatomic) void (^ block)(void);
@property (assign, nonatomic) int aaa;

@property (assign, nonatomic) NSInteger ticketSurplusCount;
@property (strong, nonatomic) NSLock *lock;

@end

@implementation ViewController

@synthesize sex = _testSex;

- (void)viewDidLoad {
    [super viewDidLoad];
    auto int age = 10;
    static int num = 25;
//    _TF.delegate = self;
//    self.sex = @"测试性别";
//
//    Person * person = [[Person alloc]init];
//    [person privateMethod];
//    //   [person run];
//    //  [person run:@"12"];
//
//    [Runloop testRunloop];
//    [self testKVO];
//    testBlock1();
//    testBlock2();
//    testBlock3();
//    testBlock4();
//    [self testBlockStrongWeak];
    [self initTicketStatusNotSave];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    });
//    [self testOperationQueue1];
}

//MARK:测试线程死锁问题
- (void)testMain {
    dispatch_queue_t queue = dispatch_get_main_queue();
    NSLog(@"do somenting=%@", [NSThread currentThread]);
    sleep(3);
    dispatch_sync(queue, ^{
        NSLog(@"do somenting111=%@", [NSThread currentThread]);
    });
}

- (void)testThread {
    NSLog(@"do somenting=%@", [NSThread currentThread]);
    dispatch_queue_t queue = dispatch_queue_create("xxx", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(queue, ^{
        NSLog(@"do somenting111=%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"do somgthing333%@", [NSThread currentThread]);
        dispatch_async(queue, ^{
            NSLog(@"do somgthing444%@", [NSThread currentThread]);
        });
    });
}

//MARK:测试NSOperation
- (void)testInvocationOperation {
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]initWithTarget:self
                                                                           selector:@selector(invocationOperation) object:nil];
    [operation start];
    //开启新线城
    //[NSThread detachNewThreadSelector:@selector(invocationOperation) toTarget:self withObject:nil];
}

- (void)invocationOperation {
    for (int i = 0; i < 3; i++) {
        [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
        NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
    }
}

- (void)testNSOperation {
    NSLog(@"do somgthing%@", [NSThread currentThread]);
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"0------%@", [NSThread currentThread]);
    }];

    [operation addExecutionBlock:^{
        [NSThread sleepForTimeInterval:2];         // 模拟耗时操作
        NSLog(@"1------%@", [NSThread currentThread]);
    }];
    [operation addExecutionBlock:^{
        [NSThread sleepForTimeInterval:2];         // 模拟耗时操作
        NSLog(@"2------%@", [NSThread currentThread]);
    }];
    [operation addExecutionBlock:^{
        [NSThread sleepForTimeInterval:2];         // 模拟耗时操作
        NSLog(@"3------%@", [NSThread currentThread]);
    }];
    [operation start];

//    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"do somgthing444%@", [NSThread currentThread]);
//    }];
//    [operation1 addExecutionBlock:^{
//        NSLog(@"do somgthing555%@", [NSThread currentThread]);
//    }];
//    [operation1 addDependency:operation];

//
}

- (void)testOperationQueue {
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];

    NSInvocationOperation *op1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task1) object:nil];

    // 使用 NSInvocationOperation 创建操作2
    NSInvocationOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task2) object:nil];

    // 使用 NSBlockOperation 创建操作3
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"3---%@", [NSThread currentThread]);
        }
    }];
    [op3 addExecutionBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2];
            NSLog(@"4---%@", [NSThread currentThread]);
        }
    }];

    // 3.使用 addOperation: 添加所有操作到队列中
    [queue addOperation:op1]; // [op1 start]
    [queue addOperation:op2]; // [op2 start]
    [queue addOperation:op3]; // [op3 start]
}

- (void)testOperationQueue1 {
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    // 2.使用 addOperationWithBlock: 添加操作到队列中
    queue.maxConcurrentOperationCount = 1;
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"3---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
}

/**
 * 操作依赖
 * 使用方法：addDependency:
 */
- (void)addDependency {
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    // 2.创建操作
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];

    // 3.添加依赖
    [op2 addDependency:op1]; // 让op2 依赖于 op1，则先执行op1，在执行op2

    // 4.添加操作到队列中
    [queue addOperation:op1];
    [queue addOperation:op2];
}

- (void)task1 {
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:2];
        NSLog(@"5---%@", [NSThread currentThread]);
    }
}

- (void)task2 {
    for (int i = 0; i < 2; i++) {
        [NSThread sleepForTimeInterval:2];
        NSLog(@"6---%@", [NSThread currentThread]);
    }
}

/**
 * 线程间通信
 */
- (void)communication {
    // 1.创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    // 2.添加操作
    [queue addOperationWithBlock:^{
        // 异步进行耗时操作
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
        }
        // 回到主线程
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // 进行一些 UI 刷新等操作
            for (int i = 0; i < 2; i++) {
                [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
                NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
            }
        }];
    }];
}

- (void)test {
    @autoreleasepool {
        __block NSInteger value = 0;
        void (^ block)(void) = ^() {
            value = 1;
            self->_aaa = 10;
        };
        _aaa = 10;
        block();
        NSLog(@"value= %ld", (long)value);
    }
}

//NSOperation、NSOperationQueue 非线程安全
/**
 * 非线程安全：不使用 NSLock
 * 初始化火车票数量、卖票窗口(非线程安全)、并开始卖票
 */
- (void)initTicketStatusNotSave {
    NSLog(@"currentThread---%@", [NSThread currentThread]); // 打印当前线程
    self.lock = [[NSLock alloc]init];
    self.ticketSurplusCount = 50;
    // 1.创建 queue1,queue1 代表北京火车票售卖窗口
    NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
    queue1.maxConcurrentOperationCount = 1;

    // 2.创建 queue2,queue2 代表上海火车票售卖窗口
    NSOperationQueue *queue2 = [[NSOperationQueue alloc] init];
    queue2.maxConcurrentOperationCount = 1;

    // 3.创建卖票操作 op1
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        [self saleTicketNotSafe];
    }];

    // 4.创建卖票操作 op2
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        [self saleTicketNotSafe];
    }];

    // 5.添加操作，开始卖票
    [queue1 addOperation:op1];
    [queue2 addOperation:op2];
}

/**
 * 售卖火车票(非线程安全)
 */
- (void)saleTicketNotSafe {
    while (1) {
//        [self.lock lock];
        if (self.ticketSurplusCount > 0) {
            //如果还有票，继续售卖
            self.ticketSurplusCount--;
            NSLog(@"%@", [NSString stringWithFormat:@"剩余票数:%ld 窗口:%@", (long)self.ticketSurplusCount, [NSThread currentThread]]);
            [NSThread sleepForTimeInterval:0.2];
//            [self.lock unlock];
        } else {
            NSLog(@"所有火车票均已售完");
            break;
        }
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    static int i = 0;
    //控制是否是自动的
//   [self.ani willChangeValueForKey:@"name"];
//   self.ani.name = [NSString stringWithFormat:@"%d",i++];
//   [self.ani didChangeValueForKey:@"name"];
//    self.ani.cat.age = [NSString stringWithFormat:@"%d",i++];
    NSLog(@"点击了");
    [[self.ani mutableArrayValueForKey:@"dataArray"] addObject:@"1111"];
    TestViewController *vc = [[TestViewController alloc]init];
    [self presentViewController:vc animated:YES completion:^{
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"点击结束");
    [[self.ani mutableArrayValueForKey:@"dataArray"] removeObject:@"1111"];
}

void testBlock1()
{
    int num = 100;
    void (^ block)() = ^{
        NSLog(@"num equal %d", num);//100
    };
    num = 200;
    block();
}

void testBlock2()
{
    __block int num = 100;
    void (^ block)(void) = ^{
        NSLog(@"num equal %d", num);//200
    };
    num = 200;
    block();
}

int num = 100;
void testBlock3()
{
    void (^ block)(void) = ^{
        NSLog(@"num equal %d", num);//200
    };
    num = 200;
    block();
}

void testBlock4()
{
    static int num = 100;
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:@"1"];
    void (^ block)(void) = ^{
        [arr addObject:@"2"];
        NSLog(@"num equal %d", num);//200
    };
    num = 200;
    block();
}

//block strong weak
- (void)testBlockStrongWeak
{
    Person *person = [[Person alloc]init];
    self->person = person;
    __weak Person *weakPerson = self->person;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        __strong Person *strongPerson = weakPerson;
        NSInteger count = 0;
        while (count < 5) {
            count++;
            NSLog(@"xxx---:%@", strongPerson);
            sleep(1);
        }
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self->person = nil;
        NSLog(@"---释放了---");
    });
}

- (void)testKVO
{
    self.ani = [[Animal alloc]init];
    Cat *cat = [[Cat alloc]init];

    self.ani.name = @"animale1";
    self.ani.cat = [cat copy];
    self.ani.cat.age = @"12";
//1.   [self.ani addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
//2.观察cat某个属性   [self.ani addObserver:self forKeyPath:@"cat.age" options:NSKeyValueObservingOptionNew context:nil];
//3.观察cat   [self.accessibilityElements addObserver:self forKeyPath:@"cat" options:NSKeyValueObservingOptionNew context:nil];
    [self.ani addObserver:self forKeyPath:@"dataArray" options:NSKeyValueObservingOptionNew context:nil];
    [self.ani.dataArray addObject:@"content_1"];
    [self.ani.dataArray addObject:@"content_2"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey, id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"dataArray"]) {
        if (self.ani.dataArray.count > 0) {
            NSLog(@"观察数组change =%@", change);
        } else {
            NSLog(@"观察数组change =%@", change);
        }
    }
}

- (void)dealloc
{
    [self.ani removeObserver:self forKeyPath:@"name"];
}

@end
