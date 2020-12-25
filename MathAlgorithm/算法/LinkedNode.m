//
//  LinkedNode.m
//  MathAlgorithm
//
//  Created by Leo on 2020/4/20.
//  Copyright © 2020 dongdonghu. All rights reserved.
//

#import "LinkedNode.h"

@interface LinkedNode() {
  LinkedNode * _headNode; //头结点
  LinkedNode * _tailNodel;//尾节点
  NSMutableDictionary *dicKeyValue;//用于保存所有节点
}
@end
@implementation LinkedNode
 -(instancetype)init{
   self = [super init];
   if (self) {
      dicKeyValue = [NSMutableDictionary dictionary];
   }
   return self;
}
//将节点添加在头部之前；
-(void)addNodeAtHead:(LinkedNode *)node {
  dicKeyValue[node.key] = node;
  if (_headNode) {
    node.next = _headNode;
    _headNode.prev = node;
    _headNode = node;
  }else {
    _headNode = _tailNodel = node;
  }
}
//在指定节点之前 添加节点
-(void)addNode:(LinkedNode *)newNode beforeNodeForKey:(NSString*)key{
   LinkedNode *node = dicKeyValue[key];
   dicKeyValue[newNode.key] = newNode;
   if (!_headNode && !_tailNodel) {
      _headNode = _tailNodel = newNode;
   }
   if (node) {
     if ([_headNode isEqual:node]) {
        _headNode = newNode;
     }
     if (node.prev) {
        newNode.prev = node.prev;
        node.prev.next = newNode;
     }
     newNode.next = node;
     node.prev = newNode;
   }
}
//移动node至头部节点；
-(void)bringNodeToHead:(LinkedNode*)node {
  if ([_headNode isEqual:node]) {
     return;
  }
  if ([_tailNodel isEqual:node]) {
     _tailNodel = node.prev;
     _tailNodel.next = nil;
  }else{
    node.next.prev = node.prev;
    node.prev.next = node.next;
  }
  _headNode.prev = node;
  node.next = _headNode;
  node.prev = nil;
  _headNode = node;
}
//移除某个节点
-(void)removeNodeForKey:(NSString*)key{
  LinkedNode *node = dicKeyValue[key];
  if (node) {
     [dicKeyValue removeObjectForKey:key];
     if (node.next) {
        node.next.prev = node.prev;
     }
     if (node.prev) {
        node.prev.next = node.next;
     }
     if ([_headNode isEqual:node]) {
        _headNode = node.next;
     }
     if ([_tailNodel isEqual:node]) {
       _tailNodel = node.prev;
     }
  }
}
//移除尾部节点；
-(LinkedNode*)removeTailNode{

  if (!_tailNodel) {
      return nil;
  }
  LinkedNode * tailNode = _tailNodel;
  [dicKeyValue removeObjectForKey:_tailNodel.key];
  if (_headNode ==_tailNodel) {
      _headNode = _tailNodel = nil;
      
   }else{
     _tailNodel = _tailNodel.prev;
     _tailNodel.next = nil;
   }
   return  tailNode;
}
//遍历所有的node节点；
- (void)readAllNode {
    if (_headNode) {
        LinkedNode *node = _headNode;
        while (node) {
            NSLog(@"key -- %@, value -- %@", node.key, node.value);
            node = node.next;
        }
    }
}

- (void)headNode {
    NSLog(@"head node key -- %@, head node value -- %@", _headNode.key, _headNode.value);
    NSLog(@"node count -- %lu", (unsigned long)dicKeyValue.count);
}

- (void)tailNode {
    NSLog(@"tail node key -- %@, tail node value -- %@", _tailNodel.key, _tailNodel.value);
    NSLog(@"node count -- %lu", (unsigned long)dicKeyValue.count);
}
@end


@interface SingleLinkedNode ()
{
 SingleLinkedNode *_headNode;
 NSMutableDictionary *dic;
}
@end

@implementation SingleLinkedNode

-(instancetype)init {
  self = [super init];
  if (self) {
    dic = [NSMutableDictionary dictionary];
  }
  return self;
}
//新节点添加在o头部之前
-(void)addNodeAhHead:(SingleLinkedNode *)node{
  dic[node.key] = node;
  if (_headNode) {
    node.next = _headNode;
    _headNode = node;
  }else {
    _headNode  = node;
  }
}
//新节点添加在指定节点之后（节点不可重复）
-(SingleLinkedNode*)addNode:(SingleLinkedNode*)newNode behindNodeForKey:(NSString*)key{

  if (!key){
    return  _headNode;
  }
  SingleLinkedNode * node = dic[key];
  if (dic[newNode.key]) {//判断节点是否存在
     return  _headNode;
  }
  dic[newNode.key] = newNode;
  newNode.next = node.next;
  node.next = newNode;
  return newNode;
}
//删除节点
-(SingleLinkedNode*)removeNode:(SingleLinkedNode *)node{
  if (_headNode || !node) {
     return _headNode;
  }
  SingleLinkedNode *tempNode;
  [dic removeObjectForKey:node.key];
  //若删除节点不是尾节点，则将当前节点 替换 成当前节点的下一个节点；
  if (node.next) {
     tempNode = node.next;
     node.next = node.next.next;
     node.key = tempNode.key;
     node.value = tempNode.value;
     tempNode = nil;
     return _headNode;
  }else{
     //从_headNode开始遍历链表，找到tempNode即node的前一个节点
     tempNode = _headNode;
     while (tempNode.next && [tempNode.next isEqual:node]) {
        tempNode = tempNode.next;
     }
     if (tempNode.next) {
        tempNode.next = node.next;
     }
     
  }
  return _headNode;
}
//将node移至头部head；
-(void)bringNodeToHead:(SingleLinkedNode*)node{
   if (!_headNode || !node) {
     return;
   }
   if ([_headNode isEqual:node]) {
    return;
   }
  //从_headNode开始遍历链表，找到tempNode即node的前一个节点；
  SingleLinkedNode * tempNode = _headNode;
  while (tempNode.next && ![tempNode.next isEqual:node]) {
    tempNode = tempNode.next;
  }
  if (tempNode.next) {
    tempNode.next = node.next;
  }
  node.next = _headNode;
  _headNode = node;
}
//查找单向列表中的一个节点
-(SingleLinkedNode*) selecteNode:(NSString*)key
{
  //当然了，因为定义了字典dicKeyVaue，可以通过此字典，直接返回对应key的node；
    //return dicKeyVaue[key];
    SingleLinkedNode *tempNode = _headNode;
    while (tempNode) {
       if ([tempNode.key isEqualToString:key]) {
         return tempNode;
       }
       tempNode = tempNode.next;
    }
    return _headNode;
}
//遍历所有节点；
- (void)readAllNode {
    SingleLinkedNode *tempNode = _headNode;
    while (tempNode) {
      NSLog(@"node key -- %@, node value -- %@", tempNode.key, tempNode.value);
      tempNode = tempNode.next;
    }
}
@end
