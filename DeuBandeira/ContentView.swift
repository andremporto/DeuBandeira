//
//  ContentView.swift
//  DeuBandeira
//
//  Created by André Porto on 30/06/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var questionCounter = 1
    
    @State private var countries = ["Estônia", "França", "Alemanha", "Irlanda", "Itália", "Nigéria", "Mônaco", "Polônia", "Rússia", "Espanha", "Inglaterra", "EUA"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.yellow, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Adivinhe a Bandeira")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                Spacer()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Toque na Bandeira da(o):")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                        //                            .foregroundColor(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 30)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Pontuação \(userScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            
            .padding()
        }
        
        .alert(scoreTitle, isPresented: $showingScore) {
            if questionCounter != 8 {
                Button("Continue", action: askQuestion)
            } else {
                Button("Início", action: restartGame)
            }
        } message: {
            if questionCounter != 8 {
                Text("Sua Pontuação é \(userScore)")
            } else {
                Text("Você terminou o jogo com \(userScore) pontos. Pressione Início para reiniciar o jogo.")
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "😃 Coreto! Essa é a bandeira do(a) \(countries[number])"
            userScore+=100
        } else {
            scoreTitle = "🥲 Errado! Essa é a bandeira do(a) \(countries[number])."
            userScore-=100
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCounter+=1
    }
    
    func restartGame() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCounter = 1
        userScore = 0
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
