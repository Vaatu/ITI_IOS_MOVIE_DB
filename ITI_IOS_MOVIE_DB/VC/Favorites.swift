//
//  Favorites.swift
//  ITI_IOS_MOVIE_DB
//
//  Created by Aly Ayoub on 3/16/20.
//  Copyright © 2020 Muhammad El-Arabi. All rights reserved.
//

import UIKit
import CoreData

class Favorites: UITableViewController {
    
    var titleArray = [NSManagedObject]()
    var arr : [String] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let request = NSFetchRequest<NSManagedObject>(entityName: "Favorited")
        //
        //        do {
        //           titleArray = try context.fetch(request)
        //        } catch  {
        //            print("Error Loading Favourites")
        //        }
        
        getTitlesFromDB()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arr.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
//        for item in titleArray {
//            let myTitle = item.value(forKey: "title")
//            arr?.append(myTitle as! String)
//        }
        
        cell.textLabel?.text = arr[indexPath.row]
        return cell
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
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let manageContext  = appDelegate.persistentContainer.viewContext
        
        // 3 del from manage context
        
        manageContext.delete(titleArray[indexPath.row])
        
        do {
            try manageContext.save()
            
        }catch let error{
            
            print (error)
            
        }
        titleArray.remove(at: indexPath.row)
        arr.remove(at: indexPath.row)
        
        
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    func getTitlesFromDB(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let manageContext  = appDelegate.persistentContainer.viewContext
        
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "Favorited")
        do {
            var titleArray = [NSManagedObject]()
            
            titleArray = try manageContext.fetch(fetchReq)
            
            for obj in titleArray {
                
                self.titleArray.append(obj)
                arr.append(obj.value(forKey: "title") as! String)
            }
            
            self.tableView.reloadData()
        }catch let error{
            
            print (error)
            
        }
        
    }
}
