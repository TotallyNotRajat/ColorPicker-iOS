//
//  ColorTableVC.swift
//  Colorpicker
//
//  Created by Rajat Tiwari on 26/09/25.
//

import UIKit

// Color model to store color data
struct Color {
    let name: String
    let color: UIColor
    let hexCode: String
    
    init(name: String, color: UIColor) {
        self.name = name
        self.color = color
        self.hexCode = color.toHex()
    }
}

// Extension to convert UIColor to hex string
extension UIColor {
    func toHex() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb: Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return String(format: "#%06x", rgb)
    }
}

class ColorTableVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var colors: [Color] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateRandomColors()
    }
    
    
    private func generateRandomColors() {
        colors = []
        for _ in 1...50 {
            let randomColor = UIColor(
                red: CGFloat.random(in: 0...1),
                green: CGFloat.random(in: 0...1),
                blue: CGFloat.random(in: 0...1),
                alpha: 1.0
            )
            let color = Color(name: "Color", color: randomColor)
            colors.append(color)
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToColorDetailVC" {
            if let destinationVC = segue.destination as? ColorDetailVC,
               let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedColor = colors[indexPath.row]
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension ColorTableVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ColorCell", for: indexPath)
        let color = colors[indexPath.row]
        
        cell.textLabel?.text = color.name
        cell.textLabel?.textColor = .white
        cell.backgroundColor = color.color
        cell.selectionStyle = .default
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ColorTableVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
