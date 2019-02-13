 import UIKit
 import QuartzCore
 
 public enum ConfettiType {
    case confetti
    case triangle
    case star
    case diamond
    case image(UIImage)
 }
 
 struct ConfettiCardProperties {
    let colorsNodes: Bool
    let colors: [UIColor]
    let type: ConfettiType
    
    static let `default` = ConfettiCardProperties(colorsNodes: true, colors: ConfettiCardProperties.defaultColors, type: .confetti)
    
    static let defaultColors: [UIColor] = [
        UIColor(red:0.95, green:0.40, blue:0.27, alpha:1.0),
        UIColor(red:1.00, green:0.78, blue:0.36, alpha:1.0),
        UIColor(red:0.48, green:0.78, blue:0.64, alpha:1.0),
        UIColor(red:0.30, green:0.76, blue:0.85, alpha:1.0),
        UIColor(red:0.58, green:0.39, blue:0.55, alpha:1.0)]
 }
 
 class ConfettiView: UIView {
    var properties: ConfettiCardProperties
    var emitter: CAEmitterLayer!
    public var colors: [UIColor]!
    public var intensity: Float!
    public var type: ConfettiType = .confetti
    private var active :Bool!
    
    init(properties: ConfettiCardProperties = .default) {
        self.properties = properties
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        //        guard properties.type.rawValue != self.type else { return }
        colors = self.properties.colors
        intensity = 0.5
        type = self.properties.type
        //        active = false
        //        startConfetti()
    }
    
    public func startConfetti() {
        emitter = CAEmitterLayer()
        
        emitter.emitterPosition = CGPoint(x: frame.size.width / 2.0, y: 0)
        emitter.emitterShape = CAEmitterLayerEmitterShape.line
        emitter.emitterSize = CGSize(width: frame.size.width, height: 1)
        
        var cells = [CAEmitterCell]()
        for color in colors {
            cells.append(confettiWithColor(color: color))
        }
        
        emitter.emitterCells = cells
        layer.addSublayer(emitter)
        active = true
    }
    
    public func stopConfetti() {
        emitter?.birthRate = 0
        active = false
    }
    
    func imageForType(type: ConfettiType) -> UIImage? {
        
        switch type {
        case .confetti:
            return #imageLiteral(resourceName: "confetti")
        case .triangle:
            return #imageLiteral(resourceName: "triangle")
        case .star:
            return #imageLiteral(resourceName: "star")
        case .diamond:
            return #imageLiteral(resourceName: "diamond")
        case let .image(customImage):
            return customImage
        }
    }
    
    func confettiWithColor(color: UIColor) -> CAEmitterCell {
        let confetti = CAEmitterCell()
        confetti.birthRate = 6.0 * intensity
        confetti.lifetime = 14.0 * intensity
        confetti.lifetimeRange = 0
        confetti.velocity = CGFloat(350.0 * intensity)
        confetti.velocityRange = CGFloat(80.0 * intensity)
        confetti.emissionLongitude = CGFloat(Double.pi)
        confetti.emissionRange = CGFloat(Double.pi)
        confetti.spin = CGFloat(3.5 * intensity)
        confetti.spinRange = CGFloat(4.0 * intensity)
        confetti.scaleRange = CGFloat(intensity)
        confetti.scaleSpeed = CGFloat(-0.1 * intensity)
        confetti.contents = imageForType(type: type)!.cgImage
        
        if properties.colorsNodes {
            confetti.color = color.cgColor
        }
        
        return confetti
    }
    
    public func isActive() -> Bool {
        return self.active
    }
 }
 
 
 class BtcConfettiView: UIView {
    var properties: ConfettiCardProperties = ConfettiCardProperties(colorsNodes: false, colors: [], type: .image(#imageLiteral(resourceName: "btc_small")))
    var emitter: CAEmitterLayer!
    public var colors: [UIColor] = [.green, .green, .green, .green, .green, .green, .green, .green]
    public var intensity: Float!
    public var type: ConfettiType = .image(#imageLiteral(resourceName: "btc_small"))
    private var active :Bool!
    
    init(properties: ConfettiCardProperties = .default) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        intensity = 0.5
        startConfetti()
    }
    
    public func startConfetti() {
        emitter = CAEmitterLayer()
        
        emitter.emitterPosition = CGPoint(x: frame.size.width / 2.0, y: 0)
        emitter.emitterShape = CAEmitterLayerEmitterShape.line
        emitter.emitterSize = CGSize(width: frame.size.width, height: 1)
        
        var cells = [CAEmitterCell]()
        for color in colors {
            cells.append(confettiWithColor(color: color))
        }
        
        emitter.emitterCells = cells
        layer.addSublayer(emitter)
        active = true
    }
    
    public func stopConfetti() {
        emitter?.birthRate = 0
        active = false
    }
    
    func imageForType(type: ConfettiType) -> UIImage? {
        
        switch type {
        case .confetti:
            return #imageLiteral(resourceName: "confetti")
        case .triangle:
            return #imageLiteral(resourceName: "triangle")
        case .star:
            return #imageLiteral(resourceName: "star")
        case .diamond:
            return #imageLiteral(resourceName: "diamond")
        case let .image(customImage):
            return customImage
        }
    }
    
    func confettiWithColor(color: UIColor) -> CAEmitterCell {
        let confetti = CAEmitterCell()
        confetti.birthRate = 6.0 * intensity
        confetti.lifetime = 14.0 * intensity
        confetti.lifetimeRange = 0
        confetti.velocity = CGFloat(350.0 * intensity)
        confetti.velocityRange = CGFloat(80.0 * intensity)
        confetti.emissionLongitude = CGFloat(Double.pi)
        confetti.emissionRange = CGFloat(Double.pi)
        confetti.spin = CGFloat(3.5 * intensity)
        confetti.spinRange = CGFloat(4.0 * intensity)
        confetti.scaleRange = CGFloat(intensity)
        confetti.scaleSpeed = CGFloat(-0.1 * intensity)
        confetti.contents = imageForType(type: type)!.cgImage
        
        if properties.colorsNodes {
            confetti.color = color.cgColor
        }
        
        return confetti
    }
    
    public func isActive() -> Bool {
        return self.active
    }
 }

