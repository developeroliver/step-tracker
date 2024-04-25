//
//  HealthDetailListView.swift
//  Step tracker
//
//  Created by olivier geiger on 25/04/2024.
//

import SwiftUI

struct HealthDetailListView: View {
    
    @State private var isShowingAddData = false
    @State private var addDataDate: Date = .now
    @State private var valueToAdd: String = ""
    
    var metric: HealthMetricContext
     
    var body: some View {
        List(0..<20) {_ in
            HStack {
                Text(getDate())
                Spacer()
                Text(10000, format: .number.precision(.fractionLength(metric == .steps ? 0 : 1)))
            }
        }
        .navigationTitle(metric.title)
        .sheet(isPresented: $isShowingAddData) {
            addDataView
        }
        .toolbar {
            Button(action: {
                isShowingAddData.toggle()
            }, label: {
                Image(systemName: "plus")
            })
        }
    }
    
    var addDataView: some View {
        NavigationStack {
            Form {
                DatePicker("Date", selection: $addDataDate, displayedComponents: .date)
                    .environment(\.locale, Locale(identifier: "fr_FR"))
                HStack {
                    Text(metric.title)
                    Spacer()
                    TextField("Valeur", text: $valueToAdd)
                        .multilineTextAlignment(.trailing)
                        .frame(width: 140)
                        .keyboardType(metric == .steps ? .numberPad : .decimalPad)
                }
            }
            .navigationTitle(metric.title)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        // Do code later
                    }, label: {
                        Text("Ajouter")
                    })
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        isShowingAddData = false
                    }, label: {
                        Text("Annuler")
                    })
                }
            }
        }
    }
    
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fr_FR")
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let dateString = dateFormatter.string(from: Date())
        return dateString
    }
    
}

#Preview {
    HealthDetailListView(metric: .weight)
}
