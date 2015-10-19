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
    @IBOutlet weak var statusSwitch: UISwitch!
    var task: TDTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let task = task {
            titleTextField.text = task.title
            descriptionTextView.text = task.taskDescription
            if task.done {
                statusSwitch.setOn(true, animated: false)
            }
        }
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
        if let task = task {
            updateTask(task)
        }else{
            createNewTask()
        }
    }
    
    // MARK: - Create Task
    func createNewTask() {
        
        let task = TDTask()
        
        if (titleTextField.text!.isEmpty || descriptionTextView.text.isEmpty) {
            print("notification : isEmpty")
        }else{
            task.title = titleTextField.text!
            task.taskDescription = descriptionTextView.text
            task.created = NSDate.timeIntervalSinceReferenceDate()
            if statusSwitch.on {
                task.done = true
            }else{
                task.done = false
            }
            
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
    
    // MARK: - Update Task
    func updateTask(task: TDTask) {
        
        let realm = try! Realm()
        realm.beginWrite()

        task.title = titleTextField.text!
        task.taskDescription = descriptionTextView.text
        if statusSwitch.on {
            task.done = true
        }else{
            task.done = false
        }
        
        try! realm.commitWrite()
        
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    
}
