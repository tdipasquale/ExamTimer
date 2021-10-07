//
//  ExamTimerApp.swift
//  ExamTimer
//
//  Created by Terry Di Pasquale on 13/9/21.
//

import SwiftUI

@main
struct ExamTimerApp: App {
    @StateObject var examList = DataController()
    var body: some Scene {
        WindowGroup {
            TabbedView()
            .environmentObject(examList)
        }
    }
}
