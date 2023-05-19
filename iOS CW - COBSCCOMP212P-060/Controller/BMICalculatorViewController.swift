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
    private let calculateButton = UIButton(type: .system)
    private let resultLabel = UILabel()
    private let fitnessPlanLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        addConstraints()
    }

    private func configureUI() {
        view.backgroundColor = UIColor(named: "Black")
    

//        weightTextField.placeholder = "Weight (kg)"
        let placeholderText = "Weight (kg)"

        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(named: "White")!, // Replace "Green" with your desired color
            .font: UIFont.systemFont(ofSize: 14) // Adjust the font size as needed
        ]

        weightTextField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        weightTextField.borderStyle = .roundedRect
        weightTextField.keyboardType = .decimalPad
        weightTextField.backgroundColor = UIColor(named: "LightBlack")

        heightTextField.placeholder = "Height (cm)"
        heightTextField.borderStyle = .roundedRect
        heightTextField.keyboardType = .decimalPad

        calculateButton.setTitle("Calculate", for: .normal)
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
            weightTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weightTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            weightTextField.widthAnchor.constraint(equalToConstant: 200),
            
            heightTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heightTextField.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 20),
            heightTextField.widthAnchor.constraint(equalToConstant: 200),
            
            calculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calculateButton.topAnchor.constraint(equalTo: heightTextField.bottomAnchor, constant: 40),
            
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

        let fitnessPlan = suggestFitnessPlan(bmi: bmi)
        fitnessPlanLabel.text = fitnessPlan
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
