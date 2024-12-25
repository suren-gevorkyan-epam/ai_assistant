//
//  JsonParsingAssistant.swift
//  AI Assistant
//
//  Created by Suren Gevorkyan on 23.12.24.
//

import Foundation

final class JsonParsingAssistant: Assistant {
    let chatService: any ChatService

    var name: String {
        "JSON Parsing Assistant"
    }

    var description: String {
        "Easily parse textual representations of JSON data into formatted JSON objects"
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
        return try chatService.process(
            prompt: """
  You are a helpful assistant. Extract the following fields from the text describing an order, including author name, book title, price, customer name, and address. Some fields may be omitted, if not present in the text. Destination is a country, you can guess it from the list "Netherlands", "Germany", "France" based on the data (city can be a great hint). Extract customer's information into a JSON object. JSON fields to be filled are: {firstName:", "lastName:", mobileNumber:", destination:", postcode:", street:", houseNumber:", city:", product:",}. Only output the JSON object, no explanations or details are necessary. firstName and lastName should be the second name that occurs in the text. Process the following text: "\(prompt)"
  """
        )
    }
}
