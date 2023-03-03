import UIKit
import AVFoundation

class HomeVC: UIViewController {
    
    // MARK: - IBOutlet
    // Bunny View
    @IBOutlet private weak var bunnyBodyView: BunnyBodyView!
    @IBOutlet private weak var leftEarView: HareEarView!
    @IBOutlet private weak var rightEarView: HareEarView!
    // main stack
    @IBOutlet private weak var mainStackView: UIStackView!
    var numberOfColors: NumberOfColors = .six
    
    // mainStack x/y
    private lazy var mainStackMinX =  mainStackView.frame.minX
    private lazy var mainStackMinY =  mainStackView.frame.minY
    private lazy var mainStackMaxX =  mainStackView.frame.maxX
    private lazy var mainStackMaxY =  mainStackView.frame.maxY
    
    // Colour cards 1-3
    private let redCardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 193, green: 73, blue: 62, opacity: 1)
        return view
    }()
    
    private let greenCardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 108, green: 199, blue: 113, opacity: 1)
        return view
    }()
    
    private let tealCardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 89, green: 166, blue: 176, opacity: 1)
        return view
    }()
    
    // Colour cards 4-6
    private let blueCardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 96, green: 113, blue: 186, opacity: 1)
        return view
    }()
    
    private let purpleCardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 159, green: 115, blue: 185, opacity: 1)
        return view
    }()
    
    private let brownCardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 159, green: 136, blue: 109, opacity: 1)
        return view
    }()
    
    // Colour cards 7-9
    private let orangeCardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 255, green: 176, blue: 98, opacity: 1)
        return view
    }()
    
    private let yellowCardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 255, green: 217, blue: 59, opacity: 1)
        return view
    }()
    
    private let PincCardView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 236, green: 67, blue: 102, opacity: 1)
        return view
    }()
    
    private var topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .red
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var midleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .blue
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    private var bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .blue
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // MARK: - Property
    private var bunnyViewOrigin: CGPoint!
    private var playerManager = AudioManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNumberOfColours()
        beginningState()
        createCards()
    }
    
    // MARK: - IBAction
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        playerManager.pause()
        dismiss(animated: true, completion: nil)

    }
    
    @IBAction private func changeModePressed(_ sender: UIButton) {
        changeMode()
    }
    
    @IBAction private func changeMelodyPressed(_ sender: UIButton) {
        playerManager.playNextAudio()
    }
}

// MARK: extension HomeVC
private extension HomeVC {
    func setNumberOfColours() {
        switch numberOfColors {
        case .three:
            print(3)
        case .four:
            print(4)
        case .six:
            print(6)
        case .nine:
            print(9)
        }
    }
    
    func beginningState() {
        addPanGesture(view: bunnyBodyView)
        bunnyViewOrigin = bunnyBodyView.frame.origin
        playerManager.play(.sounds)
        animateEars()
    }
    
    func changeMode() {
        switch playerManager.checkSoundMode() {
        case .sounds:
            playerManager.changeSoundMode()
            animateEarsForSongsMode()
        case .songs:
            playerManager.changeSoundMode()
            animateEarsForSongsMode()
        case .englishSongs:
            playerManager.changeSoundMode()
            animateEars()
        }
    }
    
    // MARK: Animate Ear Fill Color
    func changeEarFillColorTo(_ color: EarColors) {
        leftEarView.changeFillColor(color: color)
        rightEarView.changeFillColor(color: color)
    }
    
    func changeEarFillColorAutomatically() {
        leftEarView.earAnimatingForSongsMode()
        rightEarView.earAnimatingForSongsMode()
    }
    
    func animateEars() {
        switch playerManager.checkSoundMode() {
        case .sounds:
            changeEarFillColorTo(determineTheBackgroundColour())
        case .songs:
            break
        case .englishSongs:
            break
        }
    }
    
    func animateEarsForSongsMode() {
        if playerManager.checkSoundMode() == .songs {
            changeEarFillColorAutomatically()
        }
    }
    
    // MARK: Restriction of movement
    func setLimits() {
        let bunnyView = bunnyBodyView!
        // mainStack x/y
        let mainStackMinX =  mainStackView.frame.minX
        let mainStackMinY =  mainStackView.frame.minY
        let mainStackMaxX =  mainStackView.frame.maxX
        let mainStackMaxY =  mainStackView.frame.maxY
        // bunny x/y
        let bunnyMinX =  bunnyBodyView.frame.minX
        let bunnyMinY =  bunnyBodyView.frame.minY
        let bunnyMaxX =  bunnyBodyView.frame.maxX
        let bunnyMaxY =  bunnyBodyView.frame.maxY
        // Restriction from above
        if bunnyMinY <= mainStackMinY {
            bunnyView.center.y = bunnyView.center.y + (mainStackMinY - bunnyMinY)
        }
        // Restriction on the left
        if bunnyMinX <= mainStackMinX {
            bunnyView.center.x = bunnyView.center.x + (mainStackMinX - bunnyMinX)
        }
        // Restriction to the right
        if bunnyMaxX >= mainStackMaxX {
            bunnyView.center.x = mainStackMaxX - (bunnyView.frame.width / 2)
        }
        // Restriction on the bottom
        if bunnyMaxY >= mainStackMaxY {
            bunnyView.center.y = mainStackMaxY - (bunnyView.frame.height / 2)
        }
    }
    
