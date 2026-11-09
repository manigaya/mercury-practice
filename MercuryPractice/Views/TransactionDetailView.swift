import SwiftUI

struct TransactionDetailView: View {
    let transaction: Transaction

    var body: some View {
//        Text("TODO: \(transaction.counterpartyName)")
        List{
            Section{
                VStack(spacing: 8){
                    HStack(spacing: 2){
                        Text(transaction.amount > 0 ? "+" : "−")
                            .foregroundStyle(transaction.amount > 0 ? Color.green : Color.red)
                            .bold()
                        Text(abs(transaction.amount), format: .currency(code: "USD"))
                      
                    }.font(.system(size:40, weight: .semibold, design: .rounded))
                    
                    Text(transaction.counterpartyName).font(.title3).foregroundStyle(.secondary)
                }.frame(maxWidth: .infinity).padding(.vertical)
            }
            
            Section("Details"){
                LabeledContent("Status:", value: transaction.status.rawValue.capitalized)
                LabeledContent("Date", value: transaction.postedAt.formatted(date: .abbreviated, time: .shortened))
                LabeledContent("Method", value: transaction.method)
                LabeledContent("Category", value: transaction.category)
            }
                // Note: only if there is one
                          if let note = transaction.note {
                              Section("Note") {
                                  Text(note)
                              }
                          }
          
        }
    }
}

#Preview {
    NavigationStack {
        TransactionDetailView(transaction: .mock)
    }
}
