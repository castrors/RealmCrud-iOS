//
//  ViewController.swift
//  RealmCrud
//
//  Created by Alessandro Nakamuta on 8/10/16.
//  Copyright © 2016 Jera. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    let realm = try! Realm()
    
    lazy var items: Results<Item> = {
        return self.realm.objects(Item.self)
    }()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    @IBAction func editAction(sender: AnyObject) {
        
        tableView.setEditing(!tableView.editing, animated: true)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editItemSegue"{
            let newItemViewController = segue.destinationViewController as! NewItemViewController
            
            newItemViewController.editItem = sender as! Item
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return items.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let item = items[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("itemCellId", forIndexPath: indexPath)
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.subtitle
        cell.accessoryType = item.done ? .Checkmark : .None
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = items[indexPath.row]
        
        self.performSegueWithIdentifier("editItemSegue", sender: item)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            let item = items[indexPath.row]
            try! realm.write {
                realm.delete(item)
            }
            
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
}