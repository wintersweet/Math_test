//
//  LFU_LRU.swift
//  MathAlgorithm
//
//  Created by Leo on 2021/3/18.
//  Copyright © 2021 dongdonghu. All rights reserved.
//

import Foundation

class Node: NSObject {
    public var key: Int?
    public var value: Int?
    public var next: Node?
    public var prev: Node?
    public init(_ value: Int, _ key: Int) {
        self.value = value
        self.key = key
        next = nil
    }
}

// LRU实现
class DoubleList: NSObject {
    var _head: Node?
    var _tail: Node?
//    var dic = Dictionary<Int, NSObject>()
    var count = 0
    override init() {
        _head = Node(-1, -1)
        _tail = Node(-1, -1)
        _head?.next = _tail
        _tail?.prev = _head
    }

    func addNodeAtHead(_ node: Node) {
//        dic[node.key!] = node
        // 放在头节点 还是 替换？
        node.next = _head?.next
        node.prev = _head
        _head?.next?.prev = node
        _head?.next = node
        //
//        node.next = _head?.next
//        node.prev = _head?.prev
//        _head = node
        count += 1
    }

    func removeNode(_ node: Node) {
        node.prev?.next = node.next
        node.next?.prev = node.prev
        count -= 1
    }

    func removeLast() -> Node {
        let node = _tail?.prev
        _tail?.prev = _tail?.prev?.prev
        _tail?.prev?.next = _tail
        count -= 1
        return node!
    }

    func moveNodeToFirst(_ node: Node) {
        removeNode(node)
        addNodeAtHead(node)
    }

    func size() -> Int {
        return count
    }
}

// 淘汰 访问时间最旧的
// 1.新数据插入到链表头部；
// 2.每当缓存命中（即缓存数据被访问），则将数据移到链表头部
// 3.当链表满的时候，将链表尾部的数据丢弃
class LRUCatch {
    var capacity = 0
    var map = [Int: Node]()
    let center = DoubleList()
    init(_ capacity: Int) {
        self.capacity = capacity
    }

    func get(_ key: Int) -> Int {
        if map.keys.contains(key) {
            let node = map[key]
            center.moveNodeToFirst(node!)
        }
        return -1
    }

    func put(_ key: Int, _ value: Int) {
        let node = Node(key, value)
        if map.keys.contains(key) {
            center.removeNode(node)
            center.addNodeAtHead(node)
        } else if center.size() == capacity {
            let key = center.removeLast().key!
            map.removeValue(forKey: key)
            map[key] = node
        }
    }
}

class Nodes: Comparable {
    static func < (lhs: Nodes, rhs: Nodes) -> Bool {
        return lhs == rhs
    }

    static func == (lhs: Nodes, rhs: Nodes) -> Bool {
        return lhs == rhs
    }

    public var key: Int?
    public var value: Int?
    public var next: Nodes?
    public var prev: Nodes?
    public var freq = 1
    var doubleList: DoubleListF?
    public init(_ value: Int, _ key: Int) {
        self.value = value
        self.key = key
        next = nil
    }

    public init() {
    }
}

// 淘汰 使用次数最少的
// 1. 新加入数据插入到队列尾部（因为引用计数为1）；
// 2. 队列中的数据被访问后，引用计数增加，队列重新排序；
// 3. 当需要淘汰数据时，将已经排序的列表最后的数据块删除
class LFUCatch {
    var cache: [Int: Nodes]?
    var firstDouble: DoubleListF?
    var lastDouble: DoubleListF?
    var size = 0
    var capacity = 0
    init(_ capcaitys: Int) {
        cache = [Int: Nodes]()
        firstDouble = DoubleListF()
        lastDouble = DoubleListF()
        firstDouble?.next = lastDouble
        lastDouble?.pre = firstDouble
        capacity = capcaitys
    }

