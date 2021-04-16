//
//  MathReview.swift
//  MathAlgorithm
//
//  Created by Leo on 2021/3/8.
//  Copyright © 2021 dongdonghu. All rights reserved.
//

import Foundation

public class ListNode: NSObject {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        next = nil
    }

    public init(_ val: Int, _ next: ListNode?) {
        self.val = val
        self.next = next
    }
}

public class TreeNode: Comparable {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        left = nil
        right = nil
    }

    public static func < (lhs: TreeNode, rhs: TreeNode) -> Bool {
        return lhs.val == rhs.val
    }

    public static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
        return lhs.val == rhs.val
    }
}

class MathReview: NSObject {
    var node = TreeNode(1)
    var linkNode = ListNode(1)
    var num = 0
    @objc func initTreeNodes() {
//        node.left = TreeNode(1)
//        node.left?.left = TreeNode(3)
        node.right = TreeNode(2)
        node.right?.right = TreeNode(4)
        node.right?.right?.right = TreeNode(5)

        let linkNode2 = ListNode(2)
        let linkNode3 = ListNode(3)
        let linkNode4 = ListNode(4)

        linkNode.next = linkNode2
        linkNode2.next = linkNode3
        linkNode3.next = linkNode4
    }

    @objc func testNode() {
        let node = LinkNodeAbout()
        var listNode = node.initLinkNodes([1, 2, 3])
        while listNode != nil {
            print("listNode.值", listNode?.val)
            listNode = listNode?.next
        }
        print("11")
    }

    @objc func treeHeight() {
//        let xx = height(node.right)
//        print("获得二叉树右高度\(xx)")
//        diguiTest(3)
//        let fib = fiabo(7)
        let newHead = reverseLinNode1(linkNode)
        print("获得二叉树右高度")
//        abs(max(height(node.right), height(node.left))) + 1
    }

    func reverseList2(_ head: ListNode?) -> ListNode? {
        if head == nil || head?.next == nil {
        }
        return nil
    }

    // 翻转链表
    func reverseLinNode(_ head: ListNode?) -> ListNode? {
        print("循环开始")
        if head == nil || head?.next == nil {
            print("递...")
            return head
        }
        let new_head = reverseLinNode(head?.next)
        print("归...")
        let temp = head?.next
        temp?.next = head
        head?.next = nil
        return new_head
    }

    func reverseLinNode1(_ head: ListNode?) -> ListNode? {
        print("循环开始")
        var new_head: ListNode?
        var p = head
        while p != nil {
            let temp = p?.next
            // 当前结点的next指向新链表头部
            p?.next = new_head
            // 更改新链表头部为当前结点
            new_head = p
            // 移动p指针
            p = temp
        }
        return new_head
    }

    // 斐波那契
    func fiabo(_ n: Int) -> Int {
        if n < 2 {
            return n
        } else {
            return fiabo(n - 1) + fiabo(n - 2)
        }
    }

    func diguiTest(_ depth: Int) {
        var _depth = depth

        print("循环===")
        if _depth == 0 {
            print("结束了1==\(_depth)")

        } else {
            _depth -= 1
            diguiTest(_depth)
            print("值==\(_depth)")
        }
        print("结束了2==\(num)")
    }

    func height(_ node: TreeNode?) -> Int {
        print("循环===")
        if node == nil {
            print("结束===\n")
            return 0
        }
        var xx = height(node?.right)
        xx = xx + 1
        print("高度===\(xx)")
        print("值===\(node?.val ?? -100)\n")
        return xx
    }

    @objc public func test2(_ a1: String, _ b1: String) -> Int {
        var index = -1
        for i in 0 ... a1.count - b1.count {
            let a = a1.index(a1.startIndex, offsetBy: i)
            let b = a1.index(a1.startIndex, offsetBy: b1.count + i - 1)
            let result = String(a1[a ... b])
            if result == b1 {
                index = i
                return index
            }
            if index > -1 {
                break
            }
        }
        
        return -1
    }

