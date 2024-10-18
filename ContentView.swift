import SwiftUI

struct ContentView: View {
    let emotions = ["😞", "😴", "😭", "😁", "🤨", "😴", "🤨", "😭", "😟", "😞", "😟", "😁"]
    let plants = ["🍃", "🌱", "🌻", "🌼", "🌸", "🌿", "🌸", "🌿", "🍃", "🌼", "🌻", "🌱"]
    let reptiles = ["🦗", "🦎", "🐍", "🦕", "🦖", "🐢", "🦕", "🦎", "🐍", "🦗", "🦖", "🐢"]

    @State private var cardCount: Int = 12
    @State private var theme: [String] = []
    @State private var flippedCards: [(index: Int, content: String)] = []  // Track flipped cards
    @State private var matchedCards: Set<Int> = []  // Track matched cards

    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .foregroundColor(.black)
                .padding()

            // LazyVGrid for card layout
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
                ForEach(0..<cardCount, id: \.self) { index in
                    // Ensure the index is within bounds and show only unmatched cards
                    if index < theme.count, !matchedCards.contains(index) {
                        CardView(content: theme[index], isFaceUp: flippedCards.contains(where: { $0.index == index }))
                            .onTapGesture {
                                flipCard(at: index)
                            }
                    }
                }
            }
            .foregroundColor(.orange)
            .padding()

            // Theme buttons
            HStack {
                Spacer()
                Button(action: { setTheme(emotions) }, label: {
                    Image(systemName: "face.smiling.inverse")
                })
                Spacer()
                Button(action: { setTheme(plants) }, label: {
                    Image(systemName: "sun.max.fill")
                })
                Spacer()
                Button(action: { setTheme(reptiles) }, label: {
                    Image(systemName: "lizard.fill")
                })
                Spacer()
            }
            .foregroundColor(.blue)
            .font(.largeTitle)
            .padding()
        }
        .onAppear {
            setTheme(emotions)  // Initialize with default theme
        }
    }

    // Set the theme and reset the game state
    func setTheme(_ newTheme: [String]) {
        // Ensure that the theme has enough elements for the game
        theme = Array(newTheme.shuffled().prefix(cardCount))  // Shuffle and limit to cardCount
        matchedCards.removeAll()  // Reset matched cards
        flippedCards.removeAll()  // Reset flipped cards
    }

    // Flip the card at the given index
    func flipCard(at index: Int) {
        // Check if the card is already flipped or if there are 2 flipped cards already
        if flippedCards.count == 2 || flippedCards.contains(where: { $0.index == index }) {
            return
        }

        // Add the card to flippedCards
        flippedCards.append((index: index, content: theme[index]))

        // If 2 cards are flipped, check for a match
        if flippedCards.count == 2 {
            let firstCard = flippedCards[0]
            let secondCard = flippedCards[1]

            if firstCard.content == secondCard.content {
                // If they match, add their indices to matchedCards
                matchedCards.insert(firstCard.index)
                matchedCards.insert(secondCard.index)
            }

            // Reset flipped cards after a delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                flippedCards.removeAll()  // Reset flipped cards
            }
        }
    }
}

struct CardView: View {
    let content: String
    var isFaceUp: Bool

    var body: some View {
        ZStack {
            let base = Circle()
            if isFaceUp {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
                    .padding()
            } else {
                base.fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

