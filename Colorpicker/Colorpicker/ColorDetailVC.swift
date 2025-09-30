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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    private func setupUI() {
        // Configure copy button
        copyButton.setTitle("Copy", for: .normal)
        copyButton.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        copyButton.setTitleColor(.white, for: .normal)
        copyButton.layer.cornerRadius = 8
        copyButton.layer.borderWidth = 1
        copyButton.layer.borderColor = UIColor.white.cgColor
        
        // Configure hex code label
        hexCodeLabel.textColor = .white
        hexCodeLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        hexCodeLabel.textAlignment = .center
        hexCodeLabel.layer.backgroundColor = UIColor.black.withAlphaComponent(0.3).cgColor
        hexCodeLabel.layer.cornerRadius = 8
        hexCodeLabel.layer.masksToBounds = true
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
