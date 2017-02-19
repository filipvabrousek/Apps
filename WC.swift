
import UIKit

class LoginViewController: UIViewController {
  
  
  
  // MARK: Outlets
  @IBOutlet weak var textFieldLoginEmail: UITextField!
  @IBOutlet weak var textFieldLoginPassword: UITextField!
  
  // MARK: Actions
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  
  /*--------------------------------------------LOGIN----------------------------------------------*/
  @IBAction func loginDidTouch(_ sender: Any) {
    FIRAuth.auth()?.signIn(withEmail: textFieldLoginEmail.text!, password: textFieldLoginPassword.text!)
  }
  
  
 /*---------------------------------------------SIGN UP--------------------------------------*/
  @IBAction func signUpDidTouch(_ sender: AnyObject) {
    let alert = UIAlertController(title: "Register", message: "Register", preferredStyle: .alert)
    
    let saveAction = UIAlertAction(title: "Save", style: .default) { action in
      
      let emailField = alert.textFields![0]
      let passwordField = alert.textFields![1]
      
      FIRAuth.auth()?.createUser(withEmail: emailField.text!, password: passwordField.text!, completion: { (user, error) in
        
        if error != nil {
          FIRAuth.auth()?.signIn(withEmail: self.textFieldLoginEmail.text!, password: self.textFieldLoginPassword.text!)
        }
      })
    }
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .default)
    
    alert.addTextField { textEmail in
      textEmail.placeholder = "Enter your email"
    }
    
    alert.addTextField { textPassword in
      textPassword.isSecureTextEntry = true
      textPassword.placeholder = "Enter your password"
    }
    
    alert.addAction(saveAction)
    alert.addAction(cancelAction)
    
    present(alert, animated: true, completion: nil)
  }
  
}



/*-------------------------------TEXTFIELD DELEGATE EXTENSION---------------------------*/
extension LoginViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == textFieldLoginEmail {
      textFieldLoginPassword.becomeFirstResponder()
    }
    if textField == textFieldLoginPassword {
      textField.resignFirstResponder()
    }
    return true
  }
  
}











/*
  Copyright (c) 2015 Razeware LLC
 */

import UIKit

class GroceryListTableViewController: UITableViewController {

  // MARK: Constants
  let listToUsers = "ListToUsers"
  
  // MARK: Properties 
  var items: [GroceryItem] = []
  var user: User!
  var userCountBarButtonItem: UIBarButtonItem!
  let ref = FIRDatabase.database().reference(withPath: "grocery-items")
  let usersRef = FIRDatabase.database().reference(withPath: "online")
  
  
  /*-------------------------------VIEW DID LOAD---------------------------
   1 - order database items by "completed"
   2 - append databse items to newItems
   3 - append items to newItems
   */
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.allowsMultipleSelectionDuringEditing = false
    
    userCountBarButtonItem = UIBarButtonItem(title: "1", style: .plain, target: self, action: #selector(self.userCountButtonDidTouch))
    userCountBarButtonItem.tintColor = UIColor.white
    navigationItem.leftBarButtonItem = userCountBarButtonItem
    
    
    //1
    ref.queryOrdered(byChild: "completed").observe(.value, with: { snapshot in
      var newItems: [GroceryItem] = []
      
      //2
      for item in snapshot.children{
      let groceryItem = GroceryItem(snapshot: item as! FIRDataSnapshot)
      newItems.append(groceryItem)
      }
      
      //3
      self.items = newItems
      self.tableView.reloadData()
    })
    
    
  /*
  ???
     
  
    
  let currentUserRef = self.usersRef.child(self.user.uid)
  currentUserRef.setValue(self.user.email)
  currentUserRef.onDisconnectRemoveValue()
    */
    
    usersRef.observe(.value, with: { (snapshot) in
      if snapshot.exists(){
      self.userCountBarButtonItem?.title = snapshot.childrenCount.description
      } else {
      self.userCountBarButtonItem?.title = "0"
      }
    })
    
    FIRAuth.auth()!.addStateDidChangeListener { auth, user in
      guard let user = user else { return }
      self.user = User(authData: user)
    }
  
  }
  
  
  /*-------------------------------TABLEVIEW METHODS--------------------------*/
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
    let groceryItem = items[indexPath.row]
    
