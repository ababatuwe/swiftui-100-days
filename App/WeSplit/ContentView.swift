import SwiftUI

enum Meal: String, Identifiable, CaseIterable {
    case breakfast
    case lunch
    case snack
    case dinner
    
    var capitalized: String { return rawValue.capitalized }
    var id: String { return rawValue }
}

struct ContentView: View {
    @State var meals: [Meal]
    
    var body: some View {
        NavigationView {
            Form {
                ForEach(meals) {
                    MealView(meal: $0)
                }
            }
            .navigationBarTitle(Text("Meals"), displayMode: .large)
        }
    }
}

struct MealView: View {
    var meal: Meal
    
    var body: some View {
        Text(meal.capitalized)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(meals: Meal.allCases)
    }
}
