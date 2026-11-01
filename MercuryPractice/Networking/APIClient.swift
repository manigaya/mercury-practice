import Foundation

enum APIError: Error {
    case notImplemented
}

struct APIClient {
    var baseURL: URL = Config.baseURL

    /// GET {baseURL}/transactions.json
    func fetchTransactions() async throws -> [Transaction] {
        // TODO: Implement
        throw APIError.notImplemented
    }
}
