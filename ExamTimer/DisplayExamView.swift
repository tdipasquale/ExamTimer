//
//  DisplayExamView.swift
//  ExamTimer
//
//  Created by Terry Di Pasquale on 13/9/21.
//

import SwiftUI

struct DisplayExamView: View {
    //@Environment wrapper allows us to create properties that store values provided to us externally.
    @Environment(\.presentationMode) var presentationMode
    @State var exam: Exam
    @State var index = 0
    @EnvironmentObject var examList : DataController
    var newEvent: Bool
    var perusalProxy: Binding<String> {
            Binding<String>(
                get: { String(Int(self.exam.perusal)) },
                set: {
                    if let value = NumberFormatter().number(from: $0) {
                        self.exam.perusal = value.intValue
                    }
                }
            )
        }
    var durationProxy: Binding<String> {
            Binding<String>(
                get: { String(Int(self.exam.duration)) },
                set: {
                    if let value = NumberFormatter().number(from: $0) {
                        self.exam.duration = value.intValue
                    }
                }
            )
        }
   
    @State var category = ""
    var body: some View {
            //VStack
            //{
                Form
                {
                    Section(header: Text("Subject Code")){
                            TextField("", text: $exam.subjectCode)
                    }
                    Section(header: Text("Subject Name")){
                            TextField("", text: $exam.subjectName)
                    }
                    Section{
                        DatePicker("Exam Date", selection: $exam.date, displayedComponents: .date)
                    }
                    Section(header: Text("Perusal:")){
                        HStack{
                            TextField("5", text: perusalProxy)
                                .keyboardType(.numberPad)
                            Text("minutes")
                        }
                    }
                    Section(header: Text("Duration:")){
                        HStack{
                            TextField("120", text: durationProxy)
                                .keyboardType(.numberPad)
                            Text("minutes")
                        }
                    }
                        
                }
                .navigationBarItems(leading: Button(action: {presentationMode.wrappedValue.dismiss()})
                                    {
                                        Text("Cancel")
                                    }, trailing: Button(action: {
                                        if newEvent
                                        {
                                            examList.internalExams.append(exam)
                                        }
                                        else
                                        {
                                            if let index = examList.internalExams.firstIndex(where:{
                                                      exam.id == $0.id}){
                                                examList.internalExams[index] = exam
                                            }
                    
                                        }
                                        examList.saveInternalExams()
                                        presentationMode.wrappedValue.dismiss()
                                    })
                                    {
                                        Text("Save")
                                    }
                                    )
                                    HStack{
                                        NavigationLink(
                                            destination: CountdownView(exam: exam))
                                            {
                                                Text("Start Exam")
                                            }
                                    }
        
    //}

     //   }
    }
}

struct DisplayExamView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayExamView(exam: Exam(), newEvent: true)
    }
}
