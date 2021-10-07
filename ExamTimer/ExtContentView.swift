//
//  ExtContentView.swift
//  ExamTimer
//
//  Created by Terry Di Pasquale on 3/10/21.
//

import SwiftUI

struct ExtContentView: View {
    @EnvironmentObject var examList: DataController
    var body: some View {
        NavigationView
        {
            List
            {
                ForEach(examList.externalExams)
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
        }
    }
}

struct ExtContentView_Previews: PreviewProvider {
    static var previews: some View {
        ExtContentView()
    }
}
