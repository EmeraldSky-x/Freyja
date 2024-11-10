//
//  Node.swift
//  Freyja
//
//  Created by Swathy Sudarsanan on 05/11/24.
//

import Foundation
class Node {
    var value: ConversationMessages
    var next: Node?
    init(value: ConversationMessages, next: Node? = nil) {
        self.value = value
        self.next = next
    }
    static func createLinkedList(_ messages: [ConversationMessages]) -> Node {
        var currentNode: Node?
        for value in messages.reversed() {
            let parentNode = Node(value: value)
            parentNode.next = currentNode
            currentNode = parentNode
        }
        return currentNode!
    }
}
class RootNode {
    var branches: [Node] = []
    init(branches: [Node]) {
        self.branches = branches
    }
}

class ConversationTree {
    var root: RootNode
    var currentNode: Node?
    init(root: RootNode) {
        self.root = root
    }
    func startNewConversation() {
        currentNode = root.branches.randomElement()
    }
}
