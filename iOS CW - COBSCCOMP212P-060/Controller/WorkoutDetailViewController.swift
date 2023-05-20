//
//  WorkoutDetailViewController.swift
//  iOS CW - COBSCCOMP212P-060
//
//  Created by Isini Bandara on 2023-05-20.
//

import UIKit

class WorkoutDetailViewController: UIViewController {
    var selectedItemTitle: String?
        
        private let back = CustomButton(title: "◀ Back", hasBackground: true, fontSize: .small)
        
        private let backButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Back", for: .normal)
            return button
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = UIColor(named: "Black")
    //        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped))
    //        back.addGestureRecognizer(tapGesture)
            back.addTarget(self , action: #selector(backButtonTapped), for: .touchUpInside)
            setupUI()
            // Do any additional setup after loading the view.
    //        if let data = title {
            print("Modal Data: \(String(describing: selectedItemTitle))")
            
    //        }
        }
        
        func setupUI(){
    //        back.frame = CGRect(x: 16, y: 250, width: 60, height: 30)
    //        backButton.tintColor = .systemBlue
    //        view.addSubview(back)
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.navigationBar.isUserInteractionEnabled = false
    //        self.navigationController?.navigationBar.isHidden = false
    //        self.navigationController?.navigationBar.tintColor = UIColor.white
        }
        
        @objc func backButtonTapped() {
            // Handle back button tap event
            navigationController?.popViewController(animated: true)
        }
}
