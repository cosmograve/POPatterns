//
//  POPatternsApp.swift
//  POPatterns
//
//  Created by Алексей Авер on 19.03.2024.
//

import SwiftUI

@main
struct POPatternsApp: App {
    @StateObject var vm = ViewModel()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                PatternsView()
                    .environmentObject(vm)
            }
            .preferredColorScheme(.light)
        }
    }
}
