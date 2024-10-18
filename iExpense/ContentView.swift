//
//  ContentView.swift
//  iExpense
//
//  Created by Иван Семикин on 27/09/2024.
//

import SwiftUI
import SwiftData

@Model
class ExpenseItem {
    var id = UUID()
    var name: String
    var type: String
    var amount: Double
    var currency: String
    
    init(id: UUID = UUID(), name: String, type: String, amount: Double, currency: String) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
        self.currency = currency
    }
}

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [ExpenseItem]
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(expenses.filter { $0.type == "Business" }) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: "\(item.currency)"))
                                .foregroundStyle(styleForAmount(item.amount))
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                
                Section {
                    ForEach(expenses.filter { $0.type == "Business" }) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: "\(item.currency)"))
                                .foregroundStyle(styleForAmount(item.amount))
                        }
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                NavigationLink(destination: AddView()) {
                    Label("Add Expense", systemImage: "plus")
                }
            }
        }
    }
    
    private func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            let item = expenses[offset]
            modelContext.delete(item)
        }
    }
    
    private func styleForAmount(_ amount: Double) -> Color {
        if amount < 10 {
            return .green
        } else if amount < 100 {
            return .orange
        } else {
            return .red
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: ExpenseItem.self)
}
