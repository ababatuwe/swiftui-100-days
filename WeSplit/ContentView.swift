import SwiftUI

struct ContentView: View {
    @State var name = ""
    
    var body: some View {
        Form {
            TextField("Enter your name", text: $name)
            if !name.isEmpty {
                Text("Hello \(name)")
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
