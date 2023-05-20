//
//  BMICalculatorViewController.swift
//  iOS CW - COBSCCOMP212P-060
//
//  Created by Isini Bandara on 2023-05-18.
//

import UIKit

class BMICalculatorViewController: UIViewController {
    private let weightTextField = UITextField()
    private let heightTextField = UITextField()
    private let calculateButton = CustomButton(title: "Calculate", hasBackground: true, fontSize: .big)
    private let resultLabel = UILabel()
    private let fitnessPlanLabel = UILabel()
    private let headingTextView = CustomTextView(title: "What is your BMI?", fontSize: .big)
    private let subheadingTextView = CustomTextView(title: "This helps us create your personalized plan", fontSize: .small)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        addConstraints()
    }

    private func configureUI() {
        view.backgroundColor = UIColor(named: "Black")

        
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

        [weightTextField, heightTextField, calculateButton, resultLabel, fitnessPlanLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }

    private func addConstraints() {
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
            fitnessPlanLabel.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 20)
        ])
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
        

        
    }

    private func suggestFitnessPlan(bmi: Double) -> String {
        switch bmi {
        case ..<18.5:
            return "Underweight: Consider gaining some weight through a balanced diet and strength training."
        case 18.5..<25.0:
            return "Normal weight: Maintain a healthy lifestyle with regular exercise and a balanced diet."
        case 25.0..<30.0:
            return "Overweight: Focus on weight loss through portion control, regular exercise, and a balanced diet."
        default:
            return "Obese: Consult a healthcare professional for a personalized fitness and nutrition plan."
        }
    }
}
