//
//  AppButton.swift
//  POPatterns
//
//  Created by Алексей Авер on 20.03.2024.
//

import SwiftUI

struct AppButton: View {
    let color: Color
    let textColor: Color
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        }label: {
            Text(title)
                .foregroundColor(textColor)
                .font(Font.custom(.iMedium, size: 15))
                .padding()
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(RoundedRectangle(cornerRadius: 15)
                                            .foregroundColor(color))
                        
        }
    }
}

#Preview {
    AppButton(color: .blue, textColor: .white, title: "button") {
        
    }
}
