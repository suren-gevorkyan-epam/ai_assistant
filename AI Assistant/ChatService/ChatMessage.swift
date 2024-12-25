//
//  ChatMessage.swift
//  AI Assistant
//
//  Created by Suren Gevorkyan on 23.12.24.
//

import Foundation

enum ChatParticipant {
    case user
    case assistant
}

struct ChatMessage: Identifiable, Equatable, Hashable {
    let id = UUID()

    let sender: ChatParticipant

    var text: String
}
