//
//  SelectGenderViewController.swift
//  iOS CW - COBSCCOMP212P-060
//
//  Created by Isini Bandara on 2023-05-17.
//

import UIKit

class SelectGenderViewController: UIViewController {
    private let buttonTitles = ["Male", "Female"]
       private var gender = ""
       private var buttons: [GenderSelectionButton] = []
       private let nextButton = CustomButton(title: "Next", hasBackground: true, fontSize: .big)
       private let headingTextView = CustomTextView(title: "Tell us about yourself!", fontSize: .big)
       private let subheadingTextView = CustomTextView(title: "To give you a better experience we need to know your gender", fontSize: .small)
       
       override func viewDidLoad() {
           super.viewDidLoad()
           self.setupUI()
           self.nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
       }
       
       func setupUI() {
           view.backgroundColor = UIColor(named: "Black")
           for title in buttonTitles {
               let button = GenderSelectionButton(title: title)
               button.addTarget(self, action: #selector(didTapSelect(_:)), for: .touchUpInside)
               view.addSubview(button)
               button.translatesAutoresizingMaskIntoConstraints = false
               buttons.append(button)
           }
           // Set up constraints
           for (index, button) in buttons.enumerated() {
               // Constraints to position the buttons vertically
               button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
               if index == 0 {
                   button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80).isActive = true
               } else {
                   button.topAnchor.constraint(equalTo: buttons[index - 1].bottomAnchor, constant: 20).isActive = true
               }
               
               // Constraints for button width and height
               button.widthAnchor.constraint(equalToConstant: 150).isActive = true
               button.heightAnchor.constraint(equalToConstant: 150).isActive = true
           }
           
           headingTextView.translatesAutoresizingMaskIntoConstraints = false
           subheadingTextView.translatesAutoresizingMaskIntoConstraints = false
           nextButton.translatesAutoresizingMaskIntoConstraints = false

           view.addSubview(headingTextView)
           view.addSubview(subheadingTextView)
           view.addSubview(nextButton)

           
           // Position the buttons using constraints
           NSLayoutConstraint.activate([
               self.headingTextView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
               self.headingTextView.centerXAnchor.constraint(equalTo: self.view.layoutMarginsGuide.centerXAnchor),
               self.headingTextView.heightAnchor.constraint(equalTo: headingTextView.heightAnchor),
               self.headingTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
               
               self.subheadingTextView.topAnchor.constraint(equalTo: self.headingTextView.bottomAnchor, constant: 10),
               self.subheadingTextView.centerXAnchor.constraint(equalTo: headingTextView.centerXAnchor),
               self.subheadingTextView.heightAnchor.constraint(equalToConstant: 100),
               self.subheadingTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
               
               self.nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               self.nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80.0),
               self.nextButton.heightAnchor.constraint(equalToConstant: 55),
               self.nextButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.50),

           ])

       }
       
       @objc func didTapSelect(_ sender: GenderSelectionButton) {
           if let index = buttons.firstIndex(of: sender) {
              print("Button tapped at index: \(buttonTitles[index])")
               gender = buttonTitles[index]
           }
       }
   
       @objc func didTapNext() {
           print("\(gender)")

       }

}
