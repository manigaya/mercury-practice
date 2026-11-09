//
//  TransactionListViewModel.swift
//  MercuryPractice
//
//  Created by Manisha Eleperuma on 2026-11-09.
//

import Foundation

@MainActor
@Observable
final class TransactionListViewModel{
    var transactions: [Transaction] = []
    var isLoading = false
    var errorMessage: String?
    
    private let client = APIClient()
    
    func load() async {
        isLoading = true
        errorMessage = nil
        try? await Task.sleep(for: .seconds(2)) 
        do{
            let fetched = try await client.fetchTransactions()
            transactions = fetched.sorted {$0.postedAt > $1.postedAt}
        }
        catch{
            print("failed to load transactions: ", error)
            errorMessage = "Could not load txs"
        }
        isLoading = false
    }
}
