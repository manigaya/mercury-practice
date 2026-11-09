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
    
    private let client = APIClient()
    
    func load() async {
        do{
            let fetched = try await client.fetchTransactions()
            transactions = fetched.sorted {$0.postedAt > $1.postedAt}
        }
        catch{
            print("failed to load transactions: ", error)
        }
    }
}
