//
//  MathReview.swift
//  MathAlgorithm
//
//  Created by Leo on 2021/3/8.
//  Copyright © 2021 dongdonghu. All rights reserved.
//

import Foundation

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
        let nums = [1, 2, 3, 4]
        let xx = Solution1.findTargetArr(nums, 6)
        print("xx==", xx)
        numsArryPlusOne()
    }

    @objc public class func numsArryPlusOne() {
        let nums = [1, 2, 5, 9]
        let xx = Solution1.numsArryPlusOne(nums)
        print("yy==", xx)
    }
}

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        next = nil
    }
}

// 一个二叉树, 找到该树中两个指定节点的最近公共祖先
class Solution: NSObject {
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

    // 找到两个单链表相交的起始节点
    func getIntersectionNode(_ headA: ListNode?, _ headB: ListNode?) -> ListNode? {
        return nil
    }
}

class Solution1 {
    // 1. 给你一个长度为 n 的整数数组 nums，其中 n > 1，返回输出数组 output ，其中 output[i] 等于 nums 中除 nums[i] 之外其余各元素的乘积。
    // 输入: [1,2,3,4]  输出: [24,12,8,6]
    @objc public func productExceptSelf(_ nums: [Int]) -> [Int] {
        let arr = [1, 2, 3]
        let x = arr[0]
        return [0, 1]
    }

    // 2. 给定一个字符串，请你找出其中不含有重复字符的 最长子串 的长度
    // 输入: s = "abcabcbb"
    // 输出: 3
    // 解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。
    func lengthOfLongestSubstring(_ s: String) -> Int {
        return 0
    }

//    给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。
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

    // 给定一个由整数组成的非空数组所表示的非负整数，在该数的基础上加一。
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

    // 给定一个字符串，请你找出其中不含有重复字符的 最长子串 的长度
    // 输入: s = "abcabcbb"
    // 输出: 3
    // 解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3
    class func lengthOfLongestSubstring(_ s: String) -> Int {
        let left = 0
        let right = 0
        let length = 0
        var arr = [String]()
        while right < s.count {
        }

        return 3
    }
}
