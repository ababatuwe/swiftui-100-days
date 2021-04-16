//

import SwiftUI

enum Choice: Int, CaseIterable {
    case rock = 0
    case paper
    case scissors
    
    var emoji: String {
        let moves = ["🪨", "📃", "✂️"]
        return moves[rawValue]
    }
}
extension Choice: Comparable {
    static func < (lhs: Choice, rhs: Choice) -> Bool {
        switch lhs {
        case .paper:
            switch rhs {
            case .rock:
                return false
            case .paper:
                return false
            case .scissors:
                return true
            }
        case .scissors:
            switch rhs {
            case .rock:
                return true
            case .paper:
                return false
            case .scissors:
                return false
            }
        case .rock:
            switch rhs {
            case .rock:
                return false
            case .paper:
                return true
            case .scissors:
                return false
            }
        }
    }
    
    
}

struct RockPaperScissors {
    let moves = Choice.allCases
    private var computerChoice = Int.random(in: 0...2)
    private(set) var score = 0
    private(set) var shouldWin: Bool = true
    
    var computerEmoji: String {
        moves[computerChoice].emoji
    }
    
    mutating func playerDidPlay(_ choice: Int) {
        computerChoice = Int.random(in: 0...2)

        guard let playerMove = Choice(rawValue: choice), let computerMove = Choice(rawValue: computerChoice) else {
            return
        }
        if playerMove > computerMove {
            score = score + 5
            shouldWin = true
        } else if computerMove > playerMove {
            shouldWin = false
            score = score - 3
        } else {
            shouldWin = true
        }
    }
    
    func playerEmoji(at index: Int) -> String {
        return moves[index].emoji
    }
}

struct ContentView: View {
    @State private var game = RockPaperScissors()
    
    var body: some View {
        VStack {
            VStack(spacing: 10) {
                Text("Score: \(game.score)")
                Text("Computer choice: \(game.computerEmoji)")
            }
            Spacer()
                .frame(width: UIScreen.main.bounds.width, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            HStack {
                ForEach(0 ..< 3) { index in
                    Button(action: {
                        game.playerDidPlay(index)
                    }, label: {
                        Text("\(game.playerEmoji(at: index))")
                    })
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
