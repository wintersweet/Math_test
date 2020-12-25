//
//  ReverseList.h
//  MathAlgorithm
//
//  Created by Leo on 2020/3/30.
//  Copyright © 2020 dongdonghu. All rights reserved.
//

#import <Foundation/Foundation.h>
//链表反转（头差法）
struct Node{
    int data;
    struct Node *next;
};

@interface ReverseList : NSObject

struct Node * reverseList(struct Node*head);
struct Node *constructList(void);

void printList(struct Node*head);
@end

