//
//  MyKVO.m
//  MathAlgorithm
//
//  Created by Leo on 2020/4/17.
//  Copyright © 2020 dongdonghu. All rights reserved.
//

#import "MyKVO.h"
@interface MyKVO ()

@end
@implementation MyKVO

@end

@implementation Animal


//是否是自动的
// +(BOOL)automaticallyNotifiesObserversOfName
// {
//   return NO;
// }
//iOS提供了一个方法来返回指定的属性容器，达到只要监听对象的目的
+ (NSSet<NSString *> *)keyPathsForValuesAffectingValueForKey:(NSString *)key
{
    NSSet *keypPaths = [super keyPathsForValuesAffectingValueForKey:key];
    if ([key isEqualToString:@"cat"]) {
        NSArray *arrKeyPath = @[@"_cat.age", @"_cat.name"];
        keypPaths = [keypPaths setByAddingObjectsFromArray:arrKeyPath];
    }
    return keypPaths;
}
- (void)willChangeValueForKey:(NSString *)key {
  NSLog(@"willChangeValueForKey");
}

- (void)didChangeValueForKey:(NSString *)key {
  NSLog(@"didChangeValueForKey");
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (id)copyWithZone:(NSZone *)zone
{
    Animal *a = [[[self class] alloc]init];
    a.name = self.name;
    a.cat = self.cat;
    return a;
}

@end

@interface Cat ()

@end

@implementation Cat

- (id)copyWithZone:(NSZone *)zone
{
    Cat *c = [[Cat alloc] init];
    c.age = self.age;
    return c;
}
- (void)willChangeValueForKey:(NSString *)key {
  NSLog(@"cat.willChangeValueForKey");
}

- (void)didChangeValueForKey:(NSString *)key {
  NSLog(@"cat.didChangeValueForKey");
}
@end
