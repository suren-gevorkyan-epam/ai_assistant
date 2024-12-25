//
//  PersonalAssistant.swift
//  AI Assistant
//
//  Created by Suren Gevorkyan on 25.12.24.
//

import Foundation

final class PersonalAssistant: Assistant {
    let chatService: any ChatService

    var name: String {
        "Personal Assistant"
    }

    var description: String {
        "Delegate some of your tasks to the helpful Personal Assistant"
    }

    var modelDescription: String {
        chatService.description
    }

    @Published
    var messages: [ChatMessage] = []

    init(chatService: any ChatService) {
        self.chatService = chatService
    }

    func initialize() async throws {
        try chatService.initialize()
    }

    func clearResources() {
        chatService.clearResources()
    }

    func process(prompt: String) throws -> String {
        return try chatService.process(prompt: prompt)
    }
}
