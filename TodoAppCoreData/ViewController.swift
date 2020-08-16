//
//  ViewController.swift
//  TodoAppCoreData
//
//  Created by user on 2020/08/16.
//  Copyright © 2020 user. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var tasks : [Task] = []
    

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        getData()
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let task = tasks[indexPath.row]
        
        if task.isImportant {
            cell.textLabel?.text = "👺" + task.name!
        } else {
            cell.textLabel?.text = task.name!
        }
        return cell
    }

    

    func getData() {
        //コンテキスト作成
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        do{
            tasks = try context.fetch(Task.fetchRequest())
        }
        catch{
            print("読み込み失敗")
        }
    }

    // セルが削除が可能なことを伝えるメソッド
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath)-> UITableViewCell.EditingStyle {
        return .delete
    }
    //delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath:IndexPath){
        //コンテキスト作成
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


        if editingStyle == .delete {

            let task = tasks[indexPath.row]
            context.delete(task)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()

            do {
                tasks = try context.fetch(Task.fetchRequest())
            }
            catch{
                print("読み込み失敗！")
            }
        }
        tableView.reloadData()
    }
}

