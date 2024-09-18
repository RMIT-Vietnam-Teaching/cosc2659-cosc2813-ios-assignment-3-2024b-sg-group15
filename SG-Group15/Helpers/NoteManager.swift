//
//  NoteManager.swift
//  SG-Group15
//
//  Created by Nana on 17/9/24.
//

import Foundation

struct NoteManager {
    static let userDefaultsKey = "savedNote"
    
    // Save Note to UserDefaults
    static func save(note: Note) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(note)
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
//            print("Note saved successfully!")
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
