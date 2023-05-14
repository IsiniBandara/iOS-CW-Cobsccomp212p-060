//
//  OnBoardingViewController.swift
//  iOS CW - COBSCCOMP212P-060
//
//  Created by Isini Bandara on 2023-05-14.
//

import UIKit

class OnboardingViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    private var pageViewController: UIPageViewController!
    private var pageControl: UIPageControl!
    
    private let onboardingViewControllers: [UIViewController] = {
        let firstVC = OnBoardFirstViewController()
        let secondVC = OnBoardSecondViewController()
        let thirdVC = OnBoardThirdViewController()


        return [firstVC, secondVC, thirdVC]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageViewController()
        configurePageControl()
    }
    
    private func configurePageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        pageViewController.setViewControllers([onboardingViewControllers.first!], direction: .forward, animated: true, completion: nil)
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        // Set the constraints for the page view controller's view
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configurePageControl() {
        pageControl = UIPageControl()
        pageControl.numberOfPages = onboardingViewControllers.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor(named: "White")
        pageControl.currentPageIndicatorTintColor = UIColor(named: "Green")
        
        view.addSubview(pageControl)
        
        // Set the constraints for the page control
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20.0)
        ])
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = onboardingViewControllers.firstIndex(of: viewController), currentIndex > 0 else {
            return nil
        }
        return onboardingViewControllers[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = onboardingViewControllers.firstIndex(of: viewController), currentIndex < onboardingViewControllers.count - 1 else {
            return nil
        }
        return onboardingViewControllers[currentIndex + 1]
    }
    
    // MARK: - UIPageViewControllerDelegate
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let currentViewController = pageViewController.viewControllers?.first {
            if let currentIndex = onboardingViewControllers.firstIndex(of: currentViewController) {
                pageControl.currentPage = currentIndex
            }
        }
    }
}


class OnBoardFirstViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a UIImageView for the background image
        let backgroundImageView = UIImageView(image: UIImage(named: "splash_img1"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)
        
        // Set constraints to cover the entire screen
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
        ])
        
        // Ensure the background image is behind other views
        view.sendSubviewToBack(backgroundImageView)
    }
}

class OnBoardSecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a UIImageView for the background image
        let backgroundImageView = UIImageView(image: UIImage(named: "splash_img2"))
        backgroundImageView.contentMode = .scaleToFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)
        
        // Set constraints to cover the entire screen
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
        ])
        
        // Ensure the background image is behind other views
        view.sendSubviewToBack(backgroundImageView)
    }
}

class OnBoardThirdViewController: UIViewController {
    private let startButton = CustomButton(title: "Start Now >", hasBackground: true, fontSize: .big)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startButton.addTarget(self, action: #selector(didTapStart), for: .touchUpInside)
        
        // Create a UIImageView for the background image
        let backgroundImageView = UIImageView(image: UIImage(named: "splash_img3"))
        backgroundImageView.contentMode = .scaleToFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)
        view.addSubview(startButton)
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Set constraints to cover the entire screen
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            
            self.startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80.0),
            self.startButton.heightAnchor.constraint(equalToConstant: 55),
            self.startButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.50),
        ])
        
        // Ensure the background image is behind other views
        view.sendSubviewToBack(backgroundImageView)
    }
    
    @objc private func didTapStart() {
        let vc = LoginController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
