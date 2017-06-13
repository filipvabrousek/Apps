//WC1
//1ST

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    
    var items: [String] = []

    
    
     /*                                    COUNT THE CELLS                              */
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
        
    }
    
      /*                                     FILL IN CELLS                                */
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    
    
      /*                                      RELOAD DATA                                 */
    override func viewDidAppear(_ animated: Bool) {
        let itemsObject = UserDefaults.standard.object(forKey: "items")
    
        if let tempItems = itemsObject as? [String] {
            items = tempItems
        }
        table.reloadData()
    }
    
 
    
    
    /*                                      DELETE DATA                                 */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            items.remove(at: indexPath.row)
            table.reloadData()
            UserDefaults.standard.set(items, forKey: "items")
            
        }
        
    }
  
  /*                                     OVERRIDE FUNCTIONS                                */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}




//WC 2
//2nd

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var itemTextField: UITextField!
    
    /*                                      ADD()                               */
    @IBAction func add(_ sender: AnyObject) {
        
        let itemsObject = UserDefaults.standard.object(forKey: "items")
        var items:[String]
        
        if let tempItems = itemsObject as? [String] {
            
            items = tempItems
            items.append(itemTextField.text!)
            print(items)
        } else {
            items = [itemTextField.text!]
            
        }
        //save data to permanent storage
        UserDefaults.standard.set(items, forKey: "items")
        itemTextField.text = ""
        
    }
    
    
    
    
    /*                                      WORK WITH KEYBOARD                               */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    
    /*                                     OVERRIDE FUNCTIONS 2                              */
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}


