//
//  NoteViewModel.swift
//  SG-Group15
//
//  Created by Nana on 22/9/24.
//

import SwiftUI
import FirebaseFirestore
import PencilKit
import Combine

class NoteViewModel: ObservableObject {
    @Published var notes: [Note] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = true
    @Published var currentNote: Note?
    @Published var isLoadNote: Bool = true


        private var db = Firestore.firestore()
        
        // Load all notes from Firestore
        func loadNotes() {
            db.collection("notes").getDocuments { [weak self] (snapshot, error) in
                if let error = error {
                    self?.errorMessage = "Error loading notes: \(error.localizedDescription)"
                    return
                }
                
                if let snapshot = snapshot {
                    var loadedNotes: [Note] = [] // Temporary array to hold the notes

                    for document in snapshot.documents {
                        let data = document.data()
                        let id = document.documentID
                        let title = data["title"] as? String ?? ""
                        let textContent = data["textContent"] as? String ?? ""
                        let lastModified = (data["lastModified"] as? Timestamp)?.dateValue() ?? Date()
                        
                        var drawing: PKDrawing? = nil
                        if let drawingBase64 = data["drawingData"] as? String,
                           let drawingData = Data(base64Encoded: drawingBase64) {
                            drawing = try? PKDrawing(data: drawingData)
                        }
                        
                        let color = data["color"] as? String ?? ""

                        
                        // Create a Note object and add it to the temporary array
                        let note = Note(id: id ,title: title, textContent: textContent, drawing: drawing, lastModified: lastModified, color: color)
                        loadedNotes.append(note) // Append the created note to the array
                    }
                    
//                    print("loaded note: \(loadedNotes.count)")
                    
                    // Update the notes array on the main thread
                       DispatchQueue.main.async {
                           self?.notes = loadedNotes
                           self?.isLoading = false
                       }
                }
                
            }
        }
    
    func decodeDrawing(from data: Data) -> PKDrawing? {
        do {
            let drawing = try PKDrawing(data: data)
            return drawing
        } catch {
            print("Error decoding PKDrawing: \(error.localizedDescription)")
            return nil
        }
    }
    
    func fetchNote(id: String, completion: @escaping (Note?) -> Void) {
        self.isLoadNote = true
        
        db.collection("notes").document(id).getDocument { [weak self] docu, error in
            defer {
                self?.isLoadNote = false  // Ensure isLoading is set to false when finished
            }
            
            // Handle error case
            if let error = error {
                print("Error fetching note: \(error)")
                completion(nil)  // Notify failure via the completion handler
                return
            }
            
            // Check if document exists
            guard let document = docu, document.exists, let data = document.data() else {
                print("Document does not exist or has no data")
                completion(nil)  // Notify failure via the completion handler
                return
            }
            
            // Safely unwrap data fields
            let title = data["title"] as? String ?? ""
            let textContent = data["textContent"] as? String ?? ""
            let lastModified = (data["lastModified"] as? Timestamp)?.dateValue() ?? Date()
            let color = data["color"] as? String ?? ""

            var drawing: PKDrawing? = nil
            if let drawingBase64 = data["drawingData"] as? String,
               let drawingData = Data(base64Encoded: drawingBase64) {
                drawing = try? PKDrawing(data: drawingData)
            }
            
            let note = Note(id: id, title: title, textContent: textContent, drawing: drawing, lastModified: lastModified, color: color)
            
            self?.currentNote = note
            completion(note)  // Pass the note back via the completion handler
        }
    }
    
    
    // Save a new note to Firestore
        func saveNote(_ note: Note) {
            var noteData: [String: Any] = [
                "title": note.title,
                "textContent": note.textContent,
                "color": note.color,
                "lastModified": note.lastModified
            ]
            
            if let drawingData = note.drawingData {
                noteData["drawingData"] = drawingData.base64EncodedString()
            }
            
            db.collection("notes").addDocument(data: noteData)
        }
    
    func updateNote(_ note: Note) {

        var noteData: [String: Any] = [
            "title": note.title,
            "textContent": note.textContent,
            "lastModified": Timestamp(date: note.lastModified)
        ]
        
        if let drawingData = note.drawingData {
            noteData["drawingData"] = drawingData.base64EncodedString()
        }
        
        print("Update: \(String(describing: note.id))")
        
        // Save with the exact date the user is created
        db.collection("notes").document(note.id!).updateData(noteData)
        {  // Handle error
            error in
            if let error = error {
                print("Error saving user data: \(error.localizedDescription)")
            }
            else {
                print("Note saved successfully!")
            }
            
        }
    }
    
    
}
