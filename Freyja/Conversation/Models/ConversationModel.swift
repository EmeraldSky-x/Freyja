//
//  ConversationModel.swift
//  Freyja
//
//  Created by Swathy Sudarsanan on 05/11/24.
//

import Foundation
enum ConversationMessages: String, CaseIterable, Equatable {
    case welcome = "Hi..."
    case name = "I'm Freyja"
    case instructions1 = "You may use\ntwo modes now"
    case instructions2 = "KNOB\n&\nSLINGSHOT"
    
    case futureModes1 = "More modes\n will be available..."
    case futureModes2 = "in the not so\n distant future"
    case knobHelp = "Maybe,\n\ntry using the Knob"
    case slingshotHelp = ".. Or the Slignshot"
    
}
enum ConversationMode {
    case start
    case idle
}
