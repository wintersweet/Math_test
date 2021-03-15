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
+ (BinaryTreeNode *)treeNodeAtIndex:(NSInteger)index inTree:(BinaryTreeNode *)treeNode {
    
    if (!treeNode || index < 0) {
        return nil;
    }
    
    NSMutableArray *queryArray = [NSMutableArray array];
    [queryArray addObject:treeNode];
    
    while (queryArray.count > 0) {
        
        BinaryTreeNode *node = [queryArray firstObject];
        
        if (index == 0) {
            return node;
        }
        
        [queryArray removeObjectAtIndex:0];
        index--;
        
        if (node.leftNode) {
            
            [queryArray addObject:node.leftNode];
        }
        
        if (node.rightNode) {
            
            [queryArray addObject:node.rightNode];
        }
    }
    
    return nil;
}

//广度优先遍历二叉树，从上到下，从左到右依次遍历，先遍历完一层再遍历下一层；
+ (void)levelTraverseTree:(BinaryTreeNode *)treeNode handler:(void (^)(BinaryTreeNode *))handler {
    
    if (!treeNode) {
        return;
    }
    
    NSMutableArray *queryArray = [NSMutableArray array];
    [queryArray addObject:treeNode];
    
    while (queryArray.count > 0) {
        
        BinaryTreeNode *node = [queryArray firstObject];
        
        if (handler) {
            
            handler(node);
        }
        
        [queryArray removeObjectAtIndex:0];//仿照队列fifo原则；
        
        if (node.leftNode) {
            
            [queryArray addObject:node.leftNode];
        }
        
        if (node.rightNode) {
            
            [queryArray addObject:node.rightNode];
        }
    }
}


//深度优先遍历，先遍历左子树，再遍历右子树；
+ (void)depthTraverseTree:(BinaryTreeNode *)treeNode handler:(void (^)(BinaryTreeNode *))handler {
    
    if (!treeNode) {
        
        return;
    }
    
    NSMutableArray *queryArray = [NSMutableArray array];
    [queryArray addObject:treeNode];
    
    while (queryArray.count > 0) {
        
        BinaryTreeNode *node = [queryArray firstObject];
        
        if (handler) {
            
            handler(node);
        }
        
        [queryArray removeObjectAtIndex:0];//仿照队列fifo原则；
        
        if (node.rightNode) {
            
            [queryArray addObject:node.rightNode];
        }
        
        if (node.leftNode) {
            
            [queryArray addObject:node.leftNode];
        }
    }
}



/**
 *  前序遍历 （中序遍历 -- 先左子树，再根，再右子树；后序遍历 -- 先左子树，再右子树，再根。）
 *  先访问根，再遍历左子树，再遍历右子树；递归思想，每一个不为空的节点都重复先访问根，再遍历左子树，再遍历右子树的流程；
 *
 *  @param rootNode 根节点
 *  @param handler  访问节点处理函数
 */
+ (void)preOrderTraverseTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))handler {
    
    if (rootNode) {
        
        //读取节点信息；
        if (handler) {
            
            handler(rootNode);
        }
        
        [self preOrderTraverseTree:rootNode.leftNode handler:handler];
        [self preOrderTraverseTree:rootNode.rightNode handler:handler];
    }
}


//非递归 -- 模拟节点进出栈方法实现，前序遍历；
+ (void)preTraverseTree:(BinaryTreeNode *)treeNode handler:(void (^)(BinaryTreeNode *))handler {
    
    if (!treeNode) {
        
        return;
    }
    
    NSMutableArray *queryArray = [NSMutableArray array];
    BinaryTreeNode *node = treeNode;
    
    while (node || queryArray.count > 0) {
        
        while (node) {
            
            //读取节点信息；
            if (handler) {
                
                handler(node);
            }
            
            [queryArray addObject:node];
            node = node.leftNode;
        }
        
        if (queryArray.count > 0) {
            
            node = [queryArray lastObject];
            [queryArray removeObject:node];
            node = node.rightNode;
        }
    }
}


//非递归 -- 模拟节点进出栈方法实现，中序遍历；
+ (void)inTraverseTree:(BinaryTreeNode *)treeNode handler:(void (^)(BinaryTreeNode *))handler {
    
    if (!treeNode) {
        
        return;
    }
    
    BinaryTreeNode *node = treeNode;
    NSMutableArray *queryArray = [NSMutableArray array];
    
    while (node || queryArray.count > 0) {
        
        while (node) {
            
            [queryArray addObject:node];
            node = node.leftNode;
        }
        
        if (queryArray.count > 0) {
            
            node = [queryArray lastObject];
            [queryArray removeObject:node];
            
            //读取节点信息；
            if (handler) {
                
                handler(node);
            }
            
            node = node.rightNode;
        }
    }
}


//非递归 -- 模拟节点进出栈方法实现，后序遍历；
+ (void)postTraverseTree:(BinaryTreeNode *)treeNode handler:(void (^)(BinaryTreeNode *))handler {
    
    if (!treeNode) {
        
        return;
    }
    
    BinaryTreeNode *preNode = nil;
    BinaryTreeNode *curNode;
    NSMutableArray *queryArray = [NSMutableArray array];
    [queryArray addObject:treeNode];
    
    while (queryArray.count > 0) {
        
        //（1）当前节点左右孩子都不存在，可以直接访问该节点；
        //（2）存在左孩子节点或者是右孩子节点，且其左右孩子节点已经被访问过，也可以直接访问该节点；
        curNode = [queryArray lastObject];
        if ((!curNode.leftNode && !curNode.rightNode) || (preNode && ([preNode isEqual:curNode.leftNode] || [preNode isEqual:curNode.rightNode]))) {
            
            if (handler) {
                
                handler(curNode);
            }
            
            [queryArray removeObject:curNode];
            preNode = curNode;
            
        }  else {
            
            if (curNode.rightNode) {
                
                [queryArray addObject:curNode.rightNode];
            }
            
            if (curNode.leftNode) {
                
                [queryArray addObject:curNode.leftNode];
            }
        }
    }
}
@end



@implementation BinaryTreeNode

@end
