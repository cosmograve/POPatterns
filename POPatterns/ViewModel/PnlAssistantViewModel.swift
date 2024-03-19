//
//  PnlAssistantViewModel.swift
//  POPatterns
//
//  Created by Алексей Авер on 20.03.2024.
//

import SwiftUI
import Combine

enum ProfitType {
    case profit, loss
}

class PnlAssistantViewModel: ObservableObject {
    @Published var entryPrice: Double?
    @Published var exitPrice: Double?
    @Published var sharesAmount: Double?
    @Published var feesPercentage: Double?
    
    @Published var profit: Double = 0
    @Published var profitPercentage: Double = 0
    @Published var profitLabel = ""
    
    @Published var profitType: ProfitType?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $entryPrice
            .combineLatest($exitPrice, $sharesAmount, $feesPercentage)
            .map { entry, exit, shares, fees -> (Double, Double) in
                guard let entry = entry, let exit = exit, let shares = shares else {
                    return (0, 0)
                }
                
                var feesAmount: Double = 0
                if let fees = fees, fees >= 0 {
                    let rawProfit = (exit - entry) * shares
                    feesAmount = rawProfit * (fees / 100.0)
                }
                
                let rawProfit = (exit - entry) * shares
                let netProfit = rawProfit - feesAmount
                let totalInvestment = entry * shares
                
                var percentage: Double
                if netProfit >= 0 {
                    percentage = totalInvestment != 0 ? (netProfit / totalInvestment) * 100 : 0
                    self.profitLabel = "PROFIT: "
                    self.profitType =  .profit
                } else {
                    percentage = -((netProfit / totalInvestment) * 100)
                    self.profitLabel = "LOSS: "
                    self.profitType = .loss
                }
                return (netProfit, percentage)
            }
            .sink { [weak self] netProfit, percentage in
                self?.profit = netProfit
                self?.profitPercentage = percentage
            }
            .store(in: &cancellables)
    }
    
}

