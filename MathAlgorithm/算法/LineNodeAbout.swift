//
//  LineNode.swift
//  MathAlgorithm
//
//  Created by Leo on 2021/3/19.
//  Copyright © 2021 dongdonghu. All rights reserved.
//

import Foundation

class LinkNodeAbout {
    // 生产链表
    func initLinkNodes(_ arr: [Int]) -> ListNode? {
        var head = ListNode(-1)
        var temp: ListNode?
        var cur = head
        var index = 0
        for i in 0 ... arr.count - 1 {
            temp = ListNode(arr[i])
            temp?.next = nil
            cur.next = temp
            cur = temp!
        }
        head = head.next!
        return head
    }

    // MARK: 找出链表 倒数第K个数

    func searchKnode(_ head: ListNode?, _ k: Int) -> ListNode? {
        var count = 0
        var cur = head
        var next = head?.next
        while cur != nil {
            cur = cur?.next
            count += 1
        }
        for _ in 0 ... count - k {
            next = next?.next
        }
        return next
    }

    // 快慢指针
    func searchKnode1(_ head: ListNode?, _ k: Int) -> ListNode? {
        var count = 0
        var cur = head
        var fast = head?.next, slow = head?.next
        var index = 0
        for i in 0 ... k {
            index = i
            if fast != nil {
                fast = fast?.next
            }
        }
        while fast != nil {
            slow = slow?.next
            fast = fast?.next
        }

        return slow
    }
}
