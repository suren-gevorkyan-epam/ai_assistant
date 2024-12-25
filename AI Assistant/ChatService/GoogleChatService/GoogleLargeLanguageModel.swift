//
//  GoogleLargeLanguageModel.swift
//  AI Assistant
//
//  Created by Suren Gevorkyan on 23.12.24.
//

import Foundation

enum GoogleLargeLanguageModel: LargeLanguageModelPath {
    case gemma_1
    case gemma_2
    case gemmma_2_CPU
    case gemma2_2_CPU

    var fileName: String {
        switch self {
        case .gemma_1: 
            return "gemma-1.1-2b-it-gpu-int4"
        case .gemma_2: 
            return "gemma-2b-it-gpu-int4"
        case .gemmma_2_CPU:
            return "gemma-2b-it-cpu-int8"
        case .gemma2_2_CPU:
            return "gemma2-2b-it-cpu-int8"
        }
    }

    var fileExtension: String {
        switch self {
        case .gemma2_2_CPU:
            return "task"
        case .gemma_1, .gemma_2, .gemmma_2_CPU:
            return "bin"
        }
    }
}
