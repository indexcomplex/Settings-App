//
//  SettingsVC.swift
//  Settings Saved
//
//  Created by Alan Hernandez on 7/30/19.
//  Copyright © 2019 alan Hernandez. All rights reserved.
//

import UIKit

class SettingsVC: UITableViewController {


    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var likesDevSwitch: UISwitch!
    @IBOutlet weak var coolValueMeterValue: UILabel!
    @IBOutlet weak var coolMeterSlider: UISlider!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
       loadSettings()
    
    }


    
    
    
    // we set te sender to UISLider so we expect that and only that
    @IBAction func didSlideValueMeter(_ sender: UISlider) {
        
        let wholeNumber = Int(sender.value)
        coolValueMeterValue.text = String(wholeNumber)
        
        
        
    }
    
    func loadSettings(){
        // key must be exct to the saved
//       let firstName =   UserDefaults.standard.string(forKey: "firstName")
//        print(firstName ?? "No first name saved")
        
        guard
            let settingsDictionary = UserDefaults.standard.dictionary(forKey: "settings"),
            let firstName = settingsDictionary["firstName"] as? String,
            let lastName = settingsDictionary["lastNae"] as? String,
            let likesDev = settingsDictionary["likesDev"] as? Bool,
            let coolMeterValue = settingsDictionary["coolMeterValue"] as? Int
            else {return}
        
        firstNameTextField.text = firstName
        lastNameTextField.text = lastName
        likesDevSwitch.isOn = likesDev
        coolValueMeterValue.text = String(coolMeterValue)
        coolMeterSlider.value = Float(coolMeterValue)
        
    }
    
    
    
    
    
    func saveSettings(){
        
        let settingsDictionary : [String: Any?] = ["firstName": firstNameTextField.text, "lastName:": lastNameTextField.text, "likesDev:" :likesDevSwitch.isOn, "coolMeterValue:": Int(coolMeterSlider.value)]
        
        //to Save its easy
//         UserDefaults.standard.set(firstNameTextField.text, forKey: "firstName")
//        UserDefaults.standard.set(lastNameTextField.text, forKey: "LastName")
        
        
        UserDefaults.standard.set(settingsDictionary, forKey: "settings")
        
        
        
    }
    
    func didSaveAlert() {
        
        let alert = UIAlertController(title: "Savd Settigs", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel)
        alert.addAction(action)
        present(alert,animated:  true)
    }
    
    
    //tableVC has function didSelectRow
    // we have to override as its already predefinded so OverRide bc we're gonna redefine it
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 2 else{return}
        print("Save")
        saveSettings()
        DispatchQueue.main.async {
            self.didSaveAlert()
        }
        
        
        
    }
    
    
    
    
    
    
}
