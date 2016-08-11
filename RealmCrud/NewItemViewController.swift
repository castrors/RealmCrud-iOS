//
//  NewItemViewController.swift
//  RealmCrud
//
//  Created by Alessandro Nakamuta on 8/10/16.
//  Copyright © 2016 Jera. All rights reserved.
//

import UIKit
import RealmSwift

class NewItemViewController: UIViewController {
    private let realm = try! Realm()
    
    var editItem: Item?

    @IBOutlet private weak var titleTextField: UITextField!
    @IBOutlet private weak var subtitleTextField: UITextField!
    @IBOutlet private weak var doneSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let editItem = editItem{
            titleTextField.text = editItem.title
            subtitleTextField.text = editItem.subtitle
            doneSwitch.on = editItem.done
        }else{
            doneSwitch.on = false
        }
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneAction(sender: AnyObject) {
        
        let item: Item
        if let editItem = editItem{
            item = editItem
        }else{
            item = Item()
            try! realm.write {
                realm.add(item)
            }
        }
        
        try! realm.write {
            item.title = titleTextField.text ?? ""
            item.subtitle = subtitleTextField.text ?? ""
            item.done = doneSwitch.on
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }

}
