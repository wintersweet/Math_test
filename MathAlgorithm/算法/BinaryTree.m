//
//  BinaryTree.m
//  MathAlgorithm
//
//  Created by Leo on 2020/4/22.
//  Copyright © 2020 dongdonghu. All rights reserved.
//

#import "BinaryTree.h"
@interface BinaryTree ()

@end

@implementation BinaryTree
/*
*创建二叉排序树
*二叉排序树：左节点值全部小于根节点值，右节点值全部大于根节点值
*@return 二叉树根节点
*/
+(BinaryTreeNode*)createTreeWithValues:(NSArray*)values{
  BinaryTreeNode *root = nil;
  for (int i = 0 ; i <values.count; i++) {
    NSInteger value  = [(NSNumber*)[values objectAtIndex:i] intValue];
    root = [BinaryTree addTreeNode:root value:value];
  }
  return root;
}
//递归添加节点，始终返回根节点；
+(BinaryTreeNode*)addTreeNode:(BinaryTreeNode*)treeNode value:(NSInteger)value{

  if (!treeNode) {
     treeNode = [BinaryTreeNode new];
     treeNode.value = value;
   }else if (value <= treeNode.value){
     NSLog(@"to left");
     //值小于根节点，则插入到左子树
     treeNode.leftNode = [BinaryTree addTreeNode:treeNode.leftNode value:value];
   }else{
      treeNode.rightNode = [BinaryTree addTreeNode:treeNode.rightNode value:value];
   }
   return treeNode;
}
//反转二叉树（左右节点互换），递归思想
+(BinaryTreeNode *)invertBinaryTree:(BinaryTreeNode *)rootNode{

  if (!rootNode) {
    return nil;
  }
  if (!rootNode.leftNode && !rootNode.rightNode) {
     return rootNode;
  }
  [self invertBinaryTree:rootNode.leftNode];
  [self invertBinaryTree:rootNode.rightNode];
  BinaryTreeNode *temp = rootNode.leftNode;
  rootNode.leftNode = rootNode.rightNode;
  rootNode.rightNode = temp;
  return rootNode;
}
//查找index位置的node -- 从0开始查找，根据先进先出的顺序查找；

@end



@implementation BinaryTreeNode

@end
