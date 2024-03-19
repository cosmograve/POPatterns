//
//  CustomFont.swift
//  POPatterns
//
//  Created by Алексей Авер on 20.03.2024.
//

import SwiftUI

enum CustomFont: String {
    case iBold = "Inter-Bold"
    case iMedium = "Inter-Medium"
}

extension Font {
    static func custom(_ font: CustomFont, size: CGFloat) -> SwiftUI.Font {
        SwiftUI.Font.custom(font.rawValue, size: size)
    }
}
