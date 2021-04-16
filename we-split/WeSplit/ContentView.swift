import SwiftUI

struct CurrencyModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

extension View {
    func displayCurrency() -> some View {
        self.modifier(CurrencyModifier())
    }
}

struct ContentView: View {
    
    @State private var checkAmount = ""
    @State private var selectedNumberOfPeople = ""
    @State private var selectedTipPercentage = 2
    let tipPercentages = [10, 15, 20, 25, 0]
    
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
    
    private var amountSection: some View {
        Section {
            HStack {
                Text("Total bill")
                Spacer()
                TextField("Amount", text: $checkAmount)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
            }
            
            HStack {
                Text("Split between")
                Spacer()
                TextField("Number of people", text: $selectedNumberOfPeople)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.trailing)
            }
        }
    }
    private var tipSection: some View {
        let header = Text("How much tip do you want to leave?").font(.headline)
        return Section(header: header) {
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
    }
    private var splitsSection: some View {
        Section {
            HStack {
                Text("Split cost")
                Text("$ \(totalPerPerson, specifier: "%.2f")")
                    .displayCurrency()
            }
        }
    }
    private var grandTotalSection: some View {
        let tipAlert: Bool = (selectedTipPercentage == 4)
        return Section {
            HStack {
                Text("Grand Total")
                Text("$ \(checkTotal, specifier: "%.2f")")
                    .displayCurrency()
                    .foregroundColor(tipAlert ? .red : .green)
            }
            
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                amountSection
                tipSection
                splitsSection
                grandTotalSection
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
        Group {
            ContentView()
            ContentView()
        }
    }
}
