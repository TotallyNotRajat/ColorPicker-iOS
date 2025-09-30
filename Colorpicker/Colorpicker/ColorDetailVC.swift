//
//  ColorDetailVC.swift
//  Colorpicker
//
//  Created by Rajat Tiwari on 26/09/25.
//

import UIKit

class ColorDetailVC: UIViewController {
    
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var hexCodeLabel: UILabel!
    
    var selectedColor: Color?
    
    private var buttonBlurView: UIVisualEffectView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    private func setupUI() {
        // Configure copy button (glassmorphism)
        copyButton.setTitle("Copy", for: .normal)
        copyButton.setTitleColor(.white, for: .normal)
        copyButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        copyButton.backgroundColor = UIColor.white.withAlphaComponent(0.08)
        copyButton.layer.cornerRadius = 14
        copyButton.layer.masksToBounds = false
        copyButton.layer.borderWidth = 1
        copyButton.layer.borderColor = UIColor.white.withAlphaComponent(0.25).cgColor
        copyButton.layer.shadowColor = UIColor.black.cgColor
        copyButton.layer.shadowOpacity = 0.25
        copyButton.layer.shadowRadius = 12
        copyButton.layer.shadowOffset = CGSize(width: 0, height: 6)
        
        // Add blur background inside the button
        let blurEffect: UIBlurEffect
        if #available(iOS 13.0, *) {
            blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
        } else {
            blurEffect = UIBlurEffect(style: .light)
        }
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.isUserInteractionEnabled = false
        blurView.layer.cornerRadius = copyButton.layer.cornerRadius
        blurView.layer.masksToBounds = true
        copyButton.insertSubview(blurView, at: 0)
        buttonBlurView = blurView
        
        // Configure hex code label
        hexCodeLabel.textColor = .white
        hexCodeLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        hexCodeLabel.textAlignment = .center
        hexCodeLabel.layer.backgroundColor = UIColor.black.withAlphaComponent(0.3).cgColor
        hexCodeLabel.layer.cornerRadius = 8
        hexCodeLabel.layer.masksToBounds = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Keep blur view sized to the button
        if let blurView = buttonBlurView {
            blurView.frame = copyButton.bounds
            blurView.layer.cornerRadius = copyButton.layer.cornerRadius
        }
    }
    
    private func updateUI() {
        guard let color = selectedColor else { return }
        
        // Set background color
        view.backgroundColor = color.color
        
        // Update hex code label
        hexCodeLabel.text = color.hexCode
        
        // Update navigation title
        title = color.name
    }
    
    @IBAction func copyButtonTapped(_ sender: UIButton) {
        guard let hexCode = selectedColor?.hexCode else { return }
        
        UIPasteboard.general.string = hexCode
        
        // Show feedback to user
        let alert = UIAlertController(
            title: "Copied!",
            message: "Hex code \(hexCode) has been copied to clipboard",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