    func get(_ key: Int) -> Int {
        let node = cache![key]
        if node == nil {
            return -1
        }
        return node!.value!
    }

    func put(_ key: Int, _ value: Int) {
        if capacity == 0 {
            return
        }
        let node = cache![key]
        if node != nil {
            node?.value = value
            freqIn(node!)
        } else {
            // 如果缓存满了，删除lastLinkedList.pre链表中的tail.pre的Node，如果该链表中的元素删空了，则删掉该链表
            if size == capacity {
                cache?.removeValue(forKey: (lastDouble?.pre?.tail?.key)!)
                lastDouble?.removeNode((lastDouble?.pre?.tail?.prev)!)
                size -= 1
                if lastDouble?.pre?.head?.next == lastDouble?.pre?.tail {
                    removeDoubleList(lastDouble!.pre!)
                }
            }
            let newNode = Nodes(key, value)
            cache![key] = newNode
            if lastDouble?.pre?.freq != 1 {
                let newDoubleLinked = DoubleListF(1)
                addDoubleLinkedList(newDoubleLinked, (lastDouble?.pre)!)
                newDoubleLinked.addNode(node!)
            } else {
                lastDouble?.pre?.addNode(newNode)
            }
            size += 1
        }
    }

    func freqIn(_ node: Nodes) {
        // 将node从原freq对应的链表里移除, 如果链表空了则删除链表
        let linkedList = node.doubleList
        let preLinedList = linkedList?.pre
        linkedList?.removeNode(node)
        if linkedList?.head?.next == linkedList?.tail {
            removeDoubleList(linkedList!)
        }
        // 将node加入新freq对应的链表，若该链表不存在，则先创建该链表
        node.freq += 1
        if preLinedList?.freq != node.freq {
            let newDoubleLinkedList = DoubleListF(node.freq)
            addDoubleLinkedList(newDoubleLinkedList, preLinedList!)
            newDoubleLinkedList.addNode(node)
        } else {
            preLinedList?.addNode(node)
        }
    }

    func addDoubleLinkedList(_ newDoubleNode: DoubleListF, _ preDoubleNode: DoubleListF) {
        newDoubleNode.next = preDoubleNode.next
        newDoubleNode.next?.pre = newDoubleNode
        newDoubleNode.pre = preDoubleNode
        preDoubleNode.next = newDoubleNode
    }

    func removeDoubleList(_ douleNodeList: DoubleListF) {
        douleNodeList.pre?.next = douleNodeList.next
        douleNodeList.next?.pre = douleNodeList.pre
    }
}

class DoubleListF: Comparable {
    static func < (lhs: DoubleListF, rhs: DoubleListF) -> Bool {
        return lhs == rhs
    }

    static func == (lhs: DoubleListF, rhs: DoubleListF) -> Bool {
        return lhs == rhs
    }

    var freq = 1
    var pre: DoubleListF?
    var next: DoubleListF?
    var head: Nodes?
    var tail: Nodes?
    init() {
        head = Nodes()
        tail = Nodes()
        head?.next = tail
        tail?.prev = head
    }

    init(_ freq: Int) {
        head = Nodes()
        tail = Nodes()
        head?.next = tail
        tail?.prev = head
        self.freq = freq
    }

    func removeNode(_ node: Nodes) {
        node.prev?.next = node.next
        node.next?.prev = node.prev
    }

    func addNode(_ node: Nodes) {
        node.next = head?.next
        head?.next?.prev = node
        head?.next = node
        node.prev = head
        node.doubleList = self
    }
}

class FIFOCatch: NSObject {
    var arr: [Any]?
    var count = 0

    override init() {
        count = 0
    }

    func push(_ obj: AnyObject) {
        arr?.insert(obj, at: arr!.count - 1)
        count = arr!.count
    }

    func pop(_ obj: AnyObject) {
        if count == 0 {
            return
        }
        arr?.removeFirst()
        count = arr!.count
    }
}
