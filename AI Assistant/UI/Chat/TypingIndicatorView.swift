//
//  TypingIndicatorView.swift
//  AI Assistant
//
//  Created by Suren Gevorkyan on 25.12.24.
//

import SwiftUI

struct TypingIndicatorView: View {
    @State private var shouldAnimate = false
    
    var body: some View {
        HStack(spacing: 5) {
            ForEach(0..<3) { index in
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(Color.gray)
                    .scaleEffect(shouldAnimate ? 1 : 0.5)
                    .animation(
                        Animation.easeInOut(duration: 0.6)
                            .repeatForever()
                            .delay(Double(index) * 0.2),
                        value: shouldAnimate
                    )
            }
        }
        .onAppear {
            shouldAnimate = true
        }
    }
}

#Preview {
    TypingIndicatorView()
}
