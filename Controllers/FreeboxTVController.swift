//
//  FreeboxTVController.swift
//  simpleFreeboxRemote
//
//  Created by Thomas Munoz on 13/06/2015.
//  Copyright (c) 2015 Thomas Munoz. All rights reserved.
//

import Foundation

class FreeboxTVController {
    
    private var controllerId : String?;
    private let baseUrl : String = "http://hd1.freebox.fr/pub/remote_control";
    
    init (){}
    
    func changeChannel(channel: Int){
        if(channel <= 9 && channel > 0){
            var key : String = String(channel);
            self.performAction(key);
        }
    }
    
    func nextChannel(){
        self.performAction("prgm_inc");
    }
    
    func previousChannel(){
        self.performAction("prgm_dec");
    }
    
    func setControllerId(controllerId : String){
        self.controllerId = controllerId;
    }
    
    func getControllerId() -> String? {
        return self.controllerId;
    }

    
    func performAction(key : String){
        var controller : String = self.controllerId!;
        var path = self.baseUrl + "?code=" + self.controllerId! +  "&key=" + key;

        let url = NSURL(string: path);
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
        }
        
        task.resume();
    }
    
}