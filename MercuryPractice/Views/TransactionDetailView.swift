import SwiftUI

struct TransactionDetailView: View {
    let transaction: Transaction

    var body: some View {
        Text("TODO: \(transaction.counterpartyName)")
    }
}

#Preview {
    NavigationStack {
        TransactionDetailView(transaction: .mock)
    }
}
