//
//  TimerView.swift
//  ExamTimer
//
//  Created by Terry Di Pasquale on 15/9/21.
//

import SwiftUI

struct TimerView: View {
   
    var minutes: Int
    @State var secondsPassed = 0
    var secondsLeft: Int
    {
        return minutes * 60 - secondsPassed
    }
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        HStack
        {
            Text(printSecondsToHoursMinutesSeconds (seconds: secondsLeft))
            
        }.onReceive(timer) { time in
            if self.secondsPassed < minutes * 60 {
                self.secondsPassed += 1
            }
        }

    }
    

}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(minutes: 120)
    }
}
