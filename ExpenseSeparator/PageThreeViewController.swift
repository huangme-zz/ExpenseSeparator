//
//  PageThreeViewController.swift
//  ExpenseSeparator
//
//  Created by Meng Huang on 10/23/16.
//  Copyright © 2016 Meng Huang. All rights reserved.
//

import UIKit

class Event {
  var event_name: String! = ""
  var attended = [Bool]()
  var paid = [Float]()
  var ratio = [Float]()
  
  init(name: String!) {
    self.event_name = name
  }
}

class PageThreeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
  
  var attendences = [String!]()
  var events = [Event!]()
  
  @IBOutlet weak var eventPickerView: UIPickerView!
  @IBOutlet weak var personPickerView: UIPickerView!
  
  @IBOutlet weak var statusAttended: UISwitch!
  @IBOutlet weak var textPaid: UITextField!
  @IBOutlet weak var textRatio: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.statusAttended.setOn(false, animated: true)
    self.textPaid.text = "0.0"
    self.textRatio.text = "0.0"
    
    self.personPickerView.isUserInteractionEnabled = false
    self.statusAttended.isEnabled = false
    self.textPaid.isEnabled = false
    self.textRatio.isEnabled = false
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // Button - Add Event
  @IBAction func clickAddEvent_PageThree(_ sender: UIButton) {
    let alert = UIAlertController(title: "Event", message: "Event's Name", preferredStyle: UIAlertControllerStyle.alert)
    
    alert.addTextField { (text_field) in
      text_field.placeholder = "Event's Name"
    }
    
    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
    
    alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler:
      { (_) in
        self.events.append(Event(name: alert.textFields![0].text!))
        self.eventPickerView.reloadComponent(0)
        
        self.personPickerView.isUserInteractionEnabled = true
        self.statusAttended.isEnabled = true
        self.statusAttended.isOn = false
        self.textPaid.isEnabled = false
        self.textRatio.isEnabled = false
      }))
    
    self.present(alert, animated: true, completion: nil)
  }
  
  
  // Button - Remove Event
  @IBAction func clickRemoveEvent_PageThree(_ sender: UIButton) {
    let row = self.eventPickerView.selectedRow(inComponent: 0)
    
    if row >= self.eventPickerView.numberOfRows(inComponent: 0) {
      return
    }
    
    let alert = UIAlertController(title: "Remove Event", message: "Are you sure you want to remove Event: \(self.events[row].event_name)?", preferredStyle: UIAlertControllerStyle.alert)
    
    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
    
    alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default, handler:
      { (_) in
        self.events.remove(at: row)
        self.eventPickerView.reloadComponent(0)
        if self.eventPickerView.numberOfRows(inComponent: 0) < 1 {
          self.personPickerView.isUserInteractionEnabled = false
          self.statusAttended.isEnabled = false
          self.textPaid.isEnabled = false
          self.textRatio.isEnabled = false
        }
      }))
    
    self.present(alert, animated: true, completion: nil)
  }
  
  // PickerView - Event && PickerView - Person
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if pickerView == self.eventPickerView {
      return self.events.count
    }
    else if pickerView == self.personPickerView {
      return self.attendences.count
    }
    return 0
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if pickerView == self.eventPickerView {
      if row < self.eventPickerView.numberOfRows(inComponent: 0) {
        return self.events[row].event_name
      }
    }
    else if pickerView == self.personPickerView {
      if row < self.personPickerView.numberOfRows(inComponent: 0) {
        return self.attendences[row]
      }
    }
    return nil
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
  }
  
  // Switch - Attended
  @IBAction func switchAttended_PageThree(_ sender: UISwitch) {
    if self.statusAttended.isOn {
      self.textPaid.isEnabled = true
      self.textRatio.isEnabled = true
    }
    else {
      self.textPaid.isEnabled = false
      self.textRatio.isEnabled = false
    }
  }
  
  // TextField - Paid
  @IBAction func inputPaid_PageThree(_ sender: UITextField) {
  }
  
  // TextField - Ratio
  @IBAction func inputRatio_PageThree(_ sender: UITextField) {
  }
  
}
