//
//  AI_AssistantApp.swift
//  AI Assistant
//
//  Created by Suren Gevorkyan on 23.12.24.
//

import SwiftUI

@main
struct AI_AssistantApp: App {
    var body: some Scene {
        WindowGroup {
            AssistantSelectionView(viewModel: AssistantSelectionViewModel())
        }
    }
}
