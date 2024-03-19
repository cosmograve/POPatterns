//
//  PnlAssistantView.swift
//  POPatterns
//
//  Created by Алексей Авер on 19.03.2024.
//

import SwiftUI

struct PnlAssistantView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = PnlAssistantViewModel()
    @State private var showingResult = false
    var body: some View {
        VStack {
            Text("PNL ASSISTANT")
                .foregroundStyle(.black)
                .font(Font.custom(.iBold, size: 35))
                .minimumScaleFactor(0.5)
            Button {
                dismiss()
            } label: {
                HStack {
                    Image("leftArrow")
                    Text("BACK TO PATTERNS")
                        .foregroundStyle(.black)
                        .font(Font.custom(.iMedium, size: 15))
                    
                }
                .padding(.vertical, 21)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.white))
                .padding(.horizontal, 24)
            }
            
            if !showingResult {
                Text("PNL (Profit and Loss) is a crucial term in the context of trading and investing. It represents the net financial outcome of a trading position or investment over a certain period. You can calculate it by deducting the whole cost of purchasing an asset or investment from the total revenue you get when selling it.")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.black)
                    .font(Font.custom(.iMedium, size: 13))
                    .padding(.horizontal, 14)
                    .padding(.vertical, 40)
                    .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                    .padding(.horizontal, 24)
                    .padding(.bottom)
                
                TextField("", text: Binding<String>(
                    get: { vm.entryPrice.map { String($0) } ?? "" },
                    set: { vm.entryPrice = Double($0) }
                ))
                
                .keyboardType(.decimalPad)
                .foregroundStyle(.appBlue)
                .font(Font.custom(.iMedium, size: 15))
                    .overlay(
                        Text("Entry Price")
                            .allowsHitTesting(false)
                            .foregroundStyle(.appBlue)
                            .font(Font.custom(.iMedium, size: 15))
                            .padding(.leading, 5)
                            .opacity(vm.entryPrice == nil ? 1 : 0)
                        , alignment: .leading
                    )
                    
                    .padding(.horizontal, 14)
                    .padding(.vertical, 22)
                    .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                    .padding(.horizontal, 25)
                
                TextField("", text: Binding<String>(
                    get: { vm.exitPrice.map { String($0) } ?? "" },
                    set: { vm.exitPrice = Double($0) }
                ))
                .keyboardType(.decimalPad)
                .foregroundStyle(.appBlue)
                .font(Font.custom(.iMedium, size: 15))
                    .overlay(
                        Text("Exit Price")
                            .allowsHitTesting(false)
                            .foregroundStyle(.appBlue)
                            .font(Font.custom(.iMedium, size: 15))
                            .padding(.leading, 5)
                            .opacity(vm.exitPrice == nil ? 1 : 0)
                        , alignment: .leading
                    )
                    .padding(.horizontal, 14)
                    .padding(.vertical, 22)
                    .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                    .padding(.horizontal, 25)
                
                TextField("", text: Binding<String>(
                    get: { vm.sharesAmount.map { String($0) } ?? "" },
                    set: { vm.sharesAmount = Double($0) }
                ))
                .keyboardType(.decimalPad)
                .foregroundStyle(.appBlue)
                .font(Font.custom(.iMedium, size: 15))
                    .overlay(
                        Text("Shares Amount")
                            .allowsHitTesting(false)
                            .foregroundStyle(.appBlue)
                            .font(Font.custom(.iMedium, size: 15))
                            .padding(.leading, 5)
                            .opacity(vm.sharesAmount == nil ? 1 : 0)
                        , alignment: .leading
                    )
                    .padding(.horizontal, 14)
                    .padding(.vertical, 22)
                    .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                    .padding(.horizontal, 25)
                
                TextField("", text: Binding<String>(
                    get: { vm.feesPercentage.map { String($0) } ?? "" },
                    set: { vm.feesPercentage = Double($0) }
                ))
                .keyboardType(.decimalPad)
                .foregroundStyle(.appBlue)
                .font(Font.custom(.iMedium, size: 15))
                    .overlay(
                        Text("Fees Percentage")
                            .allowsHitTesting(false)
                            .foregroundStyle(.appBlue)
                            .font(Font.custom(.iMedium, size: 15))
                            .padding(.leading, 5)
                            .opacity(vm.feesPercentage == nil ? 1 : 0)
                        , alignment: .leading
                    )
                    .padding(.horizontal, 14)
                    .padding(.vertical, 22)
                    .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                    .padding(.horizontal, 25)
                
            } else {
                Spacer()
                VStack(spacing: 15) {
                    Text("\(vm.profitLabel) \(String(format: "%.2f", vm.profit))")
                        .foregroundStyle(.black)
                        .font(Font.custom(.iMedium, size: 20))
                    Text("or")
                        .foregroundStyle(.black)
                        .font(Font.custom(.iMedium, size: 20))
                    Text(vm.profitType == .loss ? "-\(String(format: "%.2f", vm.profitPercentage))%" : "\(String(format: "%.2f", vm.profitPercentage))%")
                        .foregroundStyle(.appBlue)
                        .font(Font.custom(.iBold, size: 30))
                        .frame(maxWidth: .infinity)
                }
                .padding(43)
                .background(RoundedRectangle(cornerRadius: 15).fill(.white))
                .padding(25)
                Spacer()
            }
            Spacer()
            AppButton(color: .white, textColor: .appBlue, title: !showingResult ? "CALCULATE PNL" : "RECALCULATE") {
                showingResult = !showingResult
                if !showingResult {
                    vm.entryPrice = nil
                    vm.exitPrice = nil
                    vm.sharesAmount = nil
                    vm.feesPercentage = nil
                }
            }
            .disabled(vm.entryPrice == nil || vm.exitPrice == nil || vm.sharesAmount == nil)
            .padding(23)
        }
        .mainViewModifier()
        .onTapGesture {
            hideKeyboard()
        }
    }
}

#Preview {
    PnlAssistantView()
}
