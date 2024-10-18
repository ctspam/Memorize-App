//
//  ContentView.swift
//  Memorize
//
//  Created by chloe pham on 8/1/24.
//

import SwiftUI

struct ContentView: View {
    let emotions = ["😞", "😴", "😭", "😁",
                    "🤨", "😴", "🤨", "😭", "😟", "😞", "😟", "😁"]
    let plants = ["🍃", "🌱", "🌻", "🌼", "🌸", "🌿", "🌸", "🌿", "🍃", "🌼", "🌻", "🌱"]
    
    let reptiles = ["🦗", "🦎", "🐍", "🦕", "🦖", "🐢", "🦕", "🦎", "🐍", "🦗", "🦖", "🐢"]
    @State private var cardCount: Int = 12
    @State private var theme: [String] = []
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .foregroundColor(.black)
                .padding()
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
                ForEach(0..<cardCount, id: \.self) { index in
                    if index < theme.count {
                        CardView(content: theme[index])
                    }
                }
            }
            .foregroundColor(.orange)
            .padding()
            
            
            HStack {
                Spacer()
                Button(action: {
                    
                    theme = emotions
                }, label: {
                    Image(systemName: "face.smiling.inverse")
                })
                Spacer()
                
                Button(action: {
                    theme = plants
                }, label: {
                    Image(systemName: "sun.max.fill")
                })
                Spacer()
                Button(action: {
                    theme = reptiles
                }, label: {
                    Image(systemName: "lizard.fill")
                })
                Spacer()
                
            }
            .foregroundColor(.blue)
            .font(.largeTitle)
            .padding()
            
        }
        .onAppear{
            theme = emotions
        }
        
    }
    
    
    struct CardView: View {
        let content: String
        @State var isFaceUp: Bool = false
        
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
            .onTapGesture {
                isFaceUp.toggle()
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
