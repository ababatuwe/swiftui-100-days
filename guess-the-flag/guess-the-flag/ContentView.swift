import SwiftUI

struct GuessTheFlag {
    private(set) var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    private(set) var score: Int = 0
    private(set) var correctAnswer = Int.random(in: 0...2)
    
    var expectedAnswer: String {
        country(at: correctAnswer)
    }
    
    mutating func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func country(at index: Int) -> String {
        guard index >= 0, index < countries.count else { return "" }
        return countries[index]
    }
    
    mutating func calculateAnswer(for selectedCountry: Int) -> String {
        if country(at: selectedCountry) == expectedAnswer {
            self.score = score + 5
            return "Correct"
        } else {
            return "Wrong! That's the flag of \(self.countries[selectedCountry])"
        }
    }
    
}

struct FlagImage: View {
    var country: String
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    @State var game = GuessTheFlag()
    @State private var scoreTitle = ""
    @State private var showingScore = false
    
    private var gradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [.blue, .yellow]), startPoint: .top, endPoint: .bottom)
    }
    
    private var questionView: some View {
        VStack(spacing: 30) {
            VStack {
                Text("Tap the flag of")
                Text(game.expectedAnswer)
                    .font(.largeTitle)
                    .fontWeight(.black)
            }
            ForEach(0 ..< 3) { number in
                Button(action: {
                    self.flagTapped(number)
                }, label: {
                    FlagImage(country: game.country(at: number))
                })
            }
            Text("Score: \(game.score)")
                .font(.body)
                .fontWeight(.medium)
            Spacer()
        }
    }
    
    var body: some View {
        ZStack {
            gradient
                .edgesIgnoringSafeArea(.all)
            questionView
        }.alert(isPresented: $showingScore, content: {
            Alert(title: Text(scoreTitle),
                  message: Text("Your score is \(game.score)"),
                  dismissButton: .default(Text("Continue")) {
                self.game.askQuestion()
            })
        })
    }
    
    func flagTapped(_ number: Int) {
        scoreTitle = game.calculateAnswer(for: number)
        showingScore = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
