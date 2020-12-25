//
//  LinkedNode.h
//  MathAlgorithm
//
//  Created by Leo on 2020/4/20.
//  Copyright © 2020 dongdonghu. All rights reserved.
//

#import <Foundation/Foundation.h>


//双向链表节点类，包含key、value以及前节点和后节点等信息；
@interface LinkedNode : NSObject

@property (nonatomic,strong)NSString *key;
@property (nonatomic,strong)NSString *value;

@property (nonatomic,strong)LinkedNode *prev;
@property (nonatomic,strong)LinkedNode *next;

@end


@interface SingleLinkedNode : NSObject

@property (nonatomic,strong)NSString *key;
@property (nonatomic,strong)NSString *value;
@property (nonatomic,strong)SingleLinkedNode *next;

@end



