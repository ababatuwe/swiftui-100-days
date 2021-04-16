import SwiftUI

struct ContentView: View {
    
    @State private var input: String = ""
    @State private var selectedInput: Int = 0
    @State private var selectedOutput: Int = 0
    @State private var selectedUnit: Int = 0 {
        didSet {
            selectedInput = 0
            selectedOutput = 0
        }
    }
    
    var conversionUnits: [UnitConverter] = [.length, .temperature, .mass]
    
    var units: [Dimension] {
        return conversionUnits[selectedUnit].units
    }
    
    var convertedOutput: Double {
        let toConvert = Double(input) ?? 0
        let inputUnit = units[selectedInput]
        let outputUnit = units[selectedOutput]
        let measurement = Measurement(value: toConvert, unit: inputUnit)
        return measurement.converted(to: outputUnit).value
    }
    
    func title(for index: Int) -> String {
        guard index >= 0 && index < units.count else { return "" }
        let dimension = units[index]
        let unit = conversionUnits[selectedUnit]
        switch unit {
        case .length:
            return UnitConverter.lengthTitle(for: dimension as! UnitLength)
        case .temperature:
            return UnitConverter.temperatureTitle(for: dimension as! UnitTemperature)
        case .mass:
            return UnitConverter.massTitle(for: dimension as! UnitMass)
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("What unit would you like to convert")) {
                    Picker("Input", selection: $selectedUnit) {
                        ForEach(0 ..< conversionUnits.count) {
                            Text("\(self.conversionUnits[$0].capitalized)")
                        }
                    }
                }
                
                Section(header: Text("Input")) {
                    TextField("Input", text: $input)
                        .keyboardType(.decimalPad)
                    Picker("Input", selection: $selectedInput) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.title(for:$0))")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Output")) {
                    Picker("Output", selection: $selectedOutput) {
                        ForEach(0 ..< units.count) {
                            Text("\(self.title(for:$0))")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    Text("\(convertedOutput, specifier: "%.4f")")
                }
            }
            .navigationBarTitle("Unit Converter", displayMode: .large)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
