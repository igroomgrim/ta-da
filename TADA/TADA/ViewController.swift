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
    @IBOutlet weak var statusSwitch: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let realm = try! Realm()
        print(realm.path)
        
        let tasks = realm.objects(TDTask)
        print(tasks)
        
        statusSwitch.selectedSegmentIndex = 0;
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

        if statusSwitch.selectedSegmentIndex == 0 {
            let predicateTaskSuccess = NSPredicate(format: "done == %@", NSNumber(bool: true))
            return realm.objects(TDTask).filter(predicateTaskSuccess).count
        }else{
            let predicateTaskUnsuccess = NSPredicate(format: "done == %@", NSNumber(bool: false))
            return realm.objects(TDTask).filter(predicateTaskUnsuccess).count
        }
    }
    
    func configureCell(cell: UITableViewCell, identifier: String, indexPath:NSIndexPath){
        let realm = try! Realm()
        
        var predicate = NSPredicate()
        if statusSwitch.selectedSegmentIndex == 0 {
            predicate = NSPredicate(format: "done == %@", NSNumber(bool: true))
        }else{
            predicate = NSPredicate(format: "done == %@", NSNumber(bool: false))
        }

        let tasks = realm.objects(TDTask).filter(predicate).sorted("created",ascending:false)
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
        
        var predicate = NSPredicate()
        if statusSwitch.selectedSegmentIndex == 0 {
            predicate = NSPredicate(format: "done == %@", NSNumber(bool: true))
        }else{
            predicate = NSPredicate(format: "done == %@", NSNumber(bool: false))
        }
        
        let tasks = realm.objects(TDTask).filter(predicate).sorted("created",ascending:false)
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
    
    @IBAction func statusChanged(sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
}

