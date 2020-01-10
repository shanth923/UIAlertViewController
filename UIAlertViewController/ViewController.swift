//
//  ViewController.swift
//  UIAlertViewController
//
//  Created by D.Natraj on 1/3/20.
//  Copyright © 2020 D.Natraj. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var scrollView: UIScrollView!
    

    
    var alertView = UIAlertController()
    var alertMsg = UIAlertController()
    var firstNameTXTField:UITextField!
    var lastNameTXTField:UITextField!
    var toCheck:Bool!
    var dic:NSDictionary!
    var dataArray:[String]=[]
    var www:[NSDictionary] = []

    
    var tapOn:UIButton!
    
    var mobileNoLabel:UILabel!
    var emailLabel:UILabel!
    var FNLabel:UILabel!
    var LNLabel:UILabel!
    var AgeLabel0:UILabel!
    var mobileNoLabel0:UILabel!
    var emailLabel0:UILabel!
    var DOBLabel:UILabel!
    var DOBLabel0:UILabel!
    var label1:UILabel!
    var label2:UILabel!
    var label3 : UILabel!
    var label4 : UILabel!
    var label5 : UILabel!


    
    

    @IBOutlet weak var DOBTXTField: UITextField!
    {
        didSet
        {
             DOBTXTField.textFieldSetUp(UIImage(named: "dob")!)
        }
    }
    
    @IBOutlet weak var MBNOTXTField: UITextField!
    {
        didSet
        {
            MBNOTXTField.textFieldSetUp(UIImage(named: "mobile")!)
        }
    }
    @IBOutlet weak var eMailTXTField: UITextField!
    {
        didSet
        {
              eMailTXTField.textFieldSetUp(UIImage(named: "email")!)

        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scroll.showsHorizontalScrollIndicator=false
        DOBTXTField.delegate=self
        MBNOTXTField.delegate=self
        eMailTXTField.delegate=self
        
//        firstNameTXTField.delegate=self
//        lastNameTXTField.delegate=self
        
//        Labels
              FNLabel = UILabel()
              FNLabel.frame = CGRect(x: 30, y: 60, width: 100, height: 34)
              scrollView.addSubview(FNLabel)

               LNLabel = UILabel()
               LNLabel.frame = CGRect(x: 30, y: 100, width: 100, height: 34)
               scrollView.addSubview(LNLabel)

               DOBLabel0 = UILabel()
               DOBLabel0.frame = CGRect(x: 30, y: 140, width: 100, height: 34)
               scrollView.addSubview(DOBLabel0)


               mobileNoLabel0 = UILabel()
               mobileNoLabel0.frame = CGRect(x: 30, y: 180, width: 100, height: 34)
               scrollView.addSubview(mobileNoLabel0)

               emailLabel0 = UILabel()
               emailLabel0.frame = CGRect(x: 30, y: 220, width: 100, height: 34)
               scrollView.addSubview(emailLabel0)

               //labels
               label1 = UILabel()
               label1.frame = CGRect(x: 150, y: 60, width: 260, height: 34)
               scrollView.addSubview(label1)

               label2 = UILabel()
               label2.frame = CGRect(x: 150, y: 100, width: 260, height: 34)
               scrollView.addSubview(label2)

               label3 = UILabel()
               label3.frame = CGRect(x: 150, y: 140, width: 260, height: 34)
               scrollView.addSubview(label3)

               label4 = UILabel()
               label4.frame = CGRect(x: 150, y: 180, width: 260, height: 34)
               scrollView.addSubview(label4)

               label5 = UILabel()
               label5.frame = CGRect(x: 150, y: 220, width: 260, height: 34)
               scrollView.addSubview(label5)


        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.addTarget(self, action: #selector(ViewController.datePickerValueChanged(sender:)),for:UIControl.Event.valueChanged)
        DOBTXTField.inputView = datePicker
    }
    
    @IBAction func saveButton(_ sender: Any)
    {
        if(toCheck==true)
        {
        alertMsg = UIAlertController(title: "please follow" , message: "Kindly fill the below details for further process", preferredStyle: UIAlertController.Style.alert)
        present(alertMsg,animated:true,completion: nil)
        
        alertMsg.addTextField { firstNameTXTField in
            firstNameTXTField.placeholder = " Enter your first Name"
            firstNameTXTField.delegate = self
            firstNameTXTField.keyboardType = .asciiCapable
            firstNameTXTField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            

            self.alertMsg.addTextField { lastNameTXTField in
                lastNameTXTField.placeholder = " Enter your Last Name"
                lastNameTXTField.delegate = self
                lastNameTXTField.keyboardType = .asciiCapable
                lastNameTXTField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
                let submitButton = UIAlertAction(title: "Submit", style: UIAlertAction.Style.default){ (alertAction) in
                    
                    if(self.firstNameTXTField.text!.count>1 && self.lastNameTXTField.text!.count>1)
                    {
                        let getData = NewData()
                        getData.firstNameArr = "\(self.firstNameTXTField.text!)"
                        getData.lastNameArr = "\(self.lastNameTXTField.text!)"
                        getData.DOBArr = "\(self.DOBTXTField.text!)"
                        getData.mobileNoArr = "\(self.MBNOTXTField.text!)"
                        getData.emailIdArr = "\(self.eMailTXTField.text!)"
                        do{
                            let dataArr = try JSONEncoder().encode(getData)
                            UserDefaults.standard.set(dataArr,forKey: "Lock")
                        } catch
                                    {
                                            print("Something went wrong")
                                    }
                        self.tapOn = UIButton()
                        self.tapOn.frame = CGRect(x: 130, y: 450, width: 150, height: 40)
                        self.tapOn.addTarget(self, action: #selector(self.submit), for: UIControl.Event.touchUpInside)
                        self.tapOn.setImage(UIImage(named: "new"), for: UIControl.State.normal)
                        self.view.addSubview(self.tapOn)
                        
                        let fileData = UserDefaults.standard.object(forKey: "Lock")
                        
                        do
                        {
                            let saveData = try JSONDecoder().decode(NewData.self, from: fileData! as! Data)
                            self.dic=["data1":"\(saveData.firstNameArr)","data2":"\(saveData.lastNameArr)","data3":"\(saveData.DOBArr)","data4":"\(saveData.mobileNoArr)","data5":"\(saveData.emailIdArr)"]
                            self.www.append(self.dic)
                            UserDefaults.standard.set(self.www, forKey: "Lock")
                        }catch{
                                    print("Err")
                        }
                        self.eMailTXTField.text = ""
                        self.DOBTXTField.text = ""
                        self.MBNOTXTField.text = ""
                        //Alert Message
                        self.alertMsg = UIAlertController(title: "Welcome", message: "Your Registration is succesfull", preferredStyle: UIAlertController.Style.alert)
                        let ok = UIAlertAction(title: "OK" , style: UIAlertAction.Style.cancel){ (alertAction)in
                            
                        }
                        self.alertMsg.addAction(ok)
                        
                        self.present(self.alertMsg, animated: true, completion: nil)
                            
                    }
                    else
                    {
                        self.alertMsg = UIAlertController(title: "Warning", message: "Enter FirstName and LastNamer Text Fields with valid Details", preferredStyle: UIAlertController.Style.alert)
                        let ok  = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel) { (alertAction) in
                            
                        }
                        self.alertMsg.addAction(ok)
                        self.present(self.alertMsg,animated: true,completion: nil)
                    }
                 }
                    let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default) { (action) in
                        print("\(action.title!) is clicked")
                }
                self.alertMsg.addAction(submitButton)
                self.alertMsg.addAction(cancelButton)
            }
           }
            firstNameTXTField = alertMsg.textFields![0]
            lastNameTXTField = alertMsg.textFields![1]
    }
        else
        {
            alertView = UIAlertController(title: "Warning", message: "Please fill all the required fields to go with the next Step", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            present(alertView,animated: true,completion: nil)
        }
    
    }
    @objc func datePickerValueChanged(sender: UIDatePicker)
    {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none
        DOBTXTField.text = formatter.string(from: sender.date)
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        textField.backgroundColor=#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        textField.backgroundColor=#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
            func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
                  {
                      
                            var returnValue:Bool = false
                          
                          if(textField==DOBTXTField)
                          {
                                  returnValue = true
                           }
                           if(textField==MBNOTXTField)
                            {
                               // print("textFieldShouldBeginEditing")
                                if(DOBTXTField.text!.count>=1)
                                    {
                                        returnValue = true
                                    }
                                else
                                    {
                                        alertView = UIAlertController(title: "Warning", message: "Please fill the date of birth first", preferredStyle: .alert)
                                        alertView.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                                        present(alertView,animated: true,completion: nil)
                                        returnValue = false
                                    }
                           }
                           else if(textField==eMailTXTField)
                            {
                                if(MBNOTXTField.text!.count == 10)
                                {
                                    toCheck=true
                                    returnValue = true
                                }
                                else
                                {
                                    alertView = UIAlertController(title: "Warning", message: "Please fill the Mobile number first", preferredStyle: .alert)
                                    alertView.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                                    present(alertView,animated: true,completion: nil)
                                    returnValue = false
                                }
                            }
                    else if(textField==firstNameTXTField)
                           {
                                returnValue=true
                            }
                    else if(textField==lastNameTXTField)
                           {
                            if(firstNameTXTField.text!.count>=2)
                                {
                                        returnValue=true
                                }
                            else
                                {
                                alertView = UIAlertController(title: "Warning", message: "Enter the first name first", preferredStyle: .alert)
                                alertView.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                                present(alertView,animated: true,completion: nil)
                              //  returnValue=false
                                }
                            
                            }
    
                     return true
                          }
    //validations to the text fields
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
            var returnValue:Bool = false

            if(textField == MBNOTXTField)
            {
                if(MBNOTXTField.text!.count == 10)
                {
                    return true
//                }
//                else
//                {
//                        alertView = UIAlertController(title: "Warning", message: "Enter Valid Mobile Number,Mobile number should contain 10 digits", preferredStyle: .alert)
//                        alertView.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
//                        present(alertView,animated: true,completion: nil)
//                        returnValue = false
                }
            }
                else if(textField == eMailTXTField)
                {
                    if(isValidEmail(emailTXTField:eMailTXTField.text!)==true)
                        {
//                            returnValue=true
//                        }
//                   else
//                    {
//                        
//                                alertView = UIAlertController(title: "Warning", message: "Kindly enter a valid email id ", preferredStyle: .alert)
//                                alertView.addAction(UIAlertAction(title: "ok", style:UIAlertAction.Style.default, handler: nil))
//                                present(alertView,animated: true,completion: nil)
//                                returnValue = false
                        
                                return isValidEmail(emailTXTField:eMailTXTField.text!)
                        }
                }
            
        return true
}
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if(textField==DOBTXTField)
        {
            let allowedCharacters = CharacterSet(charactersIn: "")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        else if(textField==MBNOTXTField)
        {
            let allowedCharacters = CharacterSet(charactersIn: "+#*1234567890")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        else if(textField==firstNameTXTField && textField==lastNameTXTField)
        {
            let allowedCharacters = CharacterSet.letters
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    
  // validation function for email TextField
    func isValidEmail(emailTXTField:String) -> Bool
           {
                let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

                let emailPred = NSPredicate(format:"SELF MATCHES %@",
                                            emailRegEx)
                return emailPred.evaluate(with: emailTXTField)
            }
    
    
    @IBAction func getDetails(_ sender: Any)
    {          var file = UserDefaults.standard.object(forKey: "Lock")
    
    
    if(file != nil)
    {
        www = UserDefaults.standard.object(forKey: "Lock") as! [NSDictionary]
        print(www)
        
        //Button
        self.tapOn = UIButton()
        self.tapOn.frame = CGRect(x: 130, y: 450, width: 150, height: 40)
        self.tapOn.addTarget(self, action: #selector(self.submit), for: UIControl.Event.touchUpInside)
        self.tapOn.setImage(UIImage(named: "new"), for: UIControl.State.normal)
        self.view.addSubview(self.tapOn)
    }else{
        self.alertMsg = UIAlertController(title: "Warning", message: "So Sorry No Saved Files", preferredStyle: UIAlertController.Style.alert)
        let ok  = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel) { (alertAction) in
            
        }
        self.alertMsg.addAction(ok)
        
        self.present(self.alertMsg, animated: true, completion: nil)

        }}
     
    @IBAction func clearData(_ sender: Any)
    {
        UserDefaults.standard.removeObject(forKey: "Lock")
    }
    
    @objc func submit(){

    scroll.isHidden = false
    
    var x = 10
    for i in 0..<www.count{
        scroll.contentSize = CGSize(width: www.count*110, height: 60)

        let FNFile = www[i]
        let FNBtn = FNFile["data1"] as! String

        let btn = UIButton()
        btn.frame = CGRect(x: x, y: 5, width: 80, height: 35)
        btn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn.setTitle(FNBtn, for: UIControl.State.normal)
        btn.tag = i
        btn.addTarget(self, action: #selector(info(click:)), for: UIControl.Event.touchUpInside)
        scroll.addSubview(btn)
        
        x += 100

    }

    if(label1.text != nil){
        FNLabel.text  = ""
        LNLabel.text = ""
        DOBLabel0.text = ""
        mobileNoLabel0.text = ""
        emailLabel0.text = ""
        label1.text = ""
        label2.text = ""
        label3.text = ""
        label4.text = ""
        label5.text = ""

    }}
    
    //shows all info Of file
    @objc  func info(click:UIButton)
        
    {
        let list = www[click.tag]
        print(list)
        FNLabel.text  = "FirstName :"
        LNLabel.text = "Lastname :"
        DOBLabel0.text = "DOB :"
        mobileNoLabel0.text = "MobileNo :"
        emailLabel0.text = "Email :"
        label1.text = "\(list["data1"]!)"
        label2.text = "\(list["data2"]!)"
        label3.text = "\(list["data3"]!)"
        label4.text = "\(list["data4"]!)"
        label5.text = "\(list["data5"]!)"
    }
    
}
extension UITextField
{
    func textFieldSetUp(_ image: UIImage)
    {
        let iconview = UIImageView(frame: CGRect(x: 10, y: 5, width: 20, height: 20))
        iconview.image = image
        let iconContainerView:UIView = UIView(frame:CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconview)
        leftView = iconContainerView
        leftViewMode = .always
    }
}
