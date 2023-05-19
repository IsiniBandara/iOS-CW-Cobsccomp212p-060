//
//  SelectWeightViewController.swift
//  iOS CW - COBSCCOMP212P-060
//
//  Created by Isini Bandara on 2023-05-18.
//

import UIKit

class SelectWeightViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    private var pickerView: UIPickerView!
    private let nextButton = CustomButton(title: "Next", hasBackground: true, fontSize: .big)
    private let headingTextView = CustomTextView(title: "What’s your weight?", fontSize: .big)
    private let subheadingTextView = CustomTextView(title: "You can always change this later", fontSize: .small)
    private var options: [String] = ["28 kg", "29 kg", "30 kg","31 kg", "32 kg", "33 kg","34 kg", "35 kg", "36 kg","37 kg", "38 kg", "39 kg","40 kg", "41 kg", "42 kg","43 kg", "44 kg", "45 kg","46 kg", "47 kg", "48 kg", "49 kg", "50 kg", "51 kg", "52 kg", "53 kg", "54 kg","55 kg", "56 kg", "57 kg", "58 kg", "59 cm", "60 kg", "61 kg", "62 kg", "63 kg", "64 kg", "65 kg", "66 kg", "67 kg", "68 kg", "69 kg", "70 kg", "71 kg", "72 kg", "73 kg", "74 kg", "75 kg", "76 kg", "77 kg", "78 kg", "79 kg", "80 kg", "81 kg", "82 kg", "83 kg", "84 kg", "85 kg", "86 kg", "87 kg", "88 kg", "89 kg", "90 kg", "91 kg", "92 kg", "93 kg", "94 kg", "95 kg", "96 kg", "97 kg", "98 kg", "99 kg", "100 kg", "101kg", "102 kg", "103 kg", "104 kg", "105 kg", "106 kg", "107 kg", "108 kg", "109 kg", "110 kg", "111kg", "112 kg", "113 kg", "114 kg", "115 kg", "116 kg", "117 kg", "118 kg", "119 kg", "120 kg",  "121kg", "122 kg", "123 kg", "124 kg", "125 kg", "126 kg", "127 kg", "128 kg", "129 kg", "130 kg" ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Black")
        setupUI()
        self.nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
    }

func setupUI(){
    pickerView = UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 400))
    pickerView.dataSource = self
    pickerView.delegate = self
    
    headingTextView.translatesAutoresizingMaskIntoConstraints = false
    subheadingTextView.translatesAutoresizingMaskIntoConstraints = false
    nextButton.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(headingTextView)
    view.addSubview(subheadingTextView)
    view.addSubview(nextButton)
    view.addSubview(pickerView)
    
    NSLayoutConstraint.activate([
        self.headingTextView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
        self.headingTextView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        self.headingTextView.heightAnchor.constraint(equalToConstant: 50),
        self.headingTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
        
        self.subheadingTextView.topAnchor.constraint(equalTo: self.headingTextView.bottomAnchor, constant: 10),
        self.subheadingTextView.centerXAnchor.constraint(equalTo: self.headingTextView.centerXAnchor),
        self.subheadingTextView.heightAnchor.constraint(equalToConstant: 100),
        self.subheadingTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),


        self.nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        self.nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80.0),
        self.nextButton.heightAnchor.constraint(equalToConstant: 55),
        self.nextButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.50),
    ])

}

@objc func didTapNext() {

}

    // MARK: - UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // Number of columns in the picker view
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count // Number of rows in the picker view
    }

    // MARK: - UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row] // Title for each row in the picker view
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedOption = options[row] // Handle the selected option
        print("Selected option: \(selectedOption)")
    }

//        func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//            let title = options[row]
//            let attributes: [NSAttributedString.Key: Any] = [
//                .foregroundColor: UIColor.white, // Customize the text color here
//                .font: UIFont.systemFont(ofSize: 30, weight: .bold)
//            ]
//
//            return NSAttributedString(string: title, attributes: attributes)
//        }
func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    let label = UILabel()
    label.textAlignment = .center
    label.textColor = UIColor(named: "Green")
    label.font = UIFont.systemFont(ofSize: 30) // Adjust the font size as desired
    let selectedOption = options[row]
    label.text = selectedOption// Provide the text for the row
    
    return label
}

}

