//
//  AddTaskViewController.swift
//  TodoAppCoreData
//
//  Created by user on 2020/08/16.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit
import CoreData

class AddTaskViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var isImportant: UISwitch!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func btnTapped(_ sender: Any) {
        //コンテキスト作成
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        let task = Task(context: context)
        task.name = textField.text!
        task.isImportant = isImportant.isOn

        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
        
    }



}
