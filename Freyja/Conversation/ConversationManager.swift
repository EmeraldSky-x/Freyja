//
//  Conversation.swift
//  Freyja
//
//  Created by Swathy Sudarsanan on 03/11/24.
//

import Foundation
import Combine
class ConversationManager: ConversationManagerProtocol {
    var starterMessages: Node = Node.createLinkedList([.welcome, .name, .instructions])
    
    var idleConverationTree: ConversationTree? = {
        let conversations: [Node] = [
            Node.createLinkedList([.instructions, .futureModes]),
            Node.createLinkedList([.knobHelp, .slingshotHelp]),
        ]
        let tree = ConversationTree(root: RootNode(branches: conversations))
        return tree
    }()
    
    
    
    
    var futureMessage: ConversationMessages = .instructions
    var currentMessagePublisher: CurrentValueSubject<ConversationMessages, Never> = .init(.welcome)
    var currentMode: ConversationMode = .start
    private var timer: Timer?
    private var idleTimer: Timer?
    func appOpened() {
        initTimer()
    }
    func appIdle() {
        timer?.invalidate()
        initTimer()
    }
    func appActive() {
        timer?.invalidate()
        idleTimer?.invalidate()
        idleConverationTree?.currentNode = nil
        timer = nil
        idleTimer = nil
        initIdleTimer()
    }
    private func initTimer() {
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }
    private func initIdleTimer() {
        idleTimer = Timer.scheduledTimer(timeInterval: 16, target: self, selector: #selector(idleTimerTriggered), userInfo: nil, repeats: true)
    }
    @objc func idleTimerTriggered() {
        initTimer()
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
            if let currentNode = idleConverationTree?.currentNode {
                currentMessagePublisher.send(currentNode.value)
                idleConverationTree?.currentNode = idleConverationTree?.currentNode?.next
            } else {
                idleConverationTree?.startNewConversation()
                if let currentNode = idleConverationTree?.currentNode {
                    currentMessagePublisher.send(currentNode.value)
                }
            }
            
        }
    }
}
