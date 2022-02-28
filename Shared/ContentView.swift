//
//  ContentView.swift
//  Shared
//
//  Created by 김종엽 on 2022/02/18.
//
// test

import SwiftUI
import ARKit
import AVFoundation
// import Foundation
import EyeTracking
import UserNotifications



var audio:AVPlayer!

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
    @State private var date = Date()
    @State private var today = Date()
    @State private var timeRemaining = 5
    
    init() {
        // allows audio to be played in the background if app is closed
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playback)
        } catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
    }
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
 //   @State private var alarmtime =
    var body: some View {
        VStack{
 //           Text("Hello, world!_JY")
  //              .padding()
            Text("수민아 일어나")
                .font(.largeTitle)
            
            Text("Time: \(timeRemaining)")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                .background(.black.opacity(0.75))
                .clipShape(Capsule())
                .onChange(of: timeRemaining == 0){newValue in
                    playAlarm()
                    eyeTracking.startSession()
                    // Optionally make any changes to the pointer
                   //  eyeTracking.pointer.backgroundColor = .red

                    // Begin displaying the pointer
                    eyeTracking.showPointer()
                    print(eyeTracking.pointer.frame)
                    
                }
                .onReceive(timer) { time in
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    } else if timeRemaining == 0 {
                        timeRemaining = 0
                    }
                }
            
//            Text("현재시간은 \(date)")
//                .font(.largeTitle)
//                .foregroundColor(.white)
//                .padding(.horizontal, 20)
//                .padding(.vertical, 5)
//                .background(.black.opacity(0.75))
//                .clipShape(Capsule())
//                .onReceive(timer) { vtest in
//                    if timeRemaining > 0 {
//                        timeRemaining -= 1
//                    }
//                }
            
            
            Form{DatePicker("몇 시에 깨워줄까?", selection: $date)
                .datePickerStyle(GraphicalDatePickerStyle())
              //달력과 텍스트의 위치를 지정하는 프레임
                .frame(maxHeight: 400)
            }
            Text("지금은\(today)")
            Text("우리딸'\(date)'에 깨워줄게 ^^")

            Button(action: {
                print("start Button pressed")
                playAlarm()
                eyeTracking.startSession()
                // Optionally make any changes to the pointer
               //  eyeTracking.pointer.backgroundColor = .red

                // Begin displaying the pointer
                eyeTracking.showPointer()
                print(eyeTracking.pointer.frame)
                

            }) {
                Text("Start")
            }
//            Spacer()
            Button(action: {
                print("finish button pressed")
                eyeTracking.hidePointer()
                eyeTracking.endSession()
                stopAlarm()
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


func stopAlarm() {
    // To pause or stop audio in swift 5 audio.stop() isn't working
    audio.pause()
}

func playAlarm() {
//    var audiovisualBackgroundPlaybackPolicy: AVPlayerAudiovisualBackgroundPlaybackPolicy!
    // need to declare local path as url]
    let url = Bundle.main.url(forResource: "alarmSample", withExtension: "mp3")
    // now use declared path 'url' to initialize the player
    audio = AVPlayer.init(url: url!)
    // after initialization play audio its just like click on play button
 //   audiovisualBackgroundPlaybackPolicy =
 //   audio.audiovisualBackgroundPlaybackPolicy = .continuesIfPossible
    audio.audiovisualBackgroundPlaybackPolicy = .automatic
 //   audio.
    
    audio.play()
}
