import SwiftUI

struct TransactionListView: View {
    
    @State private var viewModel = TransactionListViewModel()
    
    var body: some View {
        NavigationStack {
            Group{
                if viewModel.isLoading && viewModel.transactions.isEmpty{
                    ProgressView("Loading transactions...")
                }
                else if let message = viewModel.errorMessage{
                    ContentUnavailableView{
                        Label("Something went wrong", systemImage: "exclamationmark.triangle")
                    }description: {
                        Text(message)
                    }actions: {
                        Button("Try again"){
                            Task {await viewModel.load()}
                        }
                    }
                }
                else{
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
                            
                        }
                    }.refreshable {
                        await viewModel.load()
                    }
                }
            }
            .navigationTitle("Transactions").task {
                await viewModel.load()
            }
            
        }
    }
}

#Preview {
    TransactionListView()
}