    @objc public class func findTargetArr() {
        var nums = [1, 2, 3, 4]
        let xx = Solution1.findTargetArr(nums, 6)
        print("xx==", xx)
        numsArryPlusOne()
        let  sss = "111"
        let arr1 =  Array(sss)
        //测试代码
        let ranges = [0..<3, 8..<10, 15..<17]
        for index in ranges.joined() {
           print(index, terminator: " ")
       }
        
        let xx1 =  nums.index(1, offsetBy: 2)
        let xx2 =  nums.suffix(from: 2)
        let range = Range(0...2)
//        nums.removeSubrange(range)
//        nums.removeAll()
        let xx3 =    nums[range]
        
        let array = ["a", "b", "c", "d", "e", "f"]
        let range1:PartialRangeThrough = ...4
        let range2:PartialRangeFrom = 1...
        let range3:PartialRangeUpTo = ..<4
        
        print(array[range1])

        
    }

    @objc public class func numsArryPlusOne() {
        let nums = [1, 2, 5, 9]
        let xx = Solution1.numsArryPlusOne(nums)
        print("yy==", xx)
    }
}

class Solution: NSObject {
    // MARK: 一个二叉树, 找到该树中两个指定节点的最近公共祖先
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        if root == nil {
            return root
        }
        if root == p || root == q {
            return root
        }
        let left = lowestCommonAncestor(root?.left, p, q)
        let right = lowestCommonAncestor(root?.right, p, q)
        if left != nil && right != nil {
            return root
        } else if left != nil {
            return left
        } else if right != nil {
            return right
        }
        return nil
    }

    // 删除某个节点
    func deleteNode(_ node: ListNode) {
        let tempNode = node.next
        node.next = node.next?.next
        node.val = tempNode!.val
    }

    // MARK: 找到两个单链表相交的起始节点
    func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        return nil
    }
}

class Solution1 {
    // MARK: 1. 给你一个长度为 n 的整数数组 nums，其中 n > 1，返回输出数组 output ，其中 output[i] 等于 nums 中除 nums[i] 之外其余各元素的乘积。

    // 输入: [1,2,3,4]  输出: [24,12,8,6]
    @objc public func productExceptSelf(_ nums: [Int]) -> [Int] {
        let arr = [1, 2, 3]
        let x = arr[0]
        return [0, 1]
    }

    // MARK: 2. 给定一个字符串，请你找出其中不含有重复字符的 最长子串 的长度

    // 输入: s = "abcabcbb"
    // 输出: 3
    // 解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。
    func lengthOfLongestSubstring(_ s: String) -> Int {
        return 0
    }

    // MARK: 给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。

//    你可以假设每种输入只会对应一个答案。但是，你不能重复利用这个数组中同样的元素。
//    给定 nums = [2, 7, 11, 15], target = 9
//    因为 nums[0] + nums[1] = 2 + 7 = 9
//    所以返回 [0, 1]

    @objc public class func findTargetArr(_ nums: [Int], _ taget: Int) -> [Int] {
//        var map: [Int: Int] = [Int: Int]()

        for i in 0 ... nums.count - 1 {
            let diss = taget - nums[i]
            for j in 0 ... nums.count - 1 {
                if nums[j] == diss {
                    return [i, j]
                }
            }
        }
        return []
    }

    // MARK: 给定一个由整数组成的非空数组所表示的非负整数，在该数的基础上加一。

    // 最高位数字存放在数组的首位， 数组中每个元素只存储单个数字。
    // 你可以假设除了整数 0 之外，这个整数不会以零开头
    //  输入: [1,2,3]  输出: [1,2,4]  解释: 输入数组表示数字 123。
    class func numsArryPlusOne(_ arr: [Int]) -> [Int] {
        var nums = arr
        var carry = 1

        for i in (0 ... nums.count - 1).reversed() {
            let sum = nums[i] + carry
//            nums[i] = sum % 10
            if sum > 9 {
                nums[i] = sum - 10
                carry = 1

            } else {
                nums[i] = sum
                carry = 0
            }
        }
        if carry == 1 {
            nums.insert(1, at: 0)
        }
        return nums
    }


    // MARK: 查询相交链表的 相交节点

    class func setLinkNode(_ node1: ListNode?, _ node2: ListNode?) -> ListNode? {
        var interSet: Set<ListNode> = []

