//
//  ConversationContract.swift
//  Freyja
//
//  Created by Swathy Sudarsanan on 05/11/24.
//

import Foundation
import Combine
protocol ConversationManagerProtocol: AnyObject {
    var currentMessagePublisher: CurrentValueSubject<ConversationMessages, Never> { get }
    func appOpened()
    func appIdle()
}
