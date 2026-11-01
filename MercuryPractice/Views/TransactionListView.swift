import SwiftUI

struct TransactionListView: View {
    @State private var viewModel = TransactionListViewModel()

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Transactions")
                .navigationDestination(for: Transaction.self) { transaction in
                    TransactionDetailView(transaction: transaction)
                }
        }
        .task { await viewModel.load() }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView("Loading transactions…")

        case .failed(let message):
            ContentUnavailableView {
                Label("Something went wrong", systemImage: "exclamationmark.triangle")
            } description: {
                Text(message)
            } actions: {
                Button("Try Again") {
                    Task { await viewModel.load() }
                }
                .buttonStyle(.borderedProminent)
            }

        case .loaded(let transactions):
            List {
                if let account = viewModel.account {
                    Section {
                        BalanceHeader(account: account)
                    }
                }

                Section("Recent activity") {
                    ForEach(transactions) { transaction in
                        NavigationLink(value: transaction) {
                            TransactionRow(transaction: transaction)
                        }
                    }
                }
            }
            .refreshable { await viewModel.load() }
        }
    }
}

struct TransactionRow: View {
    let transaction: Transaction

    var body: some View {
        HStack(spacing: 12) {
            InitialsIcon(name: transaction.counterpartyName)

            VStack(alignment: .leading, spacing: 2) {
                Text(transaction.counterpartyName)
                    .font(.body.weight(.medium))
                    .lineLimit(1)

                HStack(spacing: 6) {
                    Text(transaction.postedAt, format: .dateTime.month(.abbreviated).day())
                    if transaction.status != .posted {
                        StatusBadge(status: transaction.status)
                    }
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }

            Spacer()

            Text(transaction.formattedAmount)
                .strikethrough(transaction.status == .failed)
                .font(.body.monospacedDigit())
                .foregroundStyle(transaction.isIncoming ? Color.green : Color.primary)
        }
        .padding(.vertical, 4)
    }
}

#Preview("Live data") {
    TransactionListView()
}

#Preview("Rows") {
    List(Transaction.mocks) { TransactionRow(transaction: $0) }
}
