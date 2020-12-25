//
//  Person.h
//  MathAlgorithm
//
//  Created by Leo on 2019/12/10.
//  Copyright © 2019 dongdonghu. All rights reserved.
//


#import <Foundation/Foundation.h>

@protocol PersonProtocol <NSObject>
@property(nonatomic,strong)NSString *sex;
-(void)getPersonSex;

@end

@interface Person : NSObject <NSCopying>
@property (strong, nonatomic) NSArray *studentArray1;
@property (copy  , nonatomic) NSArray *studentArray2;

//测试消息转发机制
-(void)run;
-(void)run:(NSString*)name;
@end

