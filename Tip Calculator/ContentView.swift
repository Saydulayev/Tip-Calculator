//
//  ContentView.swift
//  Tip Calculator
//
//  Created by Akhmed on 17.08.23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountisFocused: Bool
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalAmount: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountisFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    NavigationLink(destination: TipPercentageView(tipPercentage: $tipPercentage)) {
                        HStack {
                            Text("Tip percentage")
                                
                            Spacer()
                            Text("\(tipPercentage)%")
                                .foregroundColor(.blue)
                                .font(.subheadline)
                        }
                    }
                }
                
                Section(header: Text("Amount per person")) {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .font(.title)
                        .foregroundColor(.primary)
                }
                Section(header: Text("Total amount for the check")) {
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .font(.title)
                        .foregroundColor(.primary)
                }
            }
            .navigationTitle("Tip Calculator")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountisFocused = false
                    }
                }
            }
        }
    }
}

struct TipPercentageView: View {
    @Binding var tipPercentage: Int
    
    var body: some View {
        VStack {
            Text("Select Tip Percentage")
                .font(.title)
                .padding()
            
            Picker("Tip percentage", selection: $tipPercentage) {
                ForEach(0..<101) { percentage in
                    Text("\(percentage)%")
                        .font(.title)
                }
            }
            .pickerStyle(WheelPickerStyle())
            
            Spacer()
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
