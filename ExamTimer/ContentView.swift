//
//  ContentView.swift
//  ExamTimer
//
//  Created by Terry Di Pasquale on 13/9/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var examList: DataController
    var body: some View {
        NavigationView
        {
            List
            {
                ForEach(examList.internalExams)
                {
                    exam in
                    NavigationLink(destination: DisplayExamView(exam: exam, newEvent: false))
                    {
                        VStack
                        {
                            Text(exam.date.shortDate)
                            Text(exam.subjectCode)
                            Text(exam.subjectName)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                }
                
            }
            
            .navigationTitle("Exams:")
            
            .navigationBarItems(trailing: NavigationLink(destination: DisplayExamView(exam: Exam(), newEvent: true), label: {
                Text("Add exam")
            }))
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
extension Date
{
    var shortDate : String
    {
        let day = Calendar.current.component(.day, from: self)
        let month = Calendar.current.component(.month, from: self)
        let year = Calendar.current.component(.year, from: self)
        
        return "\(day) \(month) \(year)"
    }
}
