/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2023B
  Assessment: Assignment 3
  Author: Group 15
    - Nguyen Tran Ha Anh - 3938490
    - Bui Tuan Anh - 3970375
    - Nguyen Ha Kieu Anh - 3818552
    - Truong Hong Van - 3957034
  Created  date: 08/09/2024
  Last modified: 23/09/2024
*/
import Foundation

struct NoteManager {
    static let userDefaultsKey = "savedNote"
    
    // Save Note to UserDefaults
    static func save(note: Note) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(note)
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        } catch {
            print("Failed to encode and save note: \(error)")
        }
    }
    
    // Load Note from UserDefaults
    static func load() -> Note? {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey) {
            do {
                let decoder = JSONDecoder()
                let note = try decoder.decode(Note.self, from: data)
                print("Note loaded successfully!")
                return note
            } catch {
                print("Failed to decode and load note: \(error)")
            }
        }
        return nil
    }
}
