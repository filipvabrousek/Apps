//
//  TotalsViewController.swift
//  Runny
//
//  Created by Filip Vabroušek on 28.09.17.
//  Copyright © 2017 Filip Vabroušek. All rights reserved.
//

import UIKit
import CoreData



class TotalsViewController: UIViewController {

    @IBOutlet var goalLabel: UILabel!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var progressLabel: UILabel!
    @IBOutlet var badgeView: UIImageView!

     var total:Double = 0.0
     var runs = [Run]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalLabel.alpha = 0
        badgeView.alpha = 0
        fetchArrayFromCoreData()
        updateProgress()
        
    }

   
    
    func updateProgress(){
        
        for item in runs{
            total += Double(item.distance)!
        }
        let rounded = (total * 100).rounded() / 100
        
        let progressVal = total / 100.0
        progressBar.setProgress(Float(progressVal), animated: false)
        progressLabel.text = String("\(rounded) / 100 km (\(rounded) %)")
        
        
        if (progressVal * 100) > 1{
            badgeView.image = UIImage(named: "silver-badge.png")
        }
        
        if (progressVal * 100) > 100{
            badgeView.image = UIImage(named:"gold-badge.png")
            progressBar.progressTintColor = UIColor.green
            animateLabels()
        }

    }
    
    func animateLabels(){
        UIView.animate(withDuration: 1, animations: {
            self.goalLabel.alpha = 1
            self.goalLabel.isHighlighted = true
            self.progressLabel.alpha = 0
            self.badgeView.alpha = 1
        })
    }

    @IBAction func deleteData(_ sender: Any) {
        let delete = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Activities")
            request.returnsObjectsAsFaults = false
            
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
            
            
            do {
                try context.execute(deleteRequest)
                try context.save()
                print("Deleted")
            }
                
            catch {
                print("Deletion failed")
            }
            self.total = 0
            
        }
        
        
        let alert = UIAlertController(title: "Delete all data", message: "Are you sure you want to delete all runs?", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        })
        
        alert.addAction(delete)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    
    
  
    
  
    
    
    func fetchArrayFromCoreData()  {
        runs.removeAll()
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Activities")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            if results.count > 0 {
                for res in results as! [NSManagedObject]{
                    
                    if let run = res.value(forKey: "runs") as? Run {
                        runs.append(run)
                    }
                    
                }
                
                
            }
            
        }
            
        catch {
            print("Error")
        }
    }
}


