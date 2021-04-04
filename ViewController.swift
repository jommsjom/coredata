//
//  ViewController.swift
//  DATABASE_SWIFT
//
//  Created by iROID Technologies on 04/02/19.
//  Copyright © 2019 iROID Technologies. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController
{

    @IBOutlet weak var colour_txtfld: UITextField!
    @IBOutlet weak var name_txt: UITextField!
    @IBOutlet weak var lang_txt: UITextField!
var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBOutlet weak var search_txt: UITextField!
    
    
    
    
    @IBOutlet weak var lbl_details: UILabel!
    
    
    
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func save_btn(_ sender: Any)
    {
        //getting values from txtfields
        
        let citynam = self.name_txt.text
        let cityclr = self.colour_txtfld.text
        let citylang = self.lang_txt.text
        
        //valiate input values
     
       //
        let  newcity = NSEntityDescription.insertNewObject(forEntityName: "CityLib", into: context)
        
        newcity.setValue(self.name_txt.text, forKey: "cityname")
        newcity.setValue(self.colour_txtfld.text, forKey: "citycolour")
        newcity.setValue(self.lang_txt.text, forKey: "citylang")
        
        do
        {
            try context.save()
//            self.colour_txtfld.text = ""
//            self.name_txt.text = ""
//            self.lang_txt.text = ""
        }
        catch
        {
            print("error")
        }
        
    }
    
    
    
    @IBAction func search_btn(_ sender: Any)
    {
        
        let request = NSFetchRequest <NSFetchRequestResult>(entityName: "CityLib")
        let searchstring  = self.search_txt.text
    //    request.predicate = NSPredicate(format:"cityname %k", searchstring!)
       request.predicate = NSPredicate(format: "cityname == %@", searchstring!)
         var outputstr = ""
        do
        {
            let result = try context.fetch(request)
            if result.count > 0
            {
                for oneline in result
                {
                    let onecity = (oneline as AnyObject).value(forKey: "cityname") as! String
                    let onecolour = (oneline as AnyObject).value(forKey: "citycolour") as! String
                    let onelanguage = (oneline as AnyObject).value(forKey: "citylang") as! String
                    
                    outputstr += onecity + " " + onecolour + " " + onelanguage + " "
                    
                }
            
            }
                
                else
            {
                    outputstr = "no match found"
                }
            self.search_txt?.text = outputstr
            
        }
            catch
            {
                print("error")
            }
    
}


    @IBAction func details_btn(_ sender: Any)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "City_ViewController") as! City_ViewController
        self.present(nextViewController, animated:true, completion:nil)
    }

    @IBAction func update_btn(_ sender: Any)
    {
        name_txt.text = ""
        self.name_txt.text = setValue(self.name_txt.text, forKey: "cityname") as! String
    }
    
}
