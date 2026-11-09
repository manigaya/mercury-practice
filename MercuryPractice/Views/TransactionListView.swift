import SwiftUI

struct TransactionListView: View {
    
    @State private var viewModel = TransactionListViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.transactions){
                transaction in
                HStack{
                    VStack (alignment: .leading){
                        Text(transaction.counterpartyName)
//                        Text("\(transaction.amount)")
//                        Text(transaction.amount, format: .currency(code: "USD"))
                        HStack(spacing: 2) {
                            Text(transaction.amount > 0 ? "+" : "−")
                                .foregroundStyle(transaction.amount > 0 ? Color.green : Color.red)
                                .bold()
                            Text(abs(transaction.amount), format: .currency(code: "USD"))
                        }
//                        Text("\(transaction.postedAt)")
                        Text(transaction.postedAt.formatted(date:.abbreviated, time: .shortened))
                    }
                 Spacer()
                    
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
