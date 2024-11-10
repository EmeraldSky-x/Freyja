//
//  HomeModuleBuilder.swift
//  Freyja
//
//  Created by Swathy Sudarsanan on 07/11/24.
//

import UIKit

class HomeModuleBuilder {
    static func build() -> UIViewController {
        let vc = HomeController()
        let conversationManager = ConversationManager()
        vc.conversationManager = conversationManager
        return vc
    }
}
