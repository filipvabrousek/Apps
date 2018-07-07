
class MSaver{
    
    var ename: String
    var key: String
    var obj: MPMediaItem
    init(ename: String, key: String, obj: MPMediaItem){
        self.ename = ename
        self.key = key
        self.obj = obj
    }
    
    
    func save(){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: ename, in: context)
        let device = NSManagedObject(entity: entity!, insertInto: context)
        
        device.setValue(obj, forKey: key)
        
        do {
            try context.save()
            print("saved songs")
        }
        catch{
            
        }
    }
}

// DIDLOAD

  let fetcher = Fetcher(ename: "Songs", key: "songs")
        let res = fetcher.fetchM()
        
        for s in res {
            titles.append(s.title!)
            songs.append(s.assetURL!)
        }
      //  print("aaand title is \(res[0].title)")
        tableView.reloadData()
        
        
        
        
