import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    /**
                     Documentation: https://developer.apple.com/documentation/swiftui/pickerstyle
                     **/
                }
                
                Section {
                    Text("$ \(checkAmount)")
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
