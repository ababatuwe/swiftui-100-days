import SwiftUI
import CoreML

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    
    private var coffeeIntake: String {
        return coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups"
    }
    
    @State private var recommendedSleepTime: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .datePickerStyle(WheelDatePickerStyle())
                }
                Section {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25, onEditingChanged: { _ in
                        calculateBedtime()
                    }, label: {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    })
                }
                
                Section {
                    Text("Daily coffee intake")
                        .font(.headline)
                    Stepper(value: $coffeeAmount, in: 1...20, onEditingChanged: { _ in
                        calculateBedtime()
                    }) {
                        Text(coffeeIntake)
                    }
                }
                
                Section {
                    Text("Your ideal bedtime is...")
                    Text(recommendedSleepTime)
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                }
            }
            .navigationBarTitle("Better Rest")
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 00
        
        return Calendar.current.date(from: components) ?? Date()
    }
    
    private func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        
            // Hour and minute are needed in seconds
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
        
        
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            recommendedSleepTime = formatter.string(from: sleepTime)
        } catch {
            recommendedSleepTime = "Sorry, there was a problem calculating your bedtime."
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

private extension Date {
    /// Current date and time
    static var now: Date {
        Date()
    }
    
    /// Set to one day (in seconds) from now
    static var tomorrow: Date {
        Date().addingTimeInterval(86400)
    }
}
