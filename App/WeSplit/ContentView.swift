import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = ""
    @State private var selectedNumberOfPeople = ""
    @State private var selectedTipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    /// Calculates the total per person
    var totalPerPerson: Double {
        let peopleCount = Double(selectedNumberOfPeople) ?? 1
        let tipSelection = Double(tipPercentages[selectedTipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        return grandTotal / peopleCount
    }
    
    var checkTotal: Double {
        let tipSelection = Double(tipPercentages[selectedTipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        return orderAmount + tipValue
    }
    
    
    var body: some View {
            NavigationView {
                Form {
                    Section {
                        TextField("Amount", text: $checkAmount)
                            .keyboardType(.decimalPad)
                        
                        TextField("NumberOfPeople", text: $selectedNumberOfPeople)
                            .keyboardType(.decimalPad)
                    }
                    Section(header: Text("How much tip do you want to leave?")) {
                        Picker("Tip percentage", selection: $selectedTipPercentage) {
                            ForEach(0 ..< tipPercentages.count) {
                                Text("\(self.tipPercentages[$0])%")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        /**
                           Documentation: https://developer.apple.com/documentation/swiftui/pickerstyle
                         **/
                    }
                    
                    Section(header: Text("Amount per person")) {
                        Text("$ \(totalPerPerson, specifier: "%.2f")")
                    }
                    
                    Section(header: Text("Total amount")) {
                        Text("$ \(checkTotal, specifier: "%.2f")")
                    }

                }
                .navigationBarTitle("WeSplit")
                /**
                  "NavigationViews are capable of showing many views as the program runs; attaching the title to the 'view' inside the navigation view lets iOS to change titles freely." - https://www.hackingwithswift.com/books/ios-swiftui/creating-pickers-in-a-form
                 **/
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
