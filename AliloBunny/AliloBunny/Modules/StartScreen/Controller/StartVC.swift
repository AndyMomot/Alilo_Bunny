//
//  StartVC.swift
//  AliloBunny
//
//  Created by Андрей on 9.9.22.
//

import UIKit

enum NumberOfColors {
    case three
    case four
    case six
    case nine
}

class StartVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var selectedNumberView: UIView!
    @IBOutlet weak var selectedNumberLabel: UILabel!
    private var numberOfColors: NumberOfColors = .six
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewDidLayoutSubviews() {
        configureUI()
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
        moveToNextVC()
    }
}

extension StartVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = Constants.dataForTheCell[indexPath.row]
        let cell = tableView.dequeueReusableCell(cellType: StartScreenCell.self, indexPath: indexPath)
        cell.setCell(number: data)
        cell.selectCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? StartScreenCell {
            cell.selectCell()
            
            let selectedData = Constants.dataForTheCell[indexPath.row]
            self.selectedNumberLabel.text = String(selectedData)
            
            switch selectedData {
            case 3:
                numberOfColors = .three
            case 4:
                numberOfColors = .four
            case 6:
                numberOfColors = .six
            case 9:
                numberOfColors = .nine
            default:
                break
            }
            
            UIView.animate(withDuration: 0.5) {
                self.selectedNumberView.backgroundColor = .systemBlue
                self.selectedNumberView.backgroundColor = .white
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? StartScreenCell {
            cell.selectCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

// MARK: - Private extension
private extension StartVC {
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(StartScreenCell.self)
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
    }
    
    func configureUI() {
        configureSelectedNumberView()
        configureNextButton()
    }
    
    func configureSelectedNumberView() {
        selectedNumberView.layer.cornerRadius = selectedNumberView.frame.height / 2
        selectedNumberView.layer.shadowColor = UIColor.black.cgColor
        selectedNumberView.layer.shadowOffset = CGSize(width: 0, height: 0)
        selectedNumberView.layer.shadowRadius = 20
        selectedNumberView.layer.shadowOpacity = 0.4
    }
    
    func configureNextButton() {
        nextButton.layer.cornerRadius = nextButton.frame.height * 0.3
        nextButton.layer.shadowColor = UIColor.black.cgColor
        nextButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        nextButton.layer.shadowRadius = 5
        nextButton.layer.shadowOpacity = 0.5
    }
    
    func moveToNextVC() {
        if selectedNumberLabel.text == "0" {
            let alertController = UIAlertController(title: "The number of colours must be greater than zero", message: nil, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alertController, animated: true)
        } else {
            let homeVC = UIStoryboard(name: .main).viewController(type: HomeVC.self)
            homeVC.modalPresentationStyle = .fullScreen
            homeVC.numberOfColors = self.numberOfColors
            self.present(homeVC, animated: true, completion: nil)
        }
    }
}

private struct Constants {
    static var numberOfRowsInSection = dataForTheCell.count
    static var dataForTheCell = [3, 4, 6, 9]
}
