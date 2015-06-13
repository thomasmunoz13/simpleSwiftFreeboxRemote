//
//  ViewController.swift
//  simpleFreeboxRemote
//
//  Created by Thomas Munoz on 13/06/2015.
//  Copyright (c) 2015 Thomas Munoz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var controllerIdField: UITextField!
    @IBOutlet var setControllerIdButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    
    var remoteObject : FreeboxTVController = FreeboxTVController();
    var controllerId : String = "0";
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
    let controllerIdMaxLength = 8;
    
    override func viewDidLoad() {
        if(self.defaults.stringForKey("controllerId") != nil && self.controllerIdField != nil){
            self.controllerIdField.text = self.defaults.stringForKey("controllerId")!;
        }
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func onButtonTouch(sender: AnyObject) {
        var valueForKey = self.defaults.stringForKey("controllerId");
        
        var value = (valueForKey == nil) ? self.controllerIdField.text : valueForKey;
        
        if(value != nil && count(value) == self.controllerIdMaxLength){
            var controller = value.toInt();
            
            if(controller > 9999999) {
                self.controllerId = value;
                self.defaults.setObject(value, forKey: "controllerId");
            } else {
                self.displayErrorMessage();
            }
        } else {
            self.displayErrorMessage();
        }
    }
    
    @IBAction func changeChannel(sender: AnyObject) {
        self.remoteObject.setControllerId(self.defaults.stringForKey("controllerId")!);
        
        var trans : String?
        trans = sender.currentTitle!;
        var channel : Int = trans!.toInt()!;
        
        self.remoteObject.changeChannel(channel);
    }
    
    @IBAction func onNavigationButtonTouch(sender: AnyObject) {
        self.remoteObject.setControllerId(self.defaults.stringForKey("controllerId")!);
        
        var direction = sender.currentTitle;
        
        if(direction == "Previous"){
            self.remoteObject.previousChannel();
        } else if (direction == "Next") {
            self.remoteObject.nextChannel();
        }
    }
    
    func displayErrorMessage(){
        var alert = UIAlertView()
        
        alert.title = "Saisie incorrecte"
        alert.message = "Le numéro que vous avez saisi n'est pas correct, veuillez rééssayer";
        alert.addButtonWithTitle("D'accord")
        alert.show()
    }

}
