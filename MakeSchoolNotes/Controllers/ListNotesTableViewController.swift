//
//  ListNotesTableViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import RealmSwift

class ListNotesTableViewController: UITableViewController {
    
    var notes: Results<Note>! {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        notes = RealmHelper.retriveNotes()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath) as! ListNotesTableViewCell
        
        //1
        let row = indexPath.row
        
        //2
        let note = notes[row]
        
        //3
        cell.noteTitleLabel.text = note.title
        
        //4
        cell.noteTimeModifiedLabel.text = note.modificationTime.convertToString()
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "displayNote" {
                print("Switching to displaynote")
                
                //1
                let indexPath = tableView.indexPathForSelectedRow!
                
                //2
                let note = notes[indexPath.row]
                
                //3
                let displayNoteViewController = segue.destinationViewController as! DisplayNoteViewController
                
                //4
                displayNoteViewController.note = note
                
            } else if identifier == "addNote" {
                print("+ button tapped")
            }
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if editingStyle == .Delete{
            RealmHelper.deleteNote(notes[indexPath.row])
            notes = RealmHelper.retriveNotes()
        }
    }
    
    @IBAction func unwindToListNotesViewController(segue: UIStoryboardSegue){
        //tbd
    }
    
}