//
//  ChatViewModel.swift
//  AI Assistant
//
//  Created by Suren Gevorkyan on 23.12.24.
//

import Foundation

final class ChatViewModel: ObservableObject {
    private let assistant: Assistant

    @Published
    private(set) var messages: [ChatMessage] = []

    @Published
    private(set) var busy: Bool = false

    @Published
    private(set) var isProcessingPrompt: Bool = false

    @Published
    private(set) var error: Error?

    init(assistant: Assistant) {
        self.assistant = assistant
    }

    func initialize() {
        busy = true

        Task {
            do {
                try await assistant.initialize()
            } catch {
                await MainActor.run {
                    self.error = error
                }
            }

            await MainActor.run {
                self.busy = false
            }
        }
    }

    func clearResources() {
        messages.removeAll()
        assistant.clearResources()
    }

    func process(input: String) {
        guard !input.isEmpty else { return }

        self.messages.append(ChatMessage(sender: .user, text: input))

        isProcessingPrompt = true

        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let output = try self.assistant.process(prompt: input)
                
                DispatchQueue.main.async {
                    self.isProcessingPrompt = false
                    self.messages.append(
                        ChatMessage(
                            sender: .assistant,
                            text: output.trimmingCharacters(in: .whitespacesAndNewlines)
                        )
                    )
                }
            } catch {
                self.error = error
            }
        }
    }
}
