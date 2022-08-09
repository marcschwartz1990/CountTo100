//
//  ContentView.swift
//  CountTo100
//
//  Created by Marc-Developer on 8/3/22.
//

import SwiftUI
import AVFoundation

let backgroundImages = ["islandBackground", "schoolBackground", "rainbowBackground", "partyBackground",
                        "spaceBackground", "giraffeBackground", "vehicleBackground", "constructionBackground",
                        "bananaBackground", "donutBackground", "happyBackground"]

let dictLanguages = ["English": "en-US"]

struct MainMenuView: View {
    @State private var language = "en-US"
    @State private var countBy = 1
    var languageCodes = ["en-US", "es-MX", "it-IT", "fr-FR", "sv-SE", "ja-JP"]
    var countByMultiples = [1, 2, 5, 10]
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Select a language", selection: $language) {
                    ForEach(languageCodes, id: \.self) {
                        Text("\($0)")
                    }
                }
                .navigationTitle("Count to 100")
                
                Picker("Count by", selection: $countBy) {
                    ForEach(countByMultiples, id: \.self) {
                        Text("\($0)")
                    }
                }
                    
                NavigationLink(destination: GameView(languageCode: language, countBy: countBy)) {
                    Text("Start Game")
                }
            }
            
        }
    }
}

struct GameView: View {
    // Variables passed in from MainMenuView
    var languageCode: String
    var countBy: Int
    
    @State private var number = 0
    @State private var buttonFontSize = 100.0
    @State private var growGreenValue = 0.0
    @State private var fadeRedValue = 1.0
    @State private var backgroundImage = ""
    
    var body: some View {
        
        GeometryReader { geo in
            ZStack{
                // Find more background pictures so this doesn't go out of range
                Image(backgroundImages[number / 10])
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                    .opacity(1.0)
                
                VStack {
                    if number < 100 {
                    Button(String(number)) {
                        let utterance =
                            AVSpeechUtterance(string: "\(String(number + countBy))")
                        utterance.voice = AVSpeechSynthesisVoice(language: languageCode)
                        utterance.rate = 0.5
                        
                        let synthesizer = AVSpeechSynthesizer()
                        synthesizer.speak(utterance)
                        
                        number += countBy
                        buttonFontSize += Double(countBy)
                        growGreenValue += Double(countBy) * 0.01
                        fadeRedValue -= Double(countBy) * 0.01
                    }
                    .font(.system(size: buttonFontSize, weight: .bold))
                    .foregroundColor(Color(red: fadeRedValue, green: growGreenValue, blue: 0.3))
                    } else {
                        VStack {
                            Text("100")
                                .foregroundColor(Color(red: fadeRedValue, green: growGreenValue, blue: 0.3))
                                .font(.system(size: buttonFontSize, weight: .bold))
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            MainMenuView()
    }
}
