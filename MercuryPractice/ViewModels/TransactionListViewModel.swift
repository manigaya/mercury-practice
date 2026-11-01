import Foundation

@MainActor
@Observable
final class TransactionListViewModel {
    /// One enum instead of separate isLoading / error / items properties,
    /// so the screen can never be "loading" and "failed" at the same time.
    enum State {
        case loading
        case loaded([Transaction])
        case failed(String)
    }

    var state: State = .loading
    var account: Account?

    private let client: APIClient

    /// Taking the client as a parameter lets tests pass in a fake one.
    init(client: APIClient = APIClient()) {
        self.client = client
    }

    func load() async {
        if case .loaded = state {
            // Keep showing the list while refreshing; pull to refresh shows its own spinner.
        } else {
            state = .loading
        }

        do {
            let transactions = try await client.fetchTransactions()
            state = .loaded(transactions.sorted { $0.postedAt > $1.postedAt })
        } catch {
            state = .failed("We couldn't load your transactions. Check your connection and try again.")
        }

        // The balance header is a nice-to-have, so a failure here shouldn't block the list.
        account = try? await client.fetchAccount()
    }
}
