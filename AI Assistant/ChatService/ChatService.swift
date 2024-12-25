//
//  ChatService.swift
//  AI Assistant
//
//  Created by Suren Gevorkyan on 23.12.24.
//

import Foundation

protocol ChatService {
    var description: String { get }

    func initialize() throws

    func clearResources()

    func process(prompt: String) throws -> String
    func process(prompt: String) async throws -> AsyncThrowingStream<String, any Error>
}
