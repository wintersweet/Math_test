//
//  Person.m
//  MathAlgorithm
//
//  Created by Leo on 2019/12/10.
//  Copyright © 2019 dongdonghu. All rights reserved.
//

#import "Person.h"
#import "Animation.h"
#import <objc/message.h>
#import <objc/runtime.h>

/*
 自定义对象的copy都是copy的指针，比如数组中有一个自定义对象，再将数组赋值给另一个数组，那么改变其中一个数组中的对象，另一个对象也会跟着变，解决这一点需要在自定义对象遵循copying协议，实现copyWithZone方法，才能实现深拷贝
*/
/*
关联对象：1.类别添加属性，2.关联block 3.关联观察者对象 ，4.为了不重复执行
 时候OC中会有些方法是为了获取某个数据，但这个获取的过程只需要执行一次即可，这个获取的算法可能有一定的时间复杂度和空间复杂度。那么每次调用的时候就必须得执行一次吗？有没有办法让方法只执行一次，每次调用方法的时候直接获得那一次的执行结果？
 有的，方案就是让某个对象的方法获得的数据结果作为“属性”与这个对象进行关
 
*/
@interface Person() //类的Extension
@property (nonatomic,copy)NSString*name;
@property (nonatomic,retain)NSString *name1;

-(void)privateMethod;
@end

@implementation Person
- (void)dealloc{
  NSLog(@"dealloc %@",[self class]);

}

// setter方法 copy
//-(void)setName:(NSString *)name_c
//{
//   id cc = [name_c copy];
//   [name release];
//   name = cc;
//}
//setter方法 retain
//-(void)setName1:(NSString *)name_r
//{
//   [name_r retain];
//   [name1 release];
//   name1 = name_r;
//}
-(void)privateMethod{
   NSLog(@"私有方法， 有声明");
}
-(void)noInterfacePrivateMethod{
   NSLog(@"私有方法，无声明");
}

//一 动态方法解析
+(BOOL)resolveInstanceMethod:(SEL)sel{
   NSString *method = NSStringFromSelector(sel);
   NSLog(@"sel== %@",method);
   //1.判断没实现方法。就动态添加方法
   if ([@"run:" isEqualToString:method]) {
      class_addMethod(self, sel, (IMP)newRun, "v@:@");
   }
   return NO;
//  //2.动态添加的方法没有使用 就给super
//   return [super resolveInstanceMethod:sel];
}
void newRun(id self,SEL sel,NSString *str){
  NSLog(@"run起来了没有- %@",str);
}
// 二.消息转发
-(id)forwardingTargetForSelector:(SEL)aSelector
{
  NSLog(@"aSelector= %@",NSStringFromSelector(aSelector));
  NSString *method = NSStringFromSelector(aSelector);
//  if ([method isEqualToString:@"run"]) {
//     //去找备胎类，看有没有实现这个方法
//     Animation *ani = [[Animation alloc] init];
//     [ani run];
//  }
   return [super forwardingTargetForSelector:aSelector];
}
// 标准消息转发
// 三。生成方法签名
-(NSMethodSignature*)methodSignatureForSelector:(SEL)aSelector
{
   NSString * sel = NSStringFromSelector(aSelector);
   if ([sel isEqualToString:@"run"]) {
      NSLog(@"生成方法签名");
      return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
   }else{
      return [super methodSignatureForSelector:aSelector];
   }
}
// 四.拿到方法签名 配发消息
-(void)forwardInvocation:(NSInvocation *)anInvocation
{
  NSLog(@"anInvocation：%@",anInvocation);
  //1.拿到这个消息
  SEL selector = [anInvocation selector];
  //2.消息转发
  Animation *ani = [[Animation alloc] init];
  if ([ani respondsToSelector:selector]) {
      [anInvocation invokeWithTarget:ani];
      NSLog(@"Animation类实现：%@",anInvocation);
  }else{
     NSLog(@"Animationa类 没实现：%@",anInvocation);
     [super forwardInvocation:anInvocation];
  }
}
//五.抛出异常
-(void)doesNotRecognizeSelector:(SEL)aSelector
{
   NSLog(@"这个-----%@---方法不存在", NSStringFromSelector(aSelector));
}
//关联对象 --获取对象所有的属性名
+(NSArray*)propertyList{
  // 0. 判断是否存在关联对象，如果存在，直接返回
  /**
   1> 关联到的对象
   2> 关联的属性 key
   提示：在 OC 中，类本质上也是一个对象
   */
   NSArray *proList = objc_getAssociatedObject(self, @"key");
   if (proList != nil) {
      return proList;
   }
   // 1. 获取`类`的属性
     /**
      参数
      1> 类
      2> 属性的计数指针
      */
    unsigned int count = 0;
    objc_property_t * list = class_copyPropertyList([self class], &count);
    NSMutableArray * mArr = [NSMutableArray arrayWithCapacity:count];
    free(list);
    // 设置关联对象
    /**
     1> 关联的对象
     2> 关联对象的 key
     3> 属性数值
     4> 属性的持有方式 reatin, copy, assign
     */
    objc_setAssociatedObject(self, @"key", mArr, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return mArr;
}
//KVC进行键值赋值
+(instancetype)objcWithDic:(NSDictionary*)dic{
  id obj = [[self alloc]init];
  
  NSArray *lists = [self propertyList];
  for (int i = 0 ; i < lists.count; i ++) {
     NSString *key = lists[i];
     if (dic[key] != nil) {
       [obj setValue:dic[key] forKey:key];
     }
  }
  return obj;
}
@end
