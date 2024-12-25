//
//  Assistant.swift
//  AI Assistant
//
//  Created by Suren Gevorkyan on 23.12.24.
//

import Foundation

protocol Assistant {
    var name: String { get }
    var description: String { get }
    var modelDescription: String { get }

    var messages: [ChatMessage] { get }

    var chatService: ChatService { get }

    func initialize() async throws

    func clearResources()

    func process(prompt: String) throws -> String
}
