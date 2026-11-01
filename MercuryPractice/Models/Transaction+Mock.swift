import Foundation

/// Sample data for SwiftUI previews, so you can design screens without hitting the network.
extension Transaction {
    static let mocks: [Transaction] = [
        Transaction(id: "mock_1", counterpartyName: "Stripe", amount: 12450.00, postedAt: .now,
                    status: .pending, method: "ACH", category: "Revenue", note: "Weekly payout"),
        Transaction(id: "mock_2", counterpartyName: "Amazon Web Services", amount: -1240.18, postedAt: .now.addingTimeInterval(-86_400),
                    status: .posted, method: "Card", category: "Software", note: nil),
        Transaction(id: "mock_3", counterpartyName: "Uber", amount: -41.20, postedAt: .now.addingTimeInterval(-172_800),
                    status: .failed, method: "Card", category: "Travel", note: "Card declined — merchant retry"),
    ]

    static let mock = mocks[0]
}
