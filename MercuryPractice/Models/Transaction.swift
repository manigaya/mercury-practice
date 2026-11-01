import Foundation

/// A single transaction on the account.
/// Matches one item in the `transactions` array returned by `GET /transactions.json`.
struct Transaction: Identifiable, Hashable, Decodable {
    let id: String
    let counterpartyName: String
    /// Positive = money in, negative = money out.
    let amount: Double
    let postedAt: Date
    let status: Status
    let method: String
    let category: String
    let note: String?

    enum Status: String, Hashable, Decodable {
        case posted
        case pending
        case failed
    }
}

/// The API wraps the array: `{ "transactions": [...] }`
struct TransactionsResponse: Decodable {
    let transactions: [Transaction]
}

extension Transaction {
    var isIncoming: Bool { amount > 0 }

    /// "+$12,450.00" for money in, "−$1,240.18" for money out.
    var formattedAmount: String {
        let dollars = abs(amount).formatted(.currency(code: "USD"))
        return isIncoming ? "+\(dollars)" : "−\(dollars)"
    }
}
