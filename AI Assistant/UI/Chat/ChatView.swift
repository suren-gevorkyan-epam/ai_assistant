//
//  ChatView.swift
//  AI Assistant
//
//  Created by Suren Gevorkyan on 23.12.24.
//

import SwiftUI

struct ChatView: View {
    @Environment(\.dismiss) var dismiss

    @ObservedObject
    private(set) var viewModel: ChatViewModel

    @FocusState
    private var isTextFieldFocused: Bool

    @FocusState
    private var isAlertPresented: Bool

    @State
    private var input: String = ""

    var body: some View {
        NavigationView {
            VStack {
                ScrollViewReader { scrollViewProxy in
                    List {
                        ForEach(viewModel.messages) { message in
                            MessageView(message: message)
                                .listRowSeparator(.hidden)
                                .contextMenu {
                                    Button {
                                        UIPasteboard.general.string = message.text
                                    } label: {
                                        HStack {
                                            Image(systemName: "document.on.document")
                                            Text("Copy")
                                        }
                                    }
                                }
                        }

                        if viewModel.isProcessingPrompt {
                            TypingIndicatorView()
                                .id(-1)
                                .padding(16)
                                .background {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(.gray.mix(with: .white, by: 0.7))
                                }
                                .listRowSeparator(.hidden)
                        }
                    }
                    .listStyle(.plain)
                    .onChange(of: viewModel.messages) { _, newValue in
                        Task { @MainActor in
                            guard let lastMessage = viewModel.messages.last else { return }
                            try await Task.sleep(for: .seconds(0.05))
                            withAnimation {
                                scrollViewProxy.scrollTo(lastMessage.id, anchor: .bottom)
                            }
                        }
                    }
                    .onChange(of: viewModel.isProcessingPrompt) { _, value in
                        if value {
                            scrollViewProxy.scrollTo(-1, anchor: .bottom)
                        }
                    }
                }

                TextField("Enter object description", text: $input, axis: .vertical)
                    .lineLimit(4)
                    .textFieldStyle(.roundedBorder)
                    .focused($isTextFieldFocused)
                    .onSubmit {
                        viewModel.process(input: input)
                        isTextFieldFocused = false
                        input = ""
                    }
                    .submitLabel(.send)
                    .disabled(viewModel.busy)
                    .padding()
            }
        }
        .onAppear {
            viewModel.initialize()
        }
        .overlay {
            if viewModel.busy {
                ProgressView()
                    .foregroundStyle(.black)
                    .bold()
                    .progressViewStyle(.circular)
                    .ignoresSafeArea()
            }
        }
        .alert("Something went wrong", isPresented: .constant(viewModel.error != nil)) {
            Button("Ok") {
                dismiss()
            }
        }
        .onDisappear {
            viewModel.clearResources()
        }
    }
}
