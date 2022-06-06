//
//  BottomCardSegue.swift
//  DesignPantomime
//
//  Created by mohammad najafzade on 5/25/19.
//  Copyright © 2019 mohammad najafzade. All rights reserved.
//

import Foundation
import SwiftMessages

class BottomCard: SwiftMessagesSegue {
    override public  init(identifier: String?, source: UIViewController, destination: UIViewController) {
        super.init(identifier: identifier, source: source, destination: destination)
        configure(layout: .bottomCard)
        dimMode = .blur(style: .dark, alpha: 0.9, interactive: true)
        messageView.configureNoDropShadow()
    }
}

class centered: SwiftMessagesSegue {
    override public  init(identifier: String?, source: UIViewController, destination: UIViewController) {
        super.init(identifier: identifier, source: source, destination: destination)
        configure(layout: .centered)
        dimMode = .blur(style: .dark, alpha: 0.9, interactive: true)
        messageView.configureNoDropShadow()
    }
}
class lockedCentered: SwiftMessagesSegue {
    override public  init(identifier: String?, source: UIViewController, destination: UIViewController) {
        super.init(identifier: identifier, source: source, destination: destination)
        configure(layout: .centered)
        dimMode = .blur(style: .dark, alpha: 0.9, interactive: false)
        interactiveHide = false
        messageView.configureNoDropShadow()
    }
}

class bottomMessage: SwiftMessagesSegue {
    override public  init(identifier: String?, source: UIViewController, destination: UIViewController) {
        super.init(identifier: identifier, source: source, destination: destination)
        configure(layout: .bottomMessage)
        dimMode = .blur(style: .dark, alpha: 0.9, interactive: true)
        messageView.configureNoDropShadow()
    }
}
