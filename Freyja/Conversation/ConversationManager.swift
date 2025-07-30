//
//  Conversation.swift
//  Freyja
//
//  Created by Swathy Sudarsanan on 03/11/24.
//

import Foundation
import Combine
class ConversationManager: ConversationManagerProtocol {
    var starterMessages: Node = Node.createLinkedList([.welcome, .name])
    var idleConverationTree: ConversationTree? = {
        let conversations: [Node] = [
            // Original instruction branch
            Node.createLinkedList([.instructions1, .instructions2, .futureModes1, .futureModes2]),
            // Help suggestions branch
            Node.createLinkedList([.knobHelp, .slingshotHelp]),
            
            // Knob mode education branches
            Node.createLinkedList([.knob1, .knob2, .knob3]),
            Node.createLinkedList([.knob4, .knob5, .knob6]),
            Node.createLinkedList([.knob7, .knob8, .knob9]),
            Node.createLinkedList([.knob10, .knob11, .knob12]),
            Node.createLinkedList([.knob13, .knob14, .knob15]),
            
            // Slingshot mode education branches
            Node.createLinkedList([.slingshot1, .slingshot2, .slingshot3]),
            Node.createLinkedList([.slingshot4, .slingshot5, .slingshot6]),
            Node.createLinkedList([.slingshot7, .slingshot8, .slingshot9]),
            Node.createLinkedList([.slingshot10, .slingshot11, .slingshot12]),
            Node.createLinkedList([.slingshot13, .slingshot14, .slingshot15]),
            
            // Smart observations branches
            Node.createLinkedList([.smart1, .smart2, .smart3]),
            Node.createLinkedList([.smart4, .smart5, .smart6]),
            Node.createLinkedList([.smart7, .smart8, .smart9]),
            Node.createLinkedList([.smart10, .smart11, .smart12]),
            Node.createLinkedList([.smart13, .smart14, .smart15]),
            
            // Stars education branches
            Node.createLinkedList([.stars1, .stars2, .stars3]),
            Node.createLinkedList([.stars4, .stars5, .stars6]),
            Node.createLinkedList([.stars7, .stars8, .stars9]),
            Node.createLinkedList([.stars10, .stars11, .stars12]),
            Node.createLinkedList([.stars13, .stars14, .stars15]),
            
            // Universe education branches
            Node.createLinkedList([.universe1, .universe2, .universe3]),
            Node.createLinkedList([.universe4, .universe5, .universe6]),
            Node.createLinkedList([.universe7, .universe8, .universe9]),
            Node.createLinkedList([.universe10, .universe11, .universe12]),
            Node.createLinkedList([.universe13, .universe14, .universe15]),
            
            // Subtle disinterest branches
            Node.createLinkedList([.disinterest1, .disinterest2, .disinterest3]),
            Node.createLinkedList([.disinterest4, .disinterest5, .disinterest6]),
            Node.createLinkedList([.disinterest7, .disinterest8, .disinterest9]),
            Node.createLinkedList([.disinterest10, .disinterest11, .disinterest12]),
            Node.createLinkedList([.disinterest13, .disinterest14, .disinterest15]),
            
            // Sophisticated humor branches
            Node.createLinkedList([.humor1, .humor2, .humor3]),
            Node.createLinkedList([.humor4, .humor5, .humor6]),
            Node.createLinkedList([.humor7, .humor8, .humor9]),
            Node.createLinkedList([.humor10, .humor11, .humor12]),
            Node.createLinkedList([.humor13, .humor14, .humor15]),
            
            // Technical explanations branches
            Node.createLinkedList([.technical1, .technical2, .technical3]),
            Node.createLinkedList([.technical4, .technical5, .technical6]),
            Node.createLinkedList([.technical7, .technical8, .technical9]),
            Node.createLinkedList([.technical10, .technical11, .technical12]),
            Node.createLinkedList([.technical13, .technical14, .technical15]),
            
            // Philosophical observations branches
            Node.createLinkedList([.philosophy1, .philosophy2, .philosophy3]),
            Node.createLinkedList([.philosophy4, .philosophy5, .philosophy6]),
            Node.createLinkedList([.philosophy7, .philosophy8, .philosophy9]),
            Node.createLinkedList([.philosophy10, .philosophy11, .philosophy12]),
            Node.createLinkedList([.philosophy13, .philosophy14, .philosophy15]),
            
            // Casual observations branches
            Node.createLinkedList([.casual1, .casual2, .casual3]),
            Node.createLinkedList([.casual4, .casual5, .casual6]),
            Node.createLinkedList([.casual7, .casual8, .casual9]),
            Node.createLinkedList([.casual10, .casual11, .casual12]),
            Node.createLinkedList([.casual13, .casual14, .casual15]),
            
            // Encouragement with disinterest branches
            Node.createLinkedList([.encourage1, .encourage2, .encourage3]),
            Node.createLinkedList([.encourage4, .encourage5, .encourage6]),
            Node.createLinkedList([.encourage7, .encourage8, .encourage9]),
            Node.createLinkedList([.encourage10, .encourage11, .encourage12]),
            Node.createLinkedList([.encourage13, .encourage14, .encourage15]),
            
            // Mode switching hints branches
            Node.createLinkedList([.mode1, .mode2, .mode3]),
            Node.createLinkedList([.mode4, .mode5, .mode6]),
            Node.createLinkedList([.mode7, .mode8, .mode9]),
            Node.createLinkedList([.mode10, .mode11, .mode12]),
            Node.createLinkedList([.mode13, .mode14, .mode15]),
            
            // Subtle guidance branches
            Node.createLinkedList([.guide1, .guide2, .guide3]),
            Node.createLinkedList([.guide4, .guide5, .guide6]),
            Node.createLinkedList([.guide7, .guide8, .guide9]),
            Node.createLinkedList([.guide10, .guide11, .guide12]),
            Node.createLinkedList([.guide13, .guide14, .guide15]),
            
            // Idle observations branches
            Node.createLinkedList([.idle1, .idle2, .idle3]),
            Node.createLinkedList([.idle4, .idle5, .idle6]),
            Node.createLinkedList([.idle7, .idle8, .idle9]),
            Node.createLinkedList([.idle10, .idle11, .idle12]),
            Node.createLinkedList([.idle13, .idle14, .idle15])
        ]
        let tree = ConversationTree(root: RootNode(branches: conversations))
        return tree
    }()
    var futureMessage: ConversationMessages = .instructions1
    var currentMessagePublisher: CurrentValueSubject<String, Never> = .init(ConversationMessages.welcome.rawValue)
    var currentMode: ConversationMode = .start
    private var timer: Timer?
    private var idleTimer: Timer?
    func appOpened() {
        initTimer()
    }
    func appIdle() {
        timer?.invalidate()
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
        currentMode = .idle
        idleTimer = Timer.scheduledTimer(timeInterval: 16, target: self, selector: #selector(idleTimerTriggered), userInfo: nil, repeats: false)
    }
    @objc func idleTimerTriggered() {
        initTimer()
    }
    @objc func tick() {
        switch currentMode {
        case .start:
            if let next = starterMessages.next {
                starterMessages = next
                let message = starterMessages.value
                currentMessagePublisher.send(message.rawValue)
            } else {
                currentMode = .idle
                currentMessagePublisher.send("")
            }
        case .idle:
            if let currentNode = idleConverationTree?.currentNode {
                currentMessagePublisher.send(currentNode.value.rawValue)
                idleConverationTree?.currentNode = idleConverationTree?.currentNode?.next
            } else {
                idleConverationTree?.startNewConversation()
                if let currentNode = idleConverationTree?.currentNode {
                    currentMessagePublisher.send(currentNode.value.rawValue)
                }
            }
        }
    }
}
