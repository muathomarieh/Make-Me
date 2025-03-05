//
//  PomodoroView.swift
//  TODO
//
//  Created by Muath Omarieh on 24/02/2025.
//

import SwiftUI

struct PomodoroView: View {
    
    private var timer: PomodoroTimer = PomodoroTimer(workInSeconds: 25 * 60, breakInSeconds: 5 * 60)
    
    var body: some View {
        ZStack {
            RadialGradient(colors: Colors.whiteToAccent, center: .center, startRadius: 10, endRadius: 500)
                .ignoresSafeArea()
//            LinearGradient(gradient: Gradient(colors: Colors.backGroundGradiant), startPoint: .bottomTrailing, endPoint: .topLeading)
//                .ignoresSafeArea()
            VStack {
                CircleTimer(fraction: timer.fractionPassed, primaryText: timer.secondsLeftString, secondaryText: timer.mode.rawValue)
                    .shadow(radius: 10)
                
                HStack {
                    // skip
                    if timer.state == .idle && timer.mode == .pause {
                        CircularButton(icon: "forward.fill") {
                            timer.skip()
                        }
                        .shadow(radius: 6)
                    }
                    // start
                    if timer.state == .idle {
                        CircularButton(icon: "play.fill") {
                            timer.start()
                        }
                        .shadow(radius: 6)
                    }
                    // resume
                    if timer.state == .paused {
                        CircularButton(icon: "play.fill") {
                            timer.resume()
                        }
                        .shadow(radius: 6)
                    }
                    // pause
                    if timer.state == .running {
                        CircularButton(icon: "pause.fill") {
                            timer.pause()
                        }
                        .shadow(radius: 6)
                    }
                    // reset
                    if timer.state == .running || timer.state == .paused {
                        CircularButton(icon: "stop.fill") {
                            timer.reset()
                        }
                        .shadow(radius: 6)
                    }
                }
            }
            .frame(maxHeight: .infinity)
        }
    }
}

#Preview {
    PomodoroView()
}
