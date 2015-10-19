//
//  ViewController.swift
//  TADA
//
//  Created by Anak Mirasing on 10/17/2558 BE.
//  Copyright © 2558 iGROOMGRiM. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let realm = try! Realm()
        print(realm.path)
        
        let tasks = realm.objects(TDTask)
        print(tasks)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - TableView Datasource,Delegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = try! Realm()
        return realm.objects(TDTask).count
    }
    
    func configureCell(cell: UITableViewCell, identifier: String, indexPath:NSIndexPath){
        let realm = try! Realm()
        let tasks = realm.objects(TDTask)
        let task = tasks[indexPath.row] as TDTask
        
        cell.textLabel?.text = "\(task.title)"
        
        if task.done {
            cell.accessoryType = .Checkmark
        }else{
            cell.accessoryType = .None
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "TaskCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
        
        configureCell(cell, identifier: identifier, indexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let realm = try! Realm()
        let tasks = realm.objects(TDTask)
        let task = tasks[indexPath.row] as TDTask
        
        performSegueWithIdentifier("TaskFormSegue", sender: task)
        
    }
    
    // MARK: - Action
    @IBAction func createTaskButtonTapped(sender: AnyObject) {
        performSegueWithIdentifier("TaskFormSegue", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "TaskFormSegue" {
            if sender != nil {
                if let taskFormViewController = segue.destinationViewController as? TaskFormViewController {
                    if let task = sender as? TDTask {
                        taskFormViewController.task = task
                    }
                }
            }
        }
    }
}

