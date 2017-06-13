//
//  ViewController.swift
//  SpeechRecog
//
//  Created by Filip Vabroušek on 08.12.16.
//  Copyright © 2016 Filip Vabroušek. All rights reserved.
//

import UIKit
import Speech

class ViewController: UIViewController, SFSpeechRecognizerDelegate {
    
    @IBOutlet var textView: UITextView!
    
    let SR = SFSpeechRecognizer()
    let AE = AVAudioEngine()
    var RR = SFSpeechAudioBufferRecognitionRequest()
    var RT = SFSpeechRecognitionTask()
    
    
    
    
    @IBOutlet var recordingBtn: UIButton!
    
    
    /*                                              RECORD                                              */
    @IBAction func record(_ sender: Any) {
        
        
        if AE.isRunning{
            AE.stop()
            RR.endAudio()
            RT.cancel()
            recordingBtn.setTitle("Start recording", for: [])
            
        } else {
            
            recordingBtn.setTitle("Stop recording", for: [])
            
            
            do{
                let AS = AVAudioSession.sharedInstance()
                try AS.setCategory(AVAudioSessionCategoryRecord)
                try AS.setMode(AVAudioSessionModeMeasurement)
                try AS.setActive(true, with: .notifyOthersOnDeactivation)
                
                if let inputNode = AE.inputNode{
                    
                    RR.shouldReportPartialResults = true
                    RT = SR!.recognitionTask(with: RR, resultHandler: { (result, error) in
                        
                        if let result = result{
                            self.textView.text = result.bestTranscription.formattedString
                            
                            if result.isFinal{
                                self.AE.stop()
                                inputNode.removeTap(onBus: 0)
                                
                                self.recordingBtn.setTitle("Start recording", for: [])
                                
                            }
                        }
                    })
                    
                    let recordingFormat = inputNode.outputFormat(forBus: 0)
                    inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat, block: { (buffer, when) in
                        self.RR.append(buffer)
                        
                        
                    })
                    
                    AE.prepare()
                    try AE.start()
                    
                }
                
            }
                
            catch{
              
              //handle errors
                   
            }
            
            
        }
        
    }
    
    
    
    
    /*                                             REQUEST AUTHORIZATION                                    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        SR?.delegate = self
        
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            
            
            OperationQueue.main.addOperation ({
                
                
                switch authStatus{
                    
                case .authorized:
                    self.recordingBtn.isEnabled = true
                    
                case .denied:
                    self.recordingBtn.isEnabled = false
                    self.recordingBtn.setTitle("User denied acces to speechRecognition", for: [])
                    
                case .restricted:
                    self.recordingBtn.isEnabled = false
                    self.recordingBtn.setTitle("Speech recognition is restricted on this device", for: [])
                    
                case .notDetermined:
                    self.recordingBtn.isEnabled = false
                    self.recordingBtn.setTitle("Speech recognition has not yet been determined", for: [])
                }
            })
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

