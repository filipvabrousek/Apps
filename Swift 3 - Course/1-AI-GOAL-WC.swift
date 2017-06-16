//
//  ViewController.swift
//  Firi
//
//  Created by Filip Vabroušek on 10.06.17.
//  Copyright © 2017 Filip Vabroušek. All rights reserved.
//

import UIKit
import Speech

class ViewController: UIViewController, SFSpeechRecognizerDelegate {
    
    let SR = SFSpeechRecognizer()
    let AE = AVAudioEngine()
    var RR = SFSpeechAudioBufferRecognitionRequest()
    var RT = SFSpeechRecognitionTask()
    
    var str: String? = nil
    
    
    @IBOutlet var label: UILabel!
    @IBOutlet var webView: UIWebView!
    @IBOutlet var recordBtn: UIButton!
    
    
    /*--------------------------------------------------------------RECORD------------------------------------------------------*/
    @IBAction func record(_ sender: Any) {
        
        if AE.isRunning {
            
            AE.stop()
            RR.endAudio()
            RT.cancel()
            
            recordBtn.setTitle("Start Recording", for: [])
            
        } else {
            
            recordBtn.setTitle("Stop Recording", for: [])
            
            
            //-------------------------------------------------------------------------
            do {
                
                let audioSession = AVAudioSession.sharedInstance()
                try audioSession.setCategory(AVAudioSessionCategoryRecord)
                try audioSession.setMode(AVAudioSessionModeMeasurement)
                try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
                
                
                
                
                //--------------------------------
                if let inputNode = AE.inputNode {
                    
                    RR.shouldReportPartialResults = true
                    
                    //--------------------------------
                    RT = SR!.recognitionTask(with: RR, resultHandler: { (result, error) in
                        
                        
                        if let result = result {
                            
                            //  write result
                            self.str = result.bestTranscription.formattedString
                            print(self.str)
                            
                            //  create alert
                            self.createAlert(title: "Website will be opened", m: "Here")
                            self.label.text = "https://\(self.str!).org"
                            
                            //  load website
                            let data = self.label.text
                            let adress = URL(string: data!)
                            let request = URLRequest(url: adress!)
                            self.webView.loadRequest(request)
                            print(request)
                            
                     
                            
                            
                            if result.isFinal {
                                self.AE.stop()
                                inputNode.removeTap(onBus: 0)
                                self.recordBtn.setTitle("Start Recording", for: [])
                            }
                        }
                        
                        
                    })
                    
                    
                    let recordingFormat = inputNode.outputFormat(forBus: 0)
                    
                    inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat, block: { (buffer, when) in
                        self.RR.append(buffer)
                    })
                    
                    AE.prepare()
                    
                    try AE.start()
                    
                } //do
                
            } catch {
                
                // Handle errors
                
            } //catch
            
            
            
        }
        
        
        
        
    }
    
    
 
    
    func createAlert(title: String, m:String){
        
        let alert = UIAlertController(title: title, message: m, preferredStyle: .alert)
        
        
       alert.addAction(UIAlertAction(title: "Hi", style: .default, handler: { (action) in
        alert.dismiss(animated: true, completion: nil)
       }))
    
        self.present(alert, animated: true, completion: nil)
    
    }
    
    
    
    /*------------------------------------------------------------VIEW DID LOAD-------------------------------------------------------*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SR?.delegate = self
        
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            
            OperationQueue.main.addOperation ({
                
                
                switch authStatus{
                    
                case .authorized:
                    self.recordBtn.isEnabled = true
                    
                case .denied:
                    self.recordBtn.isEnabled = false
                    self.recordBtn.setTitle("User denied access", for: [])
                    
                case .restricted:
                    self.recordBtn.setTitle("Speech recognition ", for: [])
                    
                case .notDetermined:
                    self.recordBtn.isEnabled = false
                    self.recordBtn.setTitle("Speech recognition has not yet been determined", for: [])
                }
                
            })
            
            
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

