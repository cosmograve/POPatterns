//
//  PatternDetailView.swift
//  POPatterns
//
//  Created by Алексей Авер on 19.03.2024.
//

import SwiftUI

struct PatternDetailView: View {
    @EnvironmentObject var vm: ViewModel
    @Environment(\.dismiss) var dismiss
    var selectedIndex: Int
    init(selectedIndex: Int) {
        self.selectedIndex = selectedIndex
    }
    var body: some View {
        VStack {
            Text("\(vm.patterns[selectedIndex].name)")
                .foregroundStyle(.black)
                .font(Font.custom(.iBold, size: 35))
                .minimumScaleFactor(0.5)
            
            Image(vm.patterns[selectedIndex].image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: getRect().height / 4)
                .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                .padding(.bottom)
            ScrollView {
                Text(vm.patterns[selectedIndex].description)
                    .foregroundStyle(.black)
                    .font(Font.custom(.iMedium, size: 15))
                    .padding()
            }
            .scrollIndicators(.hidden)
            .background(RoundedRectangle(cornerRadius: 15).fill(.white))
            
            AppButton(color: .white, textColor: .appBlue, title: vm.patterns[selectedIndex].isFavorite ? "REMOVE FROM FAVORITES" : "ADD TO FAVORITES") {
                vm.toggleFavoritePattern(on: selectedIndex)
            }
            AppButton(color: .white, textColor: .appBlue, title: "BACK TO LIST") {
                dismiss()
            }

        }
        .padding(24)
        .mainViewModifier()
    }
}

#Preview {
    PatternDetailView(selectedIndex: 0)
        .environmentObject(ViewModel())
}
