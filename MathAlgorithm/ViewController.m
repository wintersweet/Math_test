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
#import "ReverseList.h"
#import "MathTest.h"
#import "MathAlgorithm-Swift.h"

typedef int MyInteger;
typedef void (^block)(NSString *value);
typedef void (^block1) (NSString *value);
@interface ViewController ()<UITextFieldDelegate, PersonProtocol>
{
    Person *person;
}
@property (weak, nonatomic)   IBOutlet UITextField *TF;
@property (nonatomic, strong) NSMutableArray *mTempArr;
@property (nonatomic, strong) Animal *ani;

@property (copy, nonatomic) void (^ block)(void);
@property (assign, nonatomic) int aaa;

@property (assign, nonatomic) NSInteger ticketSurplusCount;
@property (strong, nonatomic) NSLock *lock;

@end

@implementation ViewController

@synthesize sex = _testSex;
- (void)xxBlock:(block)value xx:(void (^)(NSString *value))value1 xx1:(void (^)(NSString *value))value2 {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self get_global_queue];

//    TestLock *lock = [[TestLock alloc]init];
//    [lock inits];
//    [lock start];
    MathReview *review = [[MathReview alloc]init];
    [review initTreeNodes];
    [review treeHeight];
    [review testNode];

    [MathReview findTargetArr];
    MathTest *math1 =  [[MathTest alloc]init];
    [math1 reserseString:@"abc"];
    [math1 lengthOfLongestSubstring:@"abcabcbb"];
    return;

    auto int age = 10;
    static int num = 25;
    MyInteger a = 10;
    [ReverseList mergeList:@[@4, @3] arrayB:@[@1, @4, @6]];
    [self testKVO];

    MathTest *math =  [[MathTest alloc]init];
    [MathTest testSum];
    [math testFunction];
    NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", nil];
    NSMutableArray *arr2 = [NSMutableArray arrayWithCapacity:3];
    __block int xx = 10;

    [arr1 enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        [arr2 addObject:obj];
//        [arr1 addObject:@"10"];
        xx = idx;
    }];
    NSLog(@"测试结束");

//    _TF.delegate = self;
//    self.sex = @"测试性别";
//
//    Person * person = [[Person alloc]init];
//    [person privateMethod];
//    //   [person run];
//    //  [person run:@"12"];
//
//    [Runloop testRunloop];
//    testBlock1();
//    testBlock2();
//    testBlock3();
//    testBlock4();
//    [self testBlockStrongWeak];
//    [self initTicketStatusNotSave];
//    [self testCopy];
//    [self mutableInstanceCopy];
//    [self containerInstanceShallowCopy];
    int outPut = [self needStirng:@"hellowll" str2:@"ll"];
//    [MathReview]
//     MathReview.te
//    [MathReview test1:@"hellow":@"ll"];
    [[MathReview new] test2:@"hello":@"ll"];

    [MathReview findTargetArr];
    NSLog(@"1");
}

/*
给定一个 haystack 字符串和一个 needle 字符串，在 haystack 字符串中找出 needle 字符串出现的第一个位置 (从0开始)。如果不存在，则返回  -1。
str1 = @“hello“;
str2 = @"ll";
*/
- (int)needStirng:(NSString *)str1 str2:(NSString *)str2 {
    bool hasValue = NO;
    NSInteger index = 0;
    for (int i = 0; i < str1.length - str2.length; i++) {
        NSString *nn = [str1 substringWithRange:NSMakeRange(i, str2.length)];
        if ([nn isEqualToString:str2]) {
            index = i;
            hasValue = YES;
            NSLog(@"111");
        }
    }
    return hasValue == YES ? -1 : index;
}

//copy，       浅拷贝（指针复制）
//mutableCopy，深拷贝（对象复制 指针+内存），返回对象可变（产生新的可变对象）
- (void)testCopy {
    NSString *string = @"Hello";
    NSString *stringCopy = [string copy];
    //copy，浅拷贝（拷贝出一个新的指针，指向string指向的内存地址）
    NSLog(@"string: %@, %p", string, string);
    NSLog(@"stringCOpy: %@, %p", stringCopy, stringCopy);
    //mutableCopy，深拷贝（拷贝出一个新的指针，并且拷贝一份string指向的内存并指向它，不指向string指向的内存地址）
    NSString *stringMutableCopy = [string mutableCopy];
    NSLog(@"stringMutableCopy: %@, %p", stringMutableCopy, stringMutableCopy);
}

//copy，       深拷贝（对象复制），返回对象不可变
//mutableCopy，深拷贝（对象复制），返回对象可变
- (void)mutableInstanceCopy {
    NSMutableString *string = [NSMutableString stringWithString:@"hello"];
    //copy 深拷贝，返回对象不可变
    id mutableStringCopy = [string copy];
    //[mutableStringCopy appendString:@"!"];
    NSLog(@"string: %@, %p", string, string);
    NSLog(@"mutableStringCopy: %@, %p", mutableStringCopy, mutableStringCopy);
    //mutableCopy 深拷贝，返回对象可变
    NSMutableString *mutableStringMutableCopy = [string mutableCopy];
    NSLog(@"mutableStringMutableCopy: %@, %p", mutableStringMutableCopy, mutableStringMutableCopy);
}

