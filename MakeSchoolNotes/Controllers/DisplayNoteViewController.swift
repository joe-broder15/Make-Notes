//
//  DisplayNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit

class DisplayNoteViewController: UIViewController {
    
    var note = Note?()

    @IBOutlet weak var noteTitleTextFeild: UITextField!
    @IBOutlet weak var noteContentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let listNotesTableViewController = segue.destinationViewController as! ListNotesTableViewController
        if segue.identifier == "Save" {
            if let note = note {
                // 1
                let newNote = Note()
                note.title = noteTitleTextFeild.text ?? ""
                note.content = noteContentTextView.text ?? ""
                RealmHelper.updateNote(note, newNote: newNote)
            } else {
                // 3
                let note = Note()
                note.title = noteTitleTextFeild.text ?? ""
                note.content = noteContentTextView.text ?? ""
                note.modificationTime = NSDate()
                RealmHelper.addNote(note)
            }
        }
        
        listNotesTableViewController.notes = RealmHelper.retriveNotes()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let note = note {
            noteTitleTextFeild.text = note.title
            noteContentTextView.text = note.content
        } else{
            noteTitleTextFeild.text = ""
            noteContentTextView.text = ""
        }
        
        
        
    }

}
