import SwiftUI

struct GuessTheFlag {
    private(set) var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    private(set) var score: Int = 0
    private(set) var correctAnswer = Int.random(in: 0...2)
    
    var answer: String {
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
        if country(at: selectedCountry) == answer {
            self.score = score + 5
            return "Correct"
        } else {
            return "Wrong! That's the flag of \(self.countries[selectedCountry])"
        }
    }
    
}

struct ContentView: View {
    @State var game = GuessTheFlag()
    @State private var scoreTitle = ""
    @State private var showingScore = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .yellow]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                    Text(game.answer)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }, label: {
                        Image(game.country(at: number))
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    })
                }
                Text("Score: \(game.score)")
                    .font(.body)
                    .fontWeight(.medium)
                Spacer()
            }
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
