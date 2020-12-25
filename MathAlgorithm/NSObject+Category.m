//
//  NSObject+Category.m
//  MathAlgorithm
//
//  Created by Leo on 2020/4/8.
//  Copyright © 2020 dongdonghu. All rights reserved.
//

#import "NSObject+Category.h"

@implementation NSObject(Category)
//各类别添加属性
-(NSString*)myTitle{
   return objc_getAssociatedObject(self, @selector(myTitle));
}
-(void)setMyTitle:(NSString *)myTitle{
  objc_setAssociatedObject(self, @selector(myTitle),myTitle, OBJC_ASSOCIATION_RETAIN);
}
@end
