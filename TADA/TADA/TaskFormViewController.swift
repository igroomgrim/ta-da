//
//  TaskFormViewController.swift
//  TADA
//
//  Created by Anak Mirasing on 10/18/2558 BE.
//  Copyright © 2558 iGROOMGRiM. All rights reserved.
//

import UIKit
import RealmSwift

class TaskFormViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        createNewTask()
    }
    
    // MARK: - Create Task
    func createNewTask() {
        
        let task = TDTask()
        task.title = titleTextField.text!
        task.taskDescription = descriptionTextView.text
        task.created = NSDate.timeIntervalSinceReferenceDate()
        
        if (titleTextField.text!.isEmpty || descriptionTextView.text.isEmpty) {
            print("notification : isEmpty")
        }else{
            print("\(task.title)")
            print("\(task.taskDescription)")
            print("\(task.done)")
            print("\(task.created)")
            
            let realm = try! Realm()
            realm.beginWrite()
            realm.add(task)
            try! realm.commitWrite()

            self.dismissViewControllerAnimated(true, completion:nil)
        }
        
    }
    
}
