//
//  CelebrationView.swift
//  TODO
//
//  Created by Muath Omarieh on 22/02/2025.
//

import SwiftUI
import ConfettiSwiftUI

struct Movement{
    var x: CGFloat
    var y: CGFloat
    var z: CGFloat
    var opacity: Double
}

struct FancyButtonViewModel: View {
    
    @State var animate = false
    @State private var counter = 0
    
    var body: some View {
        VStack{
            if animate {
                ConfettiContainer(
                    num:10
                )
            }
            Button("Confetti"){
                animate.toggle()
            }
            
            Button(action: {
                counter += 1
            }) {
                Text("🎃")
                    .font(.system(size: 50))
            }
            .confettiCannon(trigger: $counter)

               
        }
    }
}

struct ConfettiContainer: View {
    var num:Int
    
    var body: some View{
        ZStack{
            ForEach(0...num-1, id:\.self){ _ in
                Confetti()
            }
        }
    }
}

struct Confetti: View{
    
    @State var movement = Movement(x: 0, y: 0, z: 1, opacity: 0)
    
    @State var animate = false
    @State var xSpeed = Double.random(in: 0.7...2)
    @State var zSpeed = Double.random(in: 1...2)
    @State var anchor = CGFloat.random(in: 0...1).rounded()
    
    var body: some View{
        Text("❤️")
            .frame(width: 50, height: 50, alignment: .center)
            .offset(x: movement.x, y: movement.y)
            .scaleEffect(movement.z)
            .opacity(movement.opacity)
            .onAppear {
                animate = true
                withAnimation(Animation.easeInOut(duration: 0.9)) {
                    movement.opacity = 1
                    movement.x = CGFloat.random(in: -150...150)
                    movement.y = -300 * CGFloat.random(in: 0.7...1)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                    withAnimation(Animation.easeIn(duration: 2)) {
                        movement.y = 200
                        movement.opacity = 0.0
                    }
                }
            }
    }
            
}

#Preview {
    FancyButtonViewModel()
}
