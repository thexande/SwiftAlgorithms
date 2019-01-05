import UIKit

enum AlgorithmPresentationAction {
    case selectedCategory(Algorithm.Category)
    case selectedAlgorithm(Algorithm)
}

final class AlgorithmPresenter {
    
    var actionLookup: [UUID: AlgorithmPresentationAction] = [:]
    
    weak var dispatcher: AlgorithmPresenterActionDispatching?
    
    private let sectionFactory = AlgorithmSectionFactory()
    
    private func makeIdentifiableProperties(for algorithms: [Algorithm]) -> [BasicTableRowController.Properties] {
        
        let identifiableProperties: [BasicTableRowController.Properties] = algorithms.map { algorithm in
            let identifier = UUID()
            let properties = BasicTableRowController.Properties(title: algorithm.title,
                                                                subtitle: algorithm.subtitle,
                                                                showsDisclosure: true,
                                                                identifier: identifier)
            actionLookup[identifier] = .selectedAlgorithm(algorithm)
            return properties
        }
        
        return identifiableProperties
    }
    
    public func makeIntroSectionSection() -> ActionTableSectionController {

        let actionSection = ActionTableSectionController()
        
        let identifiableProperties: [ActionTableRowController.Properties] = Algorithm.introduction.map { action in
            let identifier = UUID()
            let icon = action.actionImage
            icon?.accessibilityIdentifier = action.title
            let properties = ActionTableRowController.Properties(title: action.title,
                                                                 subtitle: action.subtitle,
                                                                 icon: icon,
                                                                 identifier: identifier)
            actionLookup[identifier] = .selectedAlgorithm(action)
            return properties
        }

        let actionRows = identifiableProperties.map(ActionTableRowController.map)

        actionSection.rows = actionRows
        actionSection.rows.insert(makeCatgorySideScrollerSection(), at: 0)
        return actionSection
    }
    
    func makeCatgorySideScrollerSection() -> CategoryRowTableRowController {
        let section = CategoryRowTableRowController()

        let categories: [Algorithm.Category] = [
            .gettingStarted, .searching, .machineLearning, .math, .stringSearch, .sorting, .compression, .misc
        ]
        
        let items: [CategoryTileItemView.Properties] = categories.map { category in
            let identifier = UUID()
            let prop = CategoryTileItemView.Properties(title: category.title,
                                                       image: category.image,
                                                       backgroundColor: category.color,
                                                       identifier: identifier)
            actionLookup[identifier] = .selectedCategory(category)
            return prop
        }

        section.properties = items
        return section
    }
    
    public func makeAllAlgorithmSections() -> [TableSectionController] {
        var sections: [TableSectionController] = []
        
        sections.append(makeIntroSectionSection())
        
        let categories: [TableSectionController] = Algorithm.Category.allCases.compactMap { category in
            
            guard let controller = sectionFactory.makeSection(for: category) else {
                return nil
            }
            
            controller.identifiers.forEach { tuple in
                actionLookup[tuple.key] = tuple.value
            }
            
            return controller.seciton
        }
        
        sections.append(contentsOf: categories)
        
        let sortingSections: [TableSectionController] = sectionFactory.makeAllSortingSections().map { section in
            
            section.identifiers.forEach { tuple in
                actionLookup[tuple.key] = tuple.value
            }
            
            return section.seciton
        }
        
        sections.append(contentsOf: sortingSections)
        
        return sections
    }
}


extension AlgorithmPresenter: AlgorithmViewActionDispatching {
    func dispatch(_ action: AlgorithmViewController.Action) {
        switch action {
        case let .selectedItem(identifier):
            
            guard let action = actionLookup[identifier] else {
                return
            }
            
            dispatcher?.dispatch(action)
        }
    }
}
