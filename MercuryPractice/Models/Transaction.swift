import Foundation

/// A single transaction on the account.
/// Matches one item in the `transactions` array returned by `GET /transactions.json`.
struct Transaction: Identifiable, Hashable {
    let id: String
    let counterpartyName: String
    /// Positive = money in, negative = money out.
    let amount: Double
    let postedAt: Date
    let status: Status
    let method: String
    let category: String
    let note: String?

    enum Status: String, Hashable {
        case posted
        case pending
        case failed
    }
}

// TODO: Transaction can't be decoded from JSON yet.
