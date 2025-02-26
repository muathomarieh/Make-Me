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
            RadialGradient(gradient: Gradient(colors: [Color.white, Color.accentColor]), center: .center, startRadius: 5, endRadius: 500)
                .ignoresSafeArea()
            VStack {
                CircleTimer(fraction: timer.fractionPassed, primaryText: timer.secondsLeftString, secondaryText: timer.mode.rawValue)
                
                HStack {
                    // skip
                    if timer.state == .idle && timer.mode == .pause {
                        CircularButton(icon: "forward.fill") {
                            timer.skip()
                        }
                    }
                    // start
                    if timer.state == .idle {
                        CircularButton(icon: "play.fill") {
                            timer.start()
                        }
                    }
                    // resume
                    if timer.state == .paused {
                        CircularButton(icon: "play.fill") {
                            timer.resume()
                        }
                    }
                    // pause
                    if timer.state == .running {
                        CircularButton(icon: "pause.fill") {
                            timer.pause()
                        }
                    }
                    // reset
                    if timer.state == .running || timer.state == .paused {
                        CircularButton(icon: "stop.fill") {
                            timer.reset()
                        }
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
