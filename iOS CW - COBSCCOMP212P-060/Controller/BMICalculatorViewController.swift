//
//  BMICalculatorViewController.swift
//  iOS CW - COBSCCOMP212P-060
//
//  Created by Isini Bandara on 2023-05-18.
//

import UIKit
import PassKit

class BMICalculatorViewController: UIViewController, PKPaymentAuthorizationViewControllerDelegate {
    private let weightTextField = UITextField()
    private let heightTextField = UITextField()
    private let calculateButton = CustomButton(title: "Calculate", hasBackground: true, fontSize: .big)
    private let resultLabel = UILabel()
    private let fitnessPlanLabel = UILabel()
    private let headingTextView = CustomTextView(title: "What is your BMI?", fontSize: .big)
    private let subheadingTextView = CustomTextView(title: "This helps us create your personalized plan", fontSize: .small)
    private let seePlan = CustomButton(title: "Subscription (9.99 yr)", hasBackground: true, fontSize: .big)
    private let activationLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        seePlan.addTarget(self, action: #selector(didTapSeePlan), for: .touchUpInside)
        configureUI()
        addConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }

    @objc func didTapSeePlan(){
        presentApplePayViewController()
    }
    private func configureUI() {
        view.backgroundColor = UIColor(named: "Black")

        fitnessPlanLabel.textAlignment = .left
        fitnessPlanLabel.numberOfLines = 0
        
        headingTextView.translatesAutoresizingMaskIntoConstraints = false
           subheadingTextView.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(headingTextView)
          view.addSubview(subheadingTextView)
        
//        weightTextField.placeholder = "Weight (kg)"
        let placeholderText = "Weight (kg)"

        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(named: "White")!,
            .font: UIFont.systemFont(ofSize: 14)
        ]

        weightTextField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        weightTextField.borderStyle = .roundedRect
        weightTextField.keyboardType = .decimalPad
        weightTextField.textColor = UIColor(named: "Green")
        weightTextField.backgroundColor = UIColor(named: "LightBlack")

        let heightPlaceholderText = "Height (cm)"

        let heightAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(named: "White")!,
            .font: UIFont.systemFont(ofSize: 14)
        ]

        heightTextField.attributedPlaceholder = NSAttributedString(string: heightPlaceholderText, attributes: heightAttributes)
        heightTextField.borderStyle = .roundedRect
        heightTextField.keyboardType = .decimalPad
        heightTextField.textColor = UIColor(named: "Green")
        heightTextField.backgroundColor = UIColor(named: "LightBlack")
        
