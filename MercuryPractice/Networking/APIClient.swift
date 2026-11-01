import Foundation

enum APIError: Error {
    case badResponse
}

struct APIClient {
    var baseURL: URL = Config.baseURL

    /// GET {baseURL}/transactions.json
    func fetchTransactions() async throws -> [Transaction] {
        let response: TransactionsResponse = try await get("transactions.json")
        return response.transactions
    }

    /// GET {baseURL}/account.json
    func fetchAccount() async throws -> Account {
        try await get("account.json")
    }

    /// Fetches a path and decodes the JSON into whatever type the caller asks for.
    private func get<T: Decodable>(_ path: String) async throws -> T {
        let url = baseURL.appendingPathComponent(path)
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else {
            throw APIError.badResponse
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601   // "2026-10-31T16:05:00Z" -> Date
        return try decoder.decode(T.self, from: data)
    }
}
