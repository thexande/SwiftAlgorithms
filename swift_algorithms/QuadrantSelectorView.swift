import UIKit
import Anchorage

final class QuadrantSelectorView: UIView {
    
    let one = QuadrantItemView()
    let two = QuadrantItemView()
    let three = QuadrantItemView()
    let four = QuadrantItemView()
    
    func configure(with items: [QuadrantItemView.Properties]) {
        items.enumerated().forEach({ index, element in
            switch index {
            case 0:
                one.render(element)
            case 1:
                two.render(element)
            case 2:
                three.render(element)
            case 3:
                four.render(element)
            default: return
            }
        })
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let firstRow = UIStackView(arrangedSubviews: [one, two])
        firstRow.distribution = .fillEqually
        firstRow.spacing = 8
        
        let secondRow = UIStackView(arrangedSubviews: [three, four])
        secondRow.distribution = .fillEqually
        secondRow.spacing = 8
        
        let stack = UIStackView(arrangedSubviews: [firstRow, secondRow])
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.spacing = 8
        
        addSubview(stack)
        stack.edgeAnchors == edgeAnchors + UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
