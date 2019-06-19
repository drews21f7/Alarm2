//
//  AlarmListTableViewController.swift
//  Alarm2
//
//  Created by Drew Seeholzer on 6/17/19.
//  Copyright © 2019 Drew Seeholzer. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class {
    func switchCellSwitchValueChanged(sender: SwitchTableViewCell)
}

class AlarmListTableViewController: UITableViewController, SwitchTableViewCellDelegate, AlarmScheduler {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AlarmController.sharedInstance.alarms.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? SwitchTableViewCell
        
        let alarm = AlarmController.sharedInstance.alarms[indexPath.row]
        
        cell?.delegate = self
        cell?.alarm = alarm
        // Configure the cell...

        return cell ?? UITableViewCell()
    }
    
    func switchCellSwitchValueChanged(sender: SwitchTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        let alarm = AlarmController.sharedInstance.alarms[indexPath.row]
        AlarmController.sharedInstance.toggleEnabled(for: alarm)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let alarm = AlarmController.sharedInstance.alarms[indexPath.row]
            AlarmController.sharedInstance.delete(alarm: alarm)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toSetAlarmSegue" {
            
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let destinationVC = segue.destination as? AlarmDetailTableViewController
            
            let alarm = AlarmController.sharedInstance.alarms[indexPath.row]
            
            destinationVC?.alarm = alarm
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}

