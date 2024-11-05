//
//  Conversation.swift
//  Freyja
//
//  Created by Swathy Sudarsanan on 03/11/24.
//

import Foundation
import Combine
enum ConversationMessages: String, CaseIterable, Equatable {
    case welcome = "Hi..."
    case name = "I'm Freyja"
    case instructions = "You may use\ntwo modes now.\n\nKnob and Slingshot"
    case futureModes = "More modes\n will be available...\n\n in the not so\n distant future"
}
enum ConversationMode {
    case start
    case idle
}
class ConversationManager {
    var starterMessages: Node = Node.createLinkedList([.welcome, .name, .instructions])
    var futureMessage: ConversationMessages = .instructions
    var currentMessagePublisher: CurrentValueSubject<ConversationMessages, Never> = .init(.welcome)
    var currentMode: ConversationMode = .start
    private var timer: Timer?
    func appOpened() {
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }
    func appIdle() {
        
    }
    @objc func tick() {
        print(currentMode)
        switch currentMode {
        case .start:
            if let next = starterMessages.next {
                starterMessages = next
                let message = starterMessages.value
                currentMessagePublisher.send(message)
            } else {
                currentMode = .idle
                currentMessagePublisher.send(futureMessage)
            }
        case .idle:
            if futureMessage == .instructions {
                futureMessage = .futureModes
            } else {
                futureMessage = .instructions
            }
            currentMessagePublisher.send(futureMessage)
        }
    }
}
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
