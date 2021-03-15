//
//  MathTest.h
//  MathAlgorithm
//
//  Created by Leo on 2020/4/8.
//  Copyright © 2020 dongdonghu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MathTest : NSObject

int sumAdd(int n1, int n2);
+(void)testSum;
- (void)testFunction;

- (int)needStirng:(NSString *)str1 str2:(NSString *)str2;

@end

NS_ASSUME_NONNULL_END
