//
//  City_ViewController.swift
//  DATABASE_SWIFT
//
//  Created by iROID Technologies on 04/02/19.
//  Copyright © 2019 iROID Technologies. All rights reserved.
//

import UIKit

class City_ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    @IBOutlet weak var tableviw: UITableView!
    var cityarray:[CityLib] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return cityarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let onrecord = cityarray[indexPath.row]
        cell.textLabel?.text = onrecord.cityname! + " " + onrecord.citylang! + " " + onrecord.citycolour!
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        
        let context = (UIApplication.shared.delegate as!AppDelegate).persistentContainer.viewContext

        if editingStyle == .delete
        {
            let city = cityarray[indexPath.row]
            context.delete(city)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do
            {
cityarray = try context.fetch(CityLib.fetchRequest())
            }
        catch
        {
            print("error")
        }
    }
    tableView.reloadData()
    }
    func fetchdata ()
    {
        let context = (UIApplication.shared.delegate as!AppDelegate).persistentContainer.viewContext
        
        do
        {
            cityarray = try context.fetch(CityLib.fetchRequest())
        }
        catch
        {
            print("error")
        }
    }
   
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableviw.delegate = self
        tableviw.dataSource = self
        // Do any additional setup after loading the view.
        
        
        
        self.fetchdata()
        self.tableviw.reloadData()
        
    }
        
  func numberOfSections(in tableView: UITableView) -> Int
{
    return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Update_ViewController") as! Update_ViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

