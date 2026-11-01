import SwiftUI

struct TransactionListView: View {
    var body: some View {
        NavigationStack {
            Text("Transactions will go here")
                .navigationTitle("Transactions")
        }
    }
}

#Preview {
    TransactionListView()
}
