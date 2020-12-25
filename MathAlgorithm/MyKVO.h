//
//  MyKVO.h
//  MathAlgorithm
//
//  Created by Leo on 2020/4/17.
//  Copyright © 2020 dongdonghu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Cat;

@interface MyKVO : NSObject

@end

@interface Animal : NSObject <NSCopying>

@property (nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)Cat * cat;
@end

@interface Cat : NSObject<NSCopying>

@property(nonatomic,strong)NSString *age;
@property(nonatomic,strong)NSString *name;

@property (nonatomic,strong)NSMutableArray *mulArr;
@end
