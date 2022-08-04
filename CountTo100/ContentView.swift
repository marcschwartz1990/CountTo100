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

struct ContentView: View {
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
                            AVSpeechUtterance(string: "\(String(number + 1))")
                        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                        utterance.rate = 0.5
                        
                        let synthesizer = AVSpeechSynthesizer()
                        synthesizer.speak(utterance)
                        
                        number += 1
                        buttonFontSize += 1
                        growGreenValue += 0.01
                        fadeRedValue -= 0.01
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
        Group {
            ContentView()
            ContentView()
        }
    }
}
