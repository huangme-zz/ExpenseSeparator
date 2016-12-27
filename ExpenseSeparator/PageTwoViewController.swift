//
//  PageTwoViewController.swift
//  ExpenseSeparator
//
//  Created by Meng Huang on 10/23/16.
//  Copyright © 2016 Meng Huang. All rights reserved.
//

import UIKit

class PageTwoViewController: UIViewController {
  
  var numAttendence: Int!
  var textFields = [UITextField]()
  var Labels = [UILabel]()
  
  let defaultColor: UIColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    // initializing parameters
    let default_width = 100, default_height = 25
    let base_x = 75, base_y = 10, inc = default_height+10
    
    // setting labels and text fields based on the number of attendence
    for i in 1...self.numAttendence {
      // label
      let label: UILabel! = UILabel(frame: CGRect(x: 0, y: 0, width: default_width, height: default_height))
      label.center = CGPoint(x: base_x, y: base_y+i*inc)
      label.text = "Person \(i):"
      self.view.addSubview(label)
      self.Labels.append(label)
      
      // text field
      let field: UITextField! = UITextField(frame: CGRect(x: 0, y: 0, width: default_width*2, height: default_height))
      field.center = CGPoint(x: base_x+175, y: base_y+i*inc)
      field.text = "Person \(i)"
      field.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
      field.layer.borderWidth = 0.6
      field.layer.cornerRadius = 5.0
      field.layer.borderColor = self.defaultColor.cgColor
      self.view.addSubview(field)
      self.textFields.append(field)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "Next" {
      let DestViewController: PageThreeViewController = segue.destination as! PageThreeViewController
    
      for i in 0..<self.textFields.count {
        DestViewController.attendences.append(self.textFields[i].text!)
      }
    }
    
    else if segue.identifier == "Back" {
      
    }
  }
  
  @IBAction func clickBack_PageTwo(_ sender: UIButton) {
    performSegue(withIdentifier: "Back", sender: self)
  }
  
  @IBAction func clickNext_PageTwo(_ sender: UIButton) {
    performSegue(withIdentifier: "Next", sender: self)
  }
}