//注意容器里套可变对象的情况（容器内的元素都是浅拷贝）
//开发时注意，数组中都是模型时，拷贝后的数组中的模型还是原来数组的模型，一个变都改变
- (void)containerInstanceShallowCopy
{
    NSArray *array = [NSArray arrayWithObjects:[NSMutableString stringWithString:@"Welcome"], @"to", @"Xcode", nil];

    //未创建了新的容器，容器内的元素是指针赋值（浅拷贝）
    NSArray *arrayCopy = [array copy];
    //创建了新的容器，容器内的元素是指针赋值（浅拷贝）
    NSMutableArray *arrayMutableCopy = [array mutableCopy];

    NSLog(@"array:     %p", array);
    NSLog(@"arrayCopy: %p", arrayCopy);
    NSLog(@"arrayMutableCopy: %p", arrayMutableCopy);

    //容器内的对象是浅拷贝，即它们在内存中只有一份
    NSMutableString *testString = [array objectAtIndex:0];
    [testString appendString:@" you"];
    //三个数组的内容同时改变
    NSLog(@"array[0]: %@", array[0]);
    NSLog(@"arrayCopy[0]: %@", arrayCopy[0]);
    NSLog(@"arrayMutableCopy[0]: %@", arrayMutableCopy[0]);
}

//对象序列化，实现真正意义的拷贝（数组内的对象也实现深拷贝）：
- (void)containerInstanceDeepCopy
{
    NSArray *array = [NSArray arrayWithObjects:[NSMutableString stringWithString:@"Welcome"], @"to", @"Xcode", nil];

    //数组内对象是指针复制
    NSArray *deepCopyArray = [[NSArray alloc] initWithArray:array];
    //真正意义上的深复制，数组内对象是对象复制
    NSArray *trueDeepCopyArray = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:array]];

    NSLog(@"array: %p", array);
    NSLog(@"deepCopyArray: %p", deepCopyArray);
    NSLog(@"trueDeepCopyArray: %p", trueDeepCopyArray);

    //改变array的第一个元素
    [[array objectAtIndex:0] appendString:@" you"];

    //只影响deepCopyArray数组的第一个元素
    NSLog(@"array[0]: %@", array[0]);
    NSLog(@"arrayCopy[0]: %@", deepCopyArray[0]);
    //不影响trueDeepCopyArray数组的第一个元素，是真正意义上的深拷贝
    NSLog(@"arrayMutableCopy[0]: %@", trueDeepCopyArray[0]);
}

#pragma mark---深浅copy 的几个应用
/*
1、@property (nonatomic, strong) NSMutableString *name;为什么不用copy修饰？
若用copy修饰这个可变字符串属性，当给name属性赋值时，setter方法会触发深拷贝，
导致结果是name属性不再可变，因为可变字符串的copy返回不可变对象
 */

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)get_global_queue {
    // 全局并发队列的获取方法
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSLog(@"111");
    dispatch_sync(queue, ^{
        NSLog(@"222");
    });
    dispatch_sync(queue, ^{
        NSLog(@"333");
    });
    NSLog(@"444");
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

- (void)testBlock {
    Person *p1 = [[Person alloc]init];
    __block Person *p2 = [[Person alloc]init];
    p1.names = @"mike1";
    p2.names = @"mike2";

    __block int vi =  1;
    void (^ handleBlock)(NSString *) = ^(NSString *name) {
        p1.names = name;
        p2.names = name;
        vi = 2;
    };
    handleBlock(@"Lucy");
    NSLog(@"p1 == %@", p1.names);
    NSLog(@"p2 == %@", p2.names);
    NSLog(@"vi == %i", vi);
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    static int i = 0;
    //控制是否是自动的
    [self.ani willChangeValueForKey:@"name"];
    self.ani.name = [NSString stringWithFormat:@"%d", i++];
    [self.ani didChangeValueForKey:@"name"];
    self.ani.cat.age = [NSString stringWithFormat:@"%d", i++];
    NSLog(@"点击了屏幕");
//    [[self.ani mutableArrayValueForKey:@"dataArray"] addObject:@"1111"];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"点击屏幕结束");
    [[self.ani mutableArrayValueForKey:@"dataArray"] removeObject:@"1111"];
}

- (IBAction)click:(id)sender {
    NSLog(@"点击按钮");
    self.ani.name = @"新名字";
    self.ani.cat.age = [NSString stringWithFormat:@"%d", 88];
}

- (void)testKVO
{
    self.ani = [[Animal alloc]init];
    Cat *cat = [[Cat alloc]init];

    self.ani.name = @"名字1";
    self.ani.cat = [cat copy];
    self.ani.cat.age = @"12";

//1.[self.ani addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
//2.观察cat某个属性   [self.ani addObserver:self forKeyPath:@"cat.age" options:NSKeyValueObservingOptionNew context:nil];
//3.观察cat   [self.accessibilityElements addObserver:self forKeyPath:@"cat" options:NSKeyValueObservingOptionNew context:nil];
    [self.ani addObserver:self forKeyPath:@"dataArray" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey, id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"dataArray"]) {
        NSLog(@"dataArray");
        if (self.ani.dataArray.count > 0) {
            NSLog(@"观察数组change =%@", change);
        } else {
            NSLog(@"观察数组change =%@", change);
        }
    }
    if ([keyPath isEqualToString:@"name"]) {
        NSLog(@"name");
    }
    if ([keyPath isEqualToString:@"cat.age"]) {
        NSLog(@"cat.age");
    }
}

- (void)dealloc
{
    [self.ani removeObserver:self forKeyPath:@"name"];
}

@end
