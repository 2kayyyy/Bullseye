//
//  ContentView.swift
//  Bullseye
//
//  Created by Aryan Kafle on 16/04/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var alertIsVisible = false
    @State private var sliderValue = 50.0
    @State private var game = Game()
    var body: some View {
        ZStack {
            BackgroundView(game: $game)
            VStack {
                InstructionsView(game: $game) .padding(.bottom, alertIsVisible ? 0 : 100)
                if alertIsVisible {
                    PointsView(alertIsVisible: $alertIsVisible, sliderValue: $sliderValue, game: $game)
                        .transition(.scale)
                } else {
                    HitMeButtonView(alertIsVisible: $alertIsVisible, sliderValue: $sliderValue, game: $game)
                        .transition(.scale)
                }
            }
            if !alertIsVisible{
                SliderView(sliderValue: $sliderValue)
                    .transition(.scale)
            }
        }
    }

struct InstructionsView: View {
    @Binding var game : Game
    var body: some View {
        VStack{
            InstructionText(text: "🎯🎯🎯\nput the bullseye as close as you can to")
                .padding(.leading, 30.0)
                .padding(.trailing, 30.0)
            BigNumberText(text: String(game.target))
        }
    }
}

struct SliderView: View {
    @Binding var sliderValue : Double
    var body: some View {
            HStack {
                SliderLabelText(text: "1")
                Slider(value: $sliderValue, in:1.0...100.0)
                SliderLabelText(text: "100")
            }
    }
}

struct HitMeButtonView: View {
    @Binding var alertIsVisible : Bool
    @Binding var sliderValue : Double
    @Binding var game : Game
    var body: some View {
        Button(action: {
            withAnimation {
                alertIsVisible = true
            }
        }) {
        Text("Hit me".uppercased())
          .bold()
          .font(.title3)
        }
        .padding(20.0)
        .background(
            ZStack {
                Color("ButtonColor")
                LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.3), Color.clear]), startPoint: .top, endPoint: .bottom)
            }
        )
        .foregroundColor(Color.white)
        .cornerRadius(Constants.General.roundRectCornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: Constants.General.roundRectCornerRadius)
                .strokeBorder(Color.white, lineWidth : Constants.General.strokeWidth)
        )
        
    }
 }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
        ContentView() .preferredColorScheme(.dark)
        ContentView()
            .previewLayout(.fixed(width: 568, height: 320))
    }
}
