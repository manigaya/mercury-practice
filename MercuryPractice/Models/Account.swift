import Foundation

/// Returned by `GET /account.json`.
struct Account: Decodable {
    let id: String
    let name: String
    let availableBalance: Double
    let currentBalance: Double
}
