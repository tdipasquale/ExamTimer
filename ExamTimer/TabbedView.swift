//
//  TabbedView.swift
//  ExamTimer
//
//  Created by Terry Di Pasquale on 3/10/21.
//

import SwiftUI

struct TabbedView: View {
    
    var body: some View {
        
        TabView {
            
            ContentView()
                .tabItem {
                    Text("Internal exams")
                }
            
            ExtContentView()
                .tabItem {
                    Text("External exams")
                }
        }
    }
}

struct TabbedView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedView()
    }
}
