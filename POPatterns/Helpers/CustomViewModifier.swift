//
//  CustomViewModifier.swift
//  POPatterns
//
//  Created by Алексей Авер on 19.03.2024.
//

import SwiftUI

struct CustomViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            LinearGradient(colors: [.white, .appBlue, .appBlue], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            content
        }
    }
}

extension View {
    func mainViewModifier() -> some View {
        modifier(CustomViewModifier())
    }
}

