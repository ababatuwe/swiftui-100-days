import Foundation

enum UnitConverter: String {
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
