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

// Exports this session as `Data`, using the default Keys
let dataSession = try? EyeTracking.export(sessionID: "8136AD7E-7262-4F07-A554-2605506B985D")

// Exports this session as a `String`, converting the keys to snake case
let stringSession = try? EyeTracking.exportString(sessionID: "8136AD7E-7262-4F07-A554-2605506B985D", with: .convertToSnakeCase)

// Exports all `Session`s as `Data`, using the default keys
let dataSessions = try? EyeTracking.exportAll()

// Exports all `Session`s as a `String`, converting the keys to snake case
let stringSessions = try? EyeTracking.exportAllString(with: .convertToSnakeCase)

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
                // Optionally make any changes to the pointer
               //  eyeTracking.pointer.backgroundColor = .red

                // Begin displaying the pointer
                eyeTracking.showPointer()
                print(eyeTracking.pointer.frame)
                

            }) {
                Text("Start")
            }
            Spacer()
            Button(action: {
                print("finish button pressed")
                eyeTracking.hidePointer()
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