        var A: ListNode? = node1
        var B: ListNode? = node2

        while A != nil {
            interSet.insert(A!)
            A = A!.next
        }
        while B != nil {
            if interSet.contains(B!) {
                return B!
            }
            B = B?.next!
        }

        return ListNode(-1)
    }

    // MARK: 判断二叉树 是不对称二叉树

    func isMirroTree(_ node: ListNode) -> Bool {
        return true
    }
    

    // MARK: 回文链表
   //1-2-2-1 是，1-2-3不是
    func isPalindrome(_ head: ListNode?) -> Bool {
        var newHead = head
        var slow = head
        var fast = head
        var prev: ListNode?
        while fast != nil { // 找mid 节点
            slow = slow?.next
            fast = fast?.next == nil ? fast?.next?.next : fast?.next
        }
        while slow != nil {//翻转后半部分
            let temp = slow?.next
            slow?.next = prev
            prev = slow
            slow = temp
        }
        while newHead != nil && prev != nil {//比较
            if newHead?.val != prev?.val {
                return false
            }
            newHead = newHead?.next
            prev = prev?.next
        }
        return true
    }

    // MARK: 两数相加

    // 输入：l1 = [2,4,3], l2 = [5,6,4]
    // 输出：[7,0,8]
    // 解释：342 + 465 = 807.
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let temp = l1
        while l1 != nil {
            var _l1 = l1
            var _l2 = l2

            var carry = l1!.val + l2!.val
            var sum = 0
            if carry < 10 {
                carry = 0
                sum = carry
                temp?.val = sum
            } else {
                sum = carry - 10
                carry = 1
                temp?.val = sum
            }
            _l1 = _l1?.next
            _l2 = _l2?.next
            if _l2 == nil {
                temp?.next = _l1

            } else {
                temp?.next = _l2
            }
        }
        return temp
    }
}

class Solution2 {
    // MARK: 合并两个有序链表

    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        // 递归
//        if l1 == nil {
//            return l2
//        }
//        if l2 == nil {
//            return l1
//        }
//        if l1!.val < l2!.val {
//            l1?.next = mergeTwoLists(l1?.next, l2)
//            return l1
//        } else {
//            l2?.next = mergeTwoLists(l1, l2?.next)
//            return l2
//        }
        // 方法2归并排序中的合并过程
        let dummyNode = ListNode(0)
        var cur = dummyNode
        var _l1 = l1
        var _l2 = l2

        while _l1 != nil && _l2 != nil {
            if _l1!.val < _l2!.val {
                cur.next = _l1
                _l1 = _l1?.next

            } else {
                cur.next = _l2
                _l2 = _l2?.next
            }
            cur = cur.next!
        }
        if l1 == nil {
            cur.next = l2
        } else {
            cur.next = l1
        }

        return dummyNode.next
    }

    // MARK: 翻转单链表

    // 就地翻转
    func reverseList(_ head: ListNode?) -> ListNode? {
        var beg: ListNode?
        var end: ListNode?
        var newHead = head

        if head == nil || head?.next == nil {
            return newHead
        }
        beg = head
        end = head?.next
        while end != nil {
            // 把end 先移除
            beg?.next = end?.next
            end?.next = head
            newHead = end
            // 为下次循环准备
            end = beg?.next
        }
        return newHead
    }

    // 迭代发翻转
    func reverseList1(_ head: ListNode?) -> ListNode? {
        if head == nil || head?.next == nil {
            return head
        }
        var beg: ListNode?
        var mid = head
        var end = head?.next
        var nHead = head
        while true {
            mid?.next = beg
            if end == nil {
                break
            }
            beg = mid
            mid = end
            end = end?.next
        }
        nHead = mid
        return nHead
    }

    // 头插法反转链表
    func reverseList2(_ head: ListNode?) -> ListNode? {
        if head == nil || head?.next == nil {
            return head
        }
        var p = head
        var nHead: ListNode?

        while p != nil {
            let temp = p?.next
            // 将 temp 从 head 中摘除
            p?.next = nHead
            nHead = p
            p = temp
        }

        return nHead
    }
}
