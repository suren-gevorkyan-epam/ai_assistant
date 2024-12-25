//
//  AssistantSelectionViewModel.swift
//  AI Assistant
//
//  Created by Suren Gevorkyan on 23.12.24.
//

import Foundation

struct AssistantsHeader {
    let title: String
    let subtitle: String
    let assistants: [Assistant]
}

final class AssistantSelectionViewModel: ObservableObject {
    @Published
    private(set) var assistants: [AssistantsHeader] = [
        AssistantsHeader(
            title: "JSON Parsing Assistants",
            subtitle: "Easily parse textual representations of JSON data into formatted JSON objects",
            assistants: [
                JsonParsingAssistant(
                    chatService: GoogleChatService(
                        config: ChatConfig(
                            modelPath: GoogleLargeLanguageModel.gemma_2
                        )
                    )
                ),
                JsonParsingAssistant(
                    chatService: GoogleChatService(
                        config: ChatConfig(
                            modelPath: GoogleLargeLanguageModel.gemmma_2_CPU
                        )
                    )
                ),
                JsonParsingAssistant(
                    chatService: GoogleChatService(
                        config: ChatConfig(
                            modelPath: GoogleLargeLanguageModel.gemma2_2_CPU
                        )
                    )
                )
            ]
        ),
        AssistantsHeader(
            title: "Personal Assistants",
            subtitle: "Delegate some of your tasks to the helpful Personal Assistant",
            assistants: [
                PersonalAssistant(
                    chatService: GoogleChatService(
                        config: ChatConfig(
                            modelPath: GoogleLargeLanguageModel.gemmma_2_CPU
                        )
                    )
                ),
                PersonalAssistant(
                    chatService: GoogleChatService(
                        config: ChatConfig(
                            modelPath: GoogleLargeLanguageModel.gemma2_2_CPU
                        )
                    )
                )
            ]
        )
    ]
}
