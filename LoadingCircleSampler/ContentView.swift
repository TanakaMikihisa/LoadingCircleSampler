//
//  ContentView.swift
//  LoadingCircleSampler
//
//  Created by tanakamiki on 2025/07/17.
//

import SwiftUI


struct LoadingCircle : View {
    @StateObject var stopwatch : Stopwatch
    
    var blue1 = Color(red: 59/255, green: 150/255, blue: 215/255)
    var blue2 = Color(red: 66/255, green: 126/255, blue: 217/255)
    var blue3 = Color(red: 100/255, green: 120/255, blue: 215/255)
    
    var body: some View {
        Arc(startAngle: getStartAngle(), endAngle: getEndAngle())
            .stroke(getGradient(), lineWidth: 3) // ここで色と太さを指定
            .frame(width: 40, height: 40)
            .animation(.linear(duration: 0.01), value: stopwatch.time)
    }
    
    private func getGradient() -> AngularGradient{
        let gradation = AngularGradient(gradient: Gradient(colors: [blue1, blue2,blue3,blue1]), center: .center, angle: .degrees(-90 ) )
        return gradation
    }
    
    private func getStartAngle() -> Angle {
        // 1.2秒を1周期とする進捗率（0.0 〜 1.2）を計算
        let progress = stopwatch.time.truncatingRemainder(dividingBy: 1.2)
        
        switch progress {
        case 0.0..<0.15:
            return Angle(degrees: 90 + progress * 90 / 0.15)
        case 0.0..<0.3:
            return Angle(degrees: 180 + (progress - 0.15) * 180 / 0.15)
        case 0.0..<0.75:
            return Angle(degrees: (progress - 0.3) * 90 / 0.45 )
        case 0.0..<0.9:
            return Angle(degrees: (progress - 0.75) * 90 / 0.15 + 90)
        case 0.0..<1.05:
            return Angle(degrees: (progress - 0.9) * 180 / 0.15 + 180)
        case 0.0..<1.2:
            return Angle(degrees: (progress - 1.05) * 90 / 0.15)
        default:
            return Angle(degrees: 0)
        }
    }
    
    private func getEndAngle() -> Angle {
        // 1.2秒を1周期とする進捗率（0.0 〜 1.2）を計算
        let progress = stopwatch.time.truncatingRemainder(dividingBy: 1.2)
        switch progress {
        case 0.0..<0.75:
            return Angle(degrees: progress * 180 / 0.75)
        case 0.0..<0.9:
            return Angle(degrees: (progress - 0.75) * 180 / 0.15 + 180)
        case 0.0..<1.05:
            return Angle(degrees: (progress - 0.9) * 90 / 0.15)
        case 0.0..<1.2:
            return Angle(degrees: (progress - 1.05) * 270 / 0.15 + 90)
        default:
            return Angle(degrees: 0)
        }
    }
}

struct LoadingCircleTest : View {
    @StateObject var stopwatch = Stopwatch()
    var body: some View {
        
        //ProgressView()
        
        LoadingCircle(stopwatch: stopwatch)
        Button {
            
            stopwatch.isRunning.toggle()
            
            switch stopwatch.isRunning {
                
            case true: stopwatch.start()
                
            default:stopwatch.reset()
                
            }
        } label: {
            Text(stopwatch.isRunning ? "Stop" : "Start")
        }
        
        .onAppear {
            stopwatch.isRunning = true
            stopwatch.start()
        }
        
    }
}

#Preview {
    LoadingCircleTest()
}

