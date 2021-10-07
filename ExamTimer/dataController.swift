//
//  dataController.swift
//  ExamTimer
//
//  Created by Terry Di Pasquale on 13/9/21.
//


import Foundation
class DataController: ObservableObject
{
    
    @Published var internalExams = [Exam]()
    @Published var externalExams = [Exam]()
    //    {
    //        didSet
    //        {
    //            saveEvents()
    //        }
    //    }
    
    //    var ExamsToday : [Exam]
    //    {
    //        return internalExams.filter{$0.examDate == Date()}
    //    }
    
    
    //Directory
    private let downloadsURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    
    
    init()
    {
        loadInternalExams()
        LoadExternalExams()
        //print(downloadsURL)
    }
    
    func loadInternalExams()
    {
        // creates a variable to hold the url of JSON file
        let url = downloadsURL.appendingPathComponent("exams.json")
        //else {print("Invalid URL"); return}
        let request = URLRequest(url: url)
        //Create a session to get the data
        URLSession.shared.dataTask(with: request)
        {data, response, error in
            //data is data returned
            //response - type of data
            //error - any errors that result
            //print the data in the debugger window
            if let data = data
            {
                print(String(decoding: data, as: UTF8.self))
                if let decodedResponse = try? JSONDecoder().decode([Exam].self, from: data)
                {
                    DispatchQueue.main.async
                    {
                        //update our UI
                        self.internalExams = decodedResponse
                    }
                    //all is good
                    return
                }
            }
            print("Fetch Failed")
        }.resume()
    }
    func saveInternalExams()
    {
        
        let url = downloadsURL.appendingPathComponent("exams.json")
        
        if let data = try? JSONEncoder().encode(internalExams)
        {
            do
            {
                try data.write(to: url)
            }
            catch
            {
                print(error)
            }
        }
    }
    
    func LoadExternalExams()
    {
        guard let url = URL(string: "https://siena.oneclickdb.com.au/json_Planner.php?Data=EE")
        else {print ("Invalid URL"); return }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request){ data, response, error in
            if let data = data
            {
                print(String(decoding: data, as: UTF8.self))
                do{
                    if let decodedResponse = try? JSONDecoder().decode([Exam].self, from: data)
                    {
                        DispatchQueue.main.async {
                            self.externalExams = decodedResponse
                        }
                        return
                    }
                }
                catch{
                    print("Error: \(error)")
                }
            }
        }.resume()
    }
    //    func removeItems(at offsets: IndexSet) {
    //        print(offsets)
    //        //let currentTitle = currentEvents[offsets[0]]]["title"]
    //        //expenses.items.remove(atOffsets: offsets)
    //    }
    
}

func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
    return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
}
func printSecondsToHoursMinutesSeconds (seconds:Int) -> String {
    let (h, m, s) = secondsToHoursMinutesSeconds (seconds: seconds)
    return "\(h) Hours, \(m) Minutes, \(s) Seconds"
}
