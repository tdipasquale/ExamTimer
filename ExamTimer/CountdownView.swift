//
//  CountdownView.swift
//  ExamTimer
//
//  Created by Terry Di Pasquale on 3/10/21.
//

import SwiftUI

struct CountdownView: View {
    @State var exam: Exam
    @State var start: Date = Date()
    @State var startPerusal = false
    @State var startExam = false
    var examStart: Date {
        return start.addingTimeInterval(Double(exam.perusal * 60))
    }
    var examFinish: Date {
        return start.addingTimeInterval(Double((exam.duration + exam.perusal) * 60))
    }
    var body: some View {
        VStack
        {
            Text(exam.subjectName)
            Text(exam.subjectCode)
            Button("Start Perusal")
            {
                startPerusal.toggle()
            }
            if startPerusal
            {
                HStack
                {
                    Text("Perusal Start:")
                    Text(start, style: .time)
                }
                TimerView(minutes: exam.perusal)
            }
            let timerExam = Timer.scheduledTimer(withTimeInterval: 60, repeats: false) { timer in
                self.startExam = true
            }
            if startExam
            {
                HStack
                {
                    Text("Exam Start:")
                    let examStart = start.addingTimeInterval(Double(exam.perusal * 60))
                    Text(examStart, style: .time)
                }
                TimerView(minutes: exam.duration)
                HStack
                {
                    Text("Exam Finish:")
                    Text(examFinish, style: .time)
                }
                
            }
//
//            if  == examStart
//            {
//
//            }
            //            Button("Start Perusal") {
            //                Text("button working")
            //DatePicker("Perusal Start", selection: $start, displayedComponents: .hourAndMinute)
            //TimerView(minutes: exam.perusal)
            //}
            
            
            //            Button(action: TimerView, label: <#T##() -> _#>)
            //            HStack{
            //                Text("Exam Start:")
            //                Spacer()
            //                Text(examStart, style: .time)
            //            }
            //            HStack{
            //                Text("Exam Finish:")
            //                Spacer()
            //                Text(examFinish, style: .time)
            //            }
        }
    }
    private func delayTimer() {
            // Delay of duration * 60
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(exam.perusal * 60)) {
                startExam = true
            }
        }
}

struct CountdownView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownView(exam: Exam())
    }
}
