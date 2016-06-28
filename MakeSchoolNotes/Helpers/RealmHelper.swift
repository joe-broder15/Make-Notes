//
//  RealmHelper.swift
//  MakeSchoolNotes
//
//  Created by Admin on 6/24/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import Foundation
import RealmSwift

//class for our realm helper
class RealmHelper {
    
    //defines the function saves the note
    static func addNote(note: Note){
        //try to create a refference to the default realm
        let realm = try! Realm()
        //try to write to the realm
        try! realm.write() {
            //add the note to the realm
            realm.add(note)
        }
    }
    
    //defines function to remove note
    static func deleteNote (note: Note) {
        //create a reference to the default realm
        let realm = try! Realm()
        //try to write in the realm
        try! realm.write() {
            realm.delete(note)
        }
        
    }
    
    //defines function to update a note
    static func updateNote (noteToUpdate: Note, newNote: Note) {
        //create a reference to the default realm
        let realm = try! Realm()
        //try to write in the realm
        try! realm.write() {
            //redefines all the values
            noteToUpdate.title = newNote.title
            noteToUpdate.content = newNote.content
            noteToUpdate.modificationTime = newNote.modificationTime
        }
        
    }
    
    //defines function to retreive a note
    static func retriveNotes() -> Results<Note>{
        let realm = try! Realm()
        //return objects in ascending order based on modification time
        return realm.objects(Note).sorted("modificationTime", ascending: false)
    }
    
    
    
}