    private func addPanGesture(view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(pan)
    }
    
    @objc private func handlePan(sender: UIPanGestureRecognizer) {
        let bunnyView = sender.view!
        let translation = sender.translation(in: view)
        // Move bunny
        func moveView() {
            bunnyView.center = CGPoint(
                x: bunnyView.center.x + translation.x,
                y: bunnyView.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: self.view)
        }
        
        // MARK: Main work
        switch sender.state {
        case .began, .changed:
            setLimits()
            moveView()
            animateEars()
        case .ended:
            setLimits()
            animateEarsForSongsMode()
        default:
            break
        }
    }
}

// MARK: Discern Background Colour -
private extension HomeVC {
    
    func createCards() {
        switch numberOfColors {
        case .three:
            mainStackView.addArrangedSubview(topStackView)
                topStackView.addArrangedSubview(redCardView)
                topStackView.addArrangedSubview(greenCardView)
                topStackView.addArrangedSubview(tealCardView)
        case .four:
            mainStackView.addArrangedSubview(topStackView)
                topStackView.addArrangedSubview(redCardView)
                topStackView.addArrangedSubview(greenCardView)
            
            mainStackView.addArrangedSubview(midleStackView)
                midleStackView.addArrangedSubview(blueCardView)
                midleStackView.addArrangedSubview(purpleCardView)
        case .six:
            mainStackView.addArrangedSubview(topStackView)
                topStackView.addArrangedSubview(redCardView)
                topStackView.addArrangedSubview(greenCardView)
                topStackView.addArrangedSubview(tealCardView)
            
            mainStackView.addArrangedSubview(midleStackView)
                midleStackView.addArrangedSubview(blueCardView)
                midleStackView.addArrangedSubview(purpleCardView)
                midleStackView.addArrangedSubview(brownCardView)
        case .nine:
            mainStackView.addArrangedSubview(topStackView)
                topStackView.addArrangedSubview(redCardView)
                topStackView.addArrangedSubview(greenCardView)
                topStackView.addArrangedSubview(tealCardView)
            
            mainStackView.addArrangedSubview(midleStackView)
                midleStackView.addArrangedSubview(blueCardView)
                midleStackView.addArrangedSubview(purpleCardView)
                midleStackView.addArrangedSubview(brownCardView)
            
            mainStackView.addArrangedSubview(bottomStackView)
                bottomStackView.addArrangedSubview(orangeCardView)
                bottomStackView.addArrangedSubview(yellowCardView)
                bottomStackView.addArrangedSubview(PincCardView)
        }
        
    }
    
    // MARK: Discern Background Colour
    func determineTheBackgroundColour() -> EarColors {
        
        switch numberOfColors {
        case .three:
            return colourRecognitionForThreeCards()
        case .four:
            return colourRecognitionForFourCards()
        case .six:
            return colourRecognitionForSixCards()
        case .nine:
            return colourRecognitionForNineCards()
        }
    }
    
    
    // MARK: - Colour recognition
    // for three cards
    func colourRecognitionForThreeCards() -> EarColors {
        let bunnyBodyViewCenterY = bunnyBodyView.center.y - bunnyBodyView.frame.height / Constants.two
        let leftLine = mainStackMaxX * Constants.oneThird
        let rightLine = mainStackMaxX * Constants.twoThird
        
        // Left
        if bunnyBodyView.center.x > mainStackMinX && bunnyBodyView.center.x < leftLine {
            if bunnyBodyViewCenterY > mainStackMinY &&
                bunnyBodyViewCenterY < mainStackMaxY {
                return EarColors.red
            }
        }
        // Center
        if bunnyBodyView.center.x > leftLine && bunnyBodyView.center.x < rightLine {
            if bunnyBodyViewCenterY > mainStackMinY &&
                bunnyBodyViewCenterY < mainStackMaxY {
                return EarColors.green
            }
        }
        // Right top/bottom
        if bunnyBodyView.center.x > rightLine && bunnyBodyView.center.x < mainStackMaxX {
            if bunnyBodyViewCenterY > mainStackMinY &&
                bunnyBodyViewCenterY < mainStackMaxY {
                return EarColors.teal
                
            }
        }
        return EarColors.white
    }
    
    // for four cards
    func colourRecognitionForFourCards() -> EarColors {
        let bunnyBodyViewCenterY = bunnyBodyView.center.y - bunnyBodyView.frame.height / Constants.two
        // vertical
        let verticaLine = mainStackMaxY * Constants.oneHalf
        // horisontal
        let horisontalLine = mainStackMaxX * Constants.oneHalf
        
        // Left top/bottom
        if bunnyBodyView.center.x > mainStackMinX && bunnyBodyView.center.x < horisontalLine {
            if bunnyBodyViewCenterY > mainStackMinY &&
                bunnyBodyViewCenterY < verticaLine {
                return EarColors.red
                
            } else if bunnyBodyViewCenterY > verticaLine &&
                        bunnyBodyViewCenterY < mainStackMaxY {
                return EarColors.blue
            }
        }
        // Right top/bottom
        if bunnyBodyView.center.x > horisontalLine && bunnyBodyView.center.x < mainStackMaxX {
            if bunnyBodyViewCenterY > mainStackMinY &&
                bunnyBodyViewCenterY < verticaLine {
                return EarColors.green
                
            } else if bunnyBodyViewCenterY > verticaLine &&
                        bunnyBodyViewCenterY < mainStackMaxY {
                return EarColors.purple
            }
        }
        return EarColors.white
    }
    
