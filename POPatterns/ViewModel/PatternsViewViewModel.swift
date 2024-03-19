//
//  PatternsViewViewModel.swift
//  POPatterns
//
//  Created by Алексей Авер on 20.03.2024.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var patterns: [Pattern] = []
    
    init() {
        loadPatternsFromUserDefaults()
    }
    
    func toggleFavoritePattern(on index: Int) {
        self.patterns[index].isFavorite.toggle()
        savePatternsToUserDefaults()
        
    }
}

private extension ViewModel {
    func loadPatternsFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: "patterns") {
            self.patterns = try! JSONDecoder().decode([Pattern].self, from: data)
        } else {
            self.patterns = defaultPatternList
        }
    }
    
    func savePatternsToUserDefaults() {
        if let data = try? JSONEncoder().encode(self.patterns) {
            UserDefaults.standard.set(data, forKey: "patterns")
        }
    }
}
