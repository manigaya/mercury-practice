import Foundation

enum APIError: Error {
    case badResponse
}

struct APIClient {
    var baseURL: URL = Config.baseURL

    /// GET {baseURL}/transactions.json
    func fetchTransactions() async throws -> [Transaction] {
        // TODO: Implement
        let url = baseURL.appendingPathComponent("transactions.json")
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else{
            throw APIError.badResponse
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let decoded = try decoder.decode(TransactionsAPIResponse.self, from: data)
        return decoded.transactions
    }
}
