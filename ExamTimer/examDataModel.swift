//
//  examDataModel.swift
//  ExamTimer
//
//  Created by Terry Di Pasquale on 13/9/21.
//

import Foundation


class Exam: Identifiable, Codable {
    var uniqueID = UUID()
    var id: Int = 0
    var subjectCode: String = ""
    var subjectName: String = ""
    var date: Date = Date()
    var week: Int = 1
    var perusal: Int = 0
    var duration: Int = 0
    enum CodingKeys : CodingKey {case id, subjectCode, subjectName, perusal, duration}
}
