//
//  NSProxyTimer.h
//  MathAlgorithm
//
//  Created by Leo on 2021/3/15.
//  Copyright © 2021 dongdonghu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//NSTimer引起的内存泄漏问题
@interface NSProxyTimer : NSProxy

@end

NS_ASSUME_NONNULL_END

@interface TestTimer : NSObject

@end
