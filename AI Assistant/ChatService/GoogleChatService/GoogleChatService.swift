//
//  GoogleChatService.swift
//  AI Assistant
//
//  Created by Suren Gevorkyan on 23.12.24.
//

import Foundation

import MediaPipeTasksGenAI
import MediaPipeTasksGenAIC

enum GoogleChatServiceError: Error {
    case invalidPrompt
    case modelNotFound
}

final class GoogleChatService: ChatService, ObservableObject {
    let config: ChatConfig

    private var llmInference: LlmInference?

    @Published
    private(set) var messages: [ChatMessage] = []

    var description: String {
        config.modelPath.fileName
    }

    init(config: ChatConfig) {
        self.config = config
    }

    func initialize() throws {
        let file = Bundle.main.path(
            forResource: config.modelPath.fileName,
            ofType: config.modelPath.fileExtension
        )

        guard let file else {
            throw GoogleChatServiceError.modelNotFound
        }

        let options =  MediaPipeTasksGenAI.LlmInference.Options(modelPath: file)

        self.llmInference = try LlmInference(options: options)
    }

    func clearResources() {
        self.llmInference = nil
    }

    func process(prompt: String) throws -> String {
        guard let llmInference else {
            throw GoogleChatServiceError.modelNotFound
        }

        guard !prompt.isEmpty else {
            throw GoogleChatServiceError.invalidPrompt
        }

        return try llmInference.generateResponse(inputText: prompt)
    }

    func process(prompt: String) async throws -> AsyncThrowingStream<String, any Error> {
        guard let llmInference else {
            throw GoogleChatServiceError.modelNotFound
        }
        
        guard !prompt.isEmpty else {
            throw GoogleChatServiceError.invalidPrompt
        }

        return llmInference.generateResponseAsync(inputText: prompt)
    }
}
