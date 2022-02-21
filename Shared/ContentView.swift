//
//  ContentView.swift
//  Shared
//
//  Created by 김종엽 on 2022/02/18.
//
// test

import SwiftUI
import ARKit
import Foundation
import EyeTracking


let eyeTracking = EyeTracking(configuration: Configuration(appID: "ios-eye-tracking-example"))

struct ContentView: View {
    var body: some View {
        VStack{
            Text("Hello, world!_JY")
                .padding()
            Text("Hello, world!_JY")
                .padding()
            Button(action: {
                print("start Button pressed")
                eyeTracking.startSession()
            }) {
                Text("Start")
            }
            Spacer()
            Button(action: {
                print("finish button pressed")
                eyeTracking.endSession()
            }) {
                Text("Finish")
            }
        }

        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