    cell.textLabel?.text = groceryItem.name
    cell.detailTextLabel?.text = groceryItem.addedByUser
    toggleCellCheckbox(cell, isCompleted: groceryItem.completed)
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
     let groceryItem = items[indexPath.row]
    groceryItem.ref?.removeValue()
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) else { return }
    var groceryItem = items[indexPath.row]
    let toggledCompletion = !groceryItem.completed
    toggleCellCheckbox(cell, isCompleted: toggledCompletion)
    groceryItem.ref?.updateChildValues(["completed" : toggledCompletion])
  }
  
  
  
  
  /*-------------------------------TOOGLE CELL CHECKBOX (check / uncheck an item)--------------------------*/
  func toggleCellCheckbox(_ cell: UITableViewCell, isCompleted: Bool) {
    if !isCompleted {
      cell.accessoryType = .none
      cell.textLabel?.textColor = UIColor.black
      cell.detailTextLabel?.textColor = UIColor.black
    } else {
      cell.accessoryType = .checkmark
      cell.textLabel?.textColor = UIColor.gray
      cell.detailTextLabel?.textColor = UIColor.gray
    }
  }
  
  /*-------------------------------ADD ITEM--------------------------*/
  
  @IBAction func addButtonDidTouch(_ sender: AnyObject) {
    let alert = UIAlertController(title: "Grocery Item", message: "Add an Item", preferredStyle: .alert)
    
    let saveAction = UIAlertAction(title: "Save", style: .default) { action in
      guard let textField = alert.textFields?.first,
        let text = textField.text else { return }
      
      
    let groceryItem = GroceryItem(name: text, addedByUser: self.user.email, completed: false)
    let groceryItemRef = self.ref.child(text.lowercased())
    groceryItemRef.setValue(groceryItem.toAnyObject)
    
    let cancelAction = UIAlertAction(title: "Cancel",style: .default)
    alert.addTextField()
    alert.addAction(cancelAction)
    self.present(alert, animated: true, completion: nil)
  }
   alert.addAction(saveAction)
  }
  
  func userCountButtonDidTouch() {
    performSegue(withIdentifier: listToUsers, sender: nil)
  }
}








/*
 Copyright (c) 2015 Razeware LLC
*/

import UIKit

class OnlineUsersTableViewController: UITableViewController {
  
  // MARK: Constants
  let userCell = "UserCell"
  
  // MARK: Properties
  var currentUsers: [String] = []
  let usersRef = FIRDatabase.database().reference(withPath: "online")
  
  // MARK: UIViewController Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    /*-------------------------------USERS REF OBSERVE---------------1----------*/
    
    usersRef.observe(.childAdded, with: { snap in
      guard let email = snap.value as? String else { return }
      self.currentUsers.append(email)
      
      let row = self.currentUsers.count - 1
      let indexPath = IndexPath(row: row, section: 0)
      self.tableView.insertRows(at: [indexPath], with: .top)
    })
    
    usersRef.observe(.childRemoved, with: { (snap) in
      guard let emailToFind = snap.value as? String else { return }
      
      for (index, email) in self.currentUsers.enumerated(){
        if email == emailToFind{
        let indexPath = IndexPath(row: index, section: 0)
        self.currentUsers.remove(at: index)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
      
      }
    })
  }
  
  /*-------------------------------USERS REF OBSERVE---------------2----------*/

  
  // MARK: UITableView Delegate methods
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return currentUsers.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: userCell, for: indexPath)
    let onlineUserEmail = currentUsers[indexPath.row]
    cell.textLabel?.text = onlineUserEmail
    return cell
  }
  
  // MARK: Actions
  
  @IBAction func signoutButtonPressed(_ sender: AnyObject) {
    dismiss(animated: true, completion: nil)
  }
  
}




