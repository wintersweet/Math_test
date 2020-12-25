//
//  BinaryTree.h
//  MathAlgorithm
//
//  Created by Leo on 2020/4/22.
//  Copyright © 2020 dongdonghu. All rights reserved.
//

#import <Foundation/Foundation.h>

//二叉树管理类，创建和遍历二叉树以及增加二叉树节点等；
@interface BinaryTree : NSObject

@end


//二叉树节点定义，包含左节点leftNode、右节点rightNode、父节点（未使用）以及节点值value
@interface BinaryTreeNode : NSObject

@property(nonatomic,assign)NSInteger value;
@property(nonatomic,strong)BinaryTreeNode *fatherNode;//父节点
@property(nonatomic,strong)BinaryTreeNode *leftNode;//左节点
@property(nonatomic,strong)BinaryTreeNode *rightNode;//又节点


@end