//        calculateButton.setTitle("Calculate", for: .normal)
        calculateButton.addTarget(self, action: #selector(calculateButtonTapped), for: .touchUpInside)

        resultLabel.textAlignment = .center
        fitnessPlanLabel.textAlignment = .center

        [weightTextField, heightTextField, calculateButton, resultLabel, fitnessPlanLabel, seePlan].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        // Add activation label
        activationLabel.textColor = .white
        activationLabel.textAlignment = .center
        activationLabel.numberOfLines = 0
        activationLabel.textColor = .systemGray
//        activationLabel.
//        activationLabel.text = "To access the suggested fitness plan based on your BMI, Subscribe!"
        view.addSubview(activationLabel)
        
        let attributedText = NSMutableAttributedString(string: "To access the suggested fitness plan based on your BMI, ")
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineText = NSAttributedString(string: "Subscribe!", attributes: underlineAttribute)
        attributedText.append(underlineText)

        activationLabel.attributedText = attributedText

    }

    private func addConstraints() {
        
        activationLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            self.headingTextView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.headingTextView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.headingTextView.heightAnchor.constraint(equalToConstant: 50),
            self.headingTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            
            self.subheadingTextView.topAnchor.constraint(equalTo: self.headingTextView.bottomAnchor, constant: 10),
            self.subheadingTextView.centerXAnchor.constraint(equalTo: self.headingTextView.centerXAnchor),
            self.subheadingTextView.heightAnchor.constraint(equalToConstant: 100),
            self.subheadingTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            weightTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weightTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            weightTextField.widthAnchor.constraint(equalToConstant: 200),
            
            heightTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heightTextField.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 20),
            heightTextField.widthAnchor.constraint(equalToConstant: 200),
            
            calculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calculateButton.topAnchor.constraint(equalTo: heightTextField.bottomAnchor, constant: 40),
            calculateButton.heightAnchor.constraint(equalToConstant: 55),
            calculateButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.50),
            
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.topAnchor.constraint(equalTo: calculateButton.bottomAnchor, constant: 40),
            
            fitnessPlanLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fitnessPlanLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            fitnessPlanLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            fitnessPlanLabel.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 20),
            fitnessPlanLabel.heightAnchor.constraint(equalTo: fitnessPlanLabel.heightAnchor),
            
            
            activationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activationLabel.topAnchor.constraint(equalTo: seePlan.bottomAnchor, constant: 20),
            activationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            activationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            self.seePlan.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.seePlan.topAnchor.constraint(equalTo: fitnessPlanLabel.bottomAnchor, constant: 20),
            self.seePlan.heightAnchor.constraint(equalToConstant: 55),
            self.seePlan.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),


        ])
        seePlan.isHidden = true
        activationLabel.isHidden = true

    }

    @objc private func calculateButtonTapped() {
        guard let weightText = weightTextField.text, let weight = Double(weightText),
              let heightText = heightTextField.text, let height = Double(heightText) else {
            resultLabel.text = "Invalid input"
            return
        }

        let heightInMeter = height / 100.0
        let bmi = weight / (heightInMeter * heightInMeter)
        resultLabel.text = "BMI: \(String(format: "%.2f", bmi))"
        resultLabel.textColor = UIColor(named: "Green")

        let fitnessPlan = suggestFitnessPlan(bmi: bmi)
        fitnessPlanLabel.text = fitnessPlan
        fitnessPlanLabel.textColor = .white
        fitnessPlanLabel.textAlignment = .center
        
        seePlan.isHidden = false // Show the button after calculation
        activationLabel.isHidden = false

        
    }

    private func suggestFitnessPlan(bmi: Double) -> String {
        switch bmi {
        case ..<18.5:
            return "Underweight: Consider gaining some weight through a balanced diet and strength training.  "
        case 18.5..<25.0:
            return "Normal weight: Maintain a healthy lifestyle with regular exercise and a balanced diet."
        case 25.0..<30.0:
            return "Overweight: Focus on weight loss through portion control, regular exercise, and a balanced diet."
        default:
            return "Obese: Consult a healthcare professional for a personalized fitness and nutrition plan."
        }
    }
    
    func presentApplePayViewController() {
        // Create and configure the payment request
        let request = PKPaymentRequest()
        request.merchantIdentifier = "yourMerchantIdentifier"
        request.supportedNetworks = [.visa, .masterCard, .amex]
        request.merchantCapabilities = .capability3DS
        request.countryCode = "US"
        request.currencyCode = "USD"
        
        let item = PKPaymentSummaryItem(label: "GymGenie Fitness Suscription", amount: NSDecimalNumber(decimal: 9.99))
        request.paymentSummaryItems = [item]
        
        // Create the payment authorization view controller
        let paymentController = PKPaymentAuthorizationViewController(paymentRequest: request)
        paymentController!.delegate = self
        
        // Present the payment authorization view controller
        if let paymentVC = paymentController {
            present(paymentVC, animated: true, completion: nil)
        }
    }
    
    // Implement the delegate method to handle payment authorization completion
    private func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        // Process the payment and handle the completion result
        // Call completion with the appropriate result based on payment success or failure
    }
    
    // Implement the delegate method to handle payment authorization dismissal
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        dismiss(animated: true, completion: nil)
    }
}
