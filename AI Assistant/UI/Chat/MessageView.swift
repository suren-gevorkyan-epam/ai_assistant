//
//  MessageView.swift
//  AI Assistant
//
//  Created by Suren Gevorkyan on 23.12.24.
//

import SwiftUI

struct MessageView: View {
    let message: ChatMessage

    var body: some View {
        HStack {
            if message.sender == .user {
                Spacer()
            }

            Text(LocalizedStringKey(stringLiteral: message.text))
                .font(.body)
                .foregroundColor(message.sender == .user ? .white : .primary)
                .padding(8)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(message.sender == .user ? .blue : .gray.mix(with: .white, by: 0.7))
                }

            if message.sender == .assistant {
                Spacer()
            }
        }
    }
}

#Preview {
    MessageView(message: ChatMessage(sender: .assistant, text: "Test"))
}
