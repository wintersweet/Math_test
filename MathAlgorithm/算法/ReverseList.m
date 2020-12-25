//
//  ReverseList.m
//  MathAlgorithm
//
//  Created by Leo on 2020/3/30.
//  Copyright © 2020 dongdonghu. All rights reserved.
//
//链表反转（头差法）
#import "ReverseList.h"
//1....
@implementation ReverseList
struct Node * reverseList(struct Node*head){
   //定义遍历指针，初始化为头结点
   struct Node *p = head;
   // 反转后的链表头部
   struct Node *newH = NULL;
   //遍历链表
   while (p != NULL) {
      //记录下一个节点
      struct Node*temp = p -> next;
      // 当前结点的next指向新链表头部
      p -> next = newH;
       // 更改新链表头部为当前结点
       newH = p;
      // 移动p指针
      p = temp;
   }
   // 返回反转后的链表头结点
   return newH;
}
struct Node *constructList(void){
   //头结点定义
   struct Node *head = NULL;
   struct Node *cur = NULL;
   for (int i = 1; i < 5; i ++) {
       struct Node *node = malloc(sizeof( struct Node));
       node ->data = i;
       //头结点为空，a新节点即为头结点
       if (head == NULL) {
         head = node;
       }
       //当前结点的next为新节点
       else{
          cur -> next = node;
       }
       cur = node;
   }
   return  head;

}

void printList(struct Node*head){
   struct Node *temp = head;
   while (temp != NULL) {
    printf("node is %d \n",temp ->data);
    temp = temp -> next;
   }

}

//2...字符串反转(和上面不是一个算发)
void char_reverse (char * cha){
  //定义头部指针 尾部指针
  char *begin = cha;
  char *end = cha + strlen(cha) -1;
  while (begin <end) {
    char temp = *begin;
    *(begin ++) = *end;
    *(end--) = temp;
  }
  
}
//3...// 将有序数组a和b的值合并到一个数组result当中，且仍然保持有序
void mergeList(int a[], int aLen, int b[], int bLen, int result[])
{
    int p = 0; // 遍历数组a的指针
    int q = 0; // 遍历数组b的指针
    int i = 0; // 记录当前存储位置
    
    // 任一数组没有到达边界则进行遍历
    while (p < aLen && q < bLen) {
        // 如果a数组对应位置的值小于b数组对应位置的值
        if (a[p] <= b[q]) {
            // 存储a数组的值
            result[i] = a[p];
            // 移动a数组的遍历指针
            p++;
        }
        else{
            // 存储b数组的值
            result[i] = b[q];
            // 移动b数组的遍历指针
            q++;
        }
        // 指向合并结果的下一个存储位置
        i++;
    }
    
    // 如果a数组有剩余
    while (p < aLen) {
        // 将a数组剩余部分拼接到合并结果的后面
        result[i] = a[p++];
        i++;
    }
    
    // 如果b数组有剩余
    while (q < bLen) {
        // 将b数组剩余部分拼接到合并结果的后面
        result[i] = b[q++];
        i++;
    }
}
@end