    // for six cards
    func colourRecognitionForSixCards() -> EarColors {
        let bunnyBodyViewCenterY = bunnyBodyView.center.y - bunnyBodyView.frame.height / Constants.two
        // vertical
        let verticaLine = mainStackMaxY * Constants.oneHalf
        // horisontal
        let leftLine = mainStackMaxX * Constants.oneThird
        let rightLine = mainStackMaxX * Constants.twoThird
        
        // Left top/bottom
        if bunnyBodyView.center.x > mainStackMinX && bunnyBodyView.center.x < leftLine {
            if bunnyBodyViewCenterY > mainStackMinY &&
                bunnyBodyViewCenterY < verticaLine {
                return EarColors.red
                
            } else if bunnyBodyViewCenterY > verticaLine &&
                        bunnyBodyViewCenterY < mainStackMaxY {
                return EarColors.blue
            }
        }
        // Center top/bottom
        if bunnyBodyView.center.x > leftLine && bunnyBodyView.center.x < rightLine {
            if bunnyBodyViewCenterY > mainStackMinY &&
                bunnyBodyViewCenterY < verticaLine {
                return EarColors.green
                
            } else if bunnyBodyViewCenterY > verticaLine &&
                        bunnyBodyViewCenterY < mainStackMaxY {
                return EarColors.purple
            }
        }
        // Right top/bottom
        if bunnyBodyView.center.x > rightLine && bunnyBodyView.center.x < mainStackMaxX {
            if bunnyBodyViewCenterY > mainStackMinY &&
                bunnyBodyViewCenterY < verticaLine {
                return EarColors.teal
                
            } else if bunnyBodyViewCenterY > verticaLine &&
                        bunnyBodyViewCenterY < mainStackMaxY {
                return EarColors.brown
            }
        }
        return EarColors.white
    }
    
    // for nine cards
    func colourRecognitionForNineCards() -> EarColors {
        let bunnyBodyViewCenterY = bunnyBodyView.center.y - bunnyBodyView.frame.height / Constants.two
        // vertical
        let topVerticaLine = mainStackMaxY * Constants.oneThird
        let bottomVerticaLine = mainStackMaxY * Constants.twoThird
        // horisontal
        let leftHorisontalLine = mainStackMaxX * Constants.oneThird
        let rightHorisontalLine = mainStackMaxX * Constants.twoThird
        
        // Left top/centr/bottom
        if bunnyBodyView.center.x > mainStackMinX && bunnyBodyView.center.x < leftHorisontalLine {
            if bunnyBodyViewCenterY > mainStackMinY &&
                bunnyBodyViewCenterY < topVerticaLine {
                return EarColors.red
                
            } else if bunnyBodyViewCenterY > topVerticaLine &&
                        bunnyBodyViewCenterY < bottomVerticaLine {
                return EarColors.blue
                
            } else if bunnyBodyViewCenterY > bottomVerticaLine &&
                        bunnyBodyViewCenterY < mainStackMaxY {
                return EarColors.orange
            }
        }
        // Center top/centr/bottom
        if bunnyBodyView.center.x > leftHorisontalLine && bunnyBodyView.center.x < rightHorisontalLine {
            if bunnyBodyViewCenterY > mainStackMinY &&
                bunnyBodyViewCenterY < topVerticaLine {
                return EarColors.green
                
            } else if bunnyBodyViewCenterY > topVerticaLine &&
                        bunnyBodyViewCenterY < bottomVerticaLine {
                return EarColors.purple
                
            } else if bunnyBodyViewCenterY > bottomVerticaLine &&
                        bunnyBodyViewCenterY < mainStackMaxY {
                return .yellow
            }
        }
        // Right top/centr/bottom
        if bunnyBodyView.center.x > rightHorisontalLine && bunnyBodyView.center.x < mainStackMaxX {
            if bunnyBodyViewCenterY > mainStackMinY &&
                bunnyBodyViewCenterY < topVerticaLine {
                return EarColors.teal
                
            } else if bunnyBodyViewCenterY > topVerticaLine &&
                        bunnyBodyViewCenterY < bottomVerticaLine {
                return EarColors.brown
                
            } else if bunnyBodyViewCenterY > bottomVerticaLine &&
                        bunnyBodyViewCenterY < mainStackMaxY {
                return .pinc
            }
        }
        
        
        return EarColors.white
    }
}

private struct Constants {
    static let oneThird: CGFloat = 1/3
    static let twoThird: CGFloat = 2/3
    static let oneHalf: CGFloat = 1/2
    static let two: CGFloat = 2
}
