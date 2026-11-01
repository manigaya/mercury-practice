import SwiftUI

struct TransactionDetailView: View {
    let transaction: Transaction

    var body: some View {
        List {
            Section {
                VStack(spacing: 8) {
                    InitialsIcon(name: transaction.counterpartyName, size: 64)
                    Text(transaction.formattedAmount)
                        .font(.system(size: 40, weight: .semibold, design: .rounded))
                        .foregroundStyle(transaction.isIncoming ? Color.green : Color.primary)
                    Text(transaction.counterpartyName)
                        .font(.title3)
                    StatusBadge(status: transaction.status)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)
            }
            .listRowBackground(Color.clear)

            Section("Details") {
                LabeledContent("Date", value: transaction.postedAt.formatted(date: .abbreviated, time: .shortened))
                LabeledContent("Method", value: transaction.method)
                LabeledContent("Category", value: transaction.category)
            }

            if let note = transaction.note {
                Section("Note") {
                    Text(note)
                }
            }
        }
        .navigationTitle(transaction.counterpartyName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        TransactionDetailView(transaction: .mock)
    }
}
