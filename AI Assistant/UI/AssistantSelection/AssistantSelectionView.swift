//
//  AssistantSelectionView.swift
//  AI Assistant
//
//  Created by Suren Gevorkyan on 23.12.24.
//

import SwiftUI

struct AssistantSelectionView: View {
    @ObservedObject
    private(set) var viewModel: AssistantSelectionViewModel

    @State
    private var chatConfigViewPresented: Bool = false

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.assistants, id: \.title) { header in
                    Section {
                        ForEach(header.assistants, id: \.modelDescription) { assistant in
                            NavigationLink {
                                ChatView(viewModel: ChatViewModel(assistant: assistant))
                            } label: {
                                HStack(alignment: .top) {
                                    Image(systemName: "sparkles")
                                        .symbolRenderingMode(.palette)
                                        .foregroundStyle(.yellow)

                                    Text(assistant.modelDescription)
                                        .font(.system(size: 16, weight: .regular))
                                        .multilineTextAlignment(.leading)
                                }
                                .foregroundStyle(.black)
                            }
                        }
                    } header: {
                        Text(header.title)
                    } footer: {
                        Text(header.subtitle)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("AI Assistant")
            .sheet(isPresented: $chatConfigViewPresented) {
                ChatConfigView()
            }
        }
    }
}

#Preview {
    AssistantSelectionView(viewModel: AssistantSelectionViewModel())
}
