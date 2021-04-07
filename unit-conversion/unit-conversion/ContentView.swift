//
//  ContentView.swift
//  unit-conversion
//
//  Created by Gabs on 2021-04-06.
//

import SwiftUI

enum UnitConversion: String {
    case length
    case temperature
    case mass
    
    var capitalized: String { return rawValue.capitalized }
    
    var units: [Dimension] {
        switch self {
        case .length:
            let lengths: [UnitLength] = [.centimeters, .meters, .miles, .feet, .furlongs, .kilometers]
            return lengths
        case .temperature:
            let temps: [UnitTemperature] = [.kelvin, .celsius, .fahrenheit]
            return temps
        case .mass:
            let mass: [UnitMass] = [.milligrams, .grams, .kilograms, .metricTons]
            return mass
        }
    }
    
    static func lengthTitle(for selectedInput: UnitLength) -> String {
        switch selectedInput {
        case .centimeters:
            return "cm"
        case .meters:
            return "m"
        case .miles:
            return "mi."
        case .feet:
            return "ft"
        case .furlongs:
            return "fur"
        case .kilometers:
            return "km"
        default:
            return selectedInput.description
        }
    }
    
    static func temperatureTitle(for selectedInput: UnitTemperature) -> String {
        switch selectedInput {
        case .celsius:
            return "C"
        case .fahrenheit:
            return "F"
        case .kelvin:
            return "K"
        default:
            return selectedInput.description
        }
    }
    
    static func massTitle(for selectedInput: UnitMass) -> String {
        switch selectedInput {
        case .grams:
            return "g"
        case .kilograms:
            return "kg"
        case .metricTons:
            return "t"
        case .milligrams:
            return "mg"
        default:
            return selectedInput.description
        }
    }
}

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
    
    var conversionUnits: [UnitConversion] = [.length, .temperature, .mass]
    
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
            return UnitConversion.lengthTitle(for: dimension as! UnitLength)
        case .temperature:
            return UnitConversion.temperatureTitle(for: dimension as! UnitTemperature)
        case .mass:
            return UnitConversion.massTitle(for: dimension as! UnitMass)
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
