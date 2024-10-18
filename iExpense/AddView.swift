//
//  AddView.swift
//  iExpense
//
//  Created by Иван Семикин on 28/09/2024.
//

import SwiftUI
import SwiftData

struct AddView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Query var expenses: [ExpenseItem]
    
    @State private var name = "Title"
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var currency = "USD"
    
    private let types = ["Business", "Personal"]
    private let currencies = ["USD", "PLN", "CAD"]
    
    var body: some View {
        NavigationStack {
            Form {
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                HStack {
                    TextField("Amount", value: $amount, format: .number)
                        .keyboardType(.decimalPad)
                    
                    Picker("", selection: $type) {
                        ForEach(currencies, id: \.self) {
                            Text($0)
                        }
                    }
                }
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let item = ExpenseItem(
                            name: name,
                            type: type,
                            amount: amount,
                            currency: currency
                        )
                        modelContext.insert(item)
                        dismiss()
                    }
                }
            }
        }
    }
}
