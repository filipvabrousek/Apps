/*

SIRI INTENT EXTENSION

*/



import Intents

class IntentHandler: INExtension, INSendMessageIntentHandling {
    
    
    /*                                      RESOLVE CONTENT                               */
    
    func resolveContent(forSendMessage intent: INSendMessageIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        
        if let content = intent.content{
            print("Content: \(content)")
            let response = INStringResolutionResult.success(with: content)
            completion(response)
            
        } else {
            let response = INStringResolutionResult.needsValue()
            completion(response)
            
        }
    }
    
    
    
    /*                            CHECK IF THE USER IS LOGGED IN                         */
    func confirm(sendMessage intent: INSendMessageIntent, completion: @escaping (INSendMessageIntentResponse) -> Void) {
        
        let isLoggedIn = true
        
        if isLoggedIn{
            
            completion(INSendMessageIntentResponse(code: .success, userActivity: nil))
            
        } else{
            completion(INSendMessageIntentResponse(code: .failureRequiringAppLaunch, userActivity: nil))
            
        }
        
        
        
        
    }
    
    
    
    /*                                   SEND MESSAGE                             */
    func handle(sendMessage intent: INSendMessageIntent, completion: @escaping (INSendMessageIntentResponse) -> Void) {
        // send message
    }
    
}

