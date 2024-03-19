//
//  PatternsView.swift
//  POPatterns
//
//  Created by Алексей Авер on 19.03.2024.
//

import SwiftUI

struct PatternsView: View {
    @EnvironmentObject var vm: ViewModel
    @State private var isFavoritesViewSelected = false
    @State private var selectedIndex: Int?
    @State private var showDetail = false
    @State private var showAssistant = false
    var body: some View {
        VStack {
            HStack {
                Button {
                    isFavoritesViewSelected = false
                } label: {
                    Text("PATTERNS")
                        .foregroundStyle(!isFavoritesViewSelected ? .black : .gray)
                        .font(Font.custom(.iBold, size: 32))
                        .minimumScaleFactor(0.5)
                }
                Spacer()
                Button {
                    isFavoritesViewSelected = true
                } label: {
                    Text("FAVORITES")
                        .foregroundStyle(isFavoritesViewSelected ? .black : .gray)
                        .font(Font.custom(.iBold, size: 32))
                        .minimumScaleFactor(0.5)
                }
            }
            .padding(15)
            
            Button {
                showAssistant.toggle()
            } label: {
                HStack {
                    Text("PNL ASSISTANT")
                        .foregroundStyle(.black)
                        .font(Font.custom(.iMedium, size: 15))
                    Image("rightArrow")
                }
                .padding(.vertical, 21)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.white))
                .padding(.horizontal, 24)
            }
            ScrollView {
                ForEach(!isFavoritesViewSelected ? vm.patterns : vm.patterns.filter {$0.isFavorite}) { pattern in
                    Button {
                        selectedIndex = vm.patterns.firstIndex(of: pattern)
                        showDetail.toggle()
                    } label: {
                        HStack {
                            Text(pattern.name)
                                .foregroundStyle(.appBlue)
                                .font(Font.custom(.iBold, size: 25))
                                .minimumScaleFactor(0.5)
                            Spacer()
                            Image("bigRightArrow")
                        }
                        .padding(.vertical, 58)
                        .padding(.horizontal, 13)
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.white))
                        .padding(.horizontal, 24)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .mainViewModifier()
        .navigationDestination(isPresented: $showDetail) {
            if let selectedIndex = selectedIndex {
                PatternDetailView(selectedIndex: selectedIndex)
                    .navigationBarBackButtonHidden()
                    .environmentObject(vm)
            }
        }
        .navigationDestination(isPresented: $showAssistant) {
            PnlAssistantView()
                .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    PatternsView()
        .environmentObject(ViewModel())
}
