import SwiftUI

struct TransactionListView: View {
    
    @State private var viewModel = TransactionListViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.transactions){
                transaction in
                HStack{
                    Text(transaction.counterpartyName)
                    Spacer()
                    Text("\(transaction.amount)")
                }
            }.navigationTitle("Transactions").task {
                await viewModel.load()
            }
            
        }
    }
}

#Preview {
    TransactionListView()
}
