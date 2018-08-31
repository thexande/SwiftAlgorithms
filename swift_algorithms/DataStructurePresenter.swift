import UIKit

protocol DataStructurePresenterActionDispatching: AnyObject {
    func dispatch(_ action: DataStructurePresenter.Action)
}

final class DataStructureSectionFactory {
    
    struct IdentifiableSectionController {
        let seciton: TableSectionController
        let identifiers: [UUID: DataStructurePresenter.Action]
   }
    
    struct IdentifiableRowProperties {
        let properties: [BasicTableRowController.Properties]
        let identifiers: [UUID: DataStructurePresenter.Action]
    }
    
    func makeSectionController(title: String,
                               footerText: String?,
                               dataStructures: [DataStructure]) -> IdentifiableSectionController {
        
        let sectionController = BasicTableSectionController()
        let identifiableProperties = makeIdentifiableProperties(for: dataStructures)
        
        sectionController.rows = identifiableProperties.properties.map(BasicTableRowController.map)
        sectionController.sectionTitle = title
        sectionController.footerText = footerText
        
        return IdentifiableSectionController(seciton: sectionController,
                                             identifiers: identifiableProperties.identifiers)
    }
    
    
    private func makeIdentifiableProperties(for dataStructures: [DataStructure]) -> IdentifiableRowProperties {
        
        var actionLookup: [UUID: DataStructurePresenter.Action] = [:]
        
        let identifiableProperties: [BasicTableRowController.Properties] = dataStructures.map { dataStructure in
            let identifier = UUID()
            let properties = BasicTableRowController.Properties(title: dataStructure.title,
                                                                subtitle: dataStructure.subtitle,
                                                                showsDisclosure: true,
                                                                identifier: identifier)
            actionLookup[identifier] = .selectedDataStructure(dataStructure)
            return properties
        }
        
        return IdentifiableRowProperties(properties: identifiableProperties,
                                         identifiers: actionLookup)
    }
    
    func makeAllDataStructureSections() -> [IdentifiableSectionController] {
        let allDataStructureCategories = DataStructure.Category.allCases
        
        return allDataStructureCategories.map { category in
            let section = makeSectionController(title: category.title,
                                                footerText: category.footerText,
                                                dataStructures: category.dataStructures)
            return section
        }
    }
    
}

final class DataStructurePresenter {
    
    enum Action {
        case selectedCategory(DataStructure.Category)
        case selectedDataStructure(DataStructure)
    }
    
    private var actionLookup: [UUID: Action] = [:]
    
    public var sectionFactory = DataStructureSectionFactory()
    
    weak var dispatcher: DataStructurePresenterActionDispatching?
    
    private func makeIdentifiableProperties(for dataStructures: [DataStructure]) -> [BasicTableRowController.Properties] {
        
        let identifiableProperties: [BasicTableRowController.Properties] = dataStructures.map { dataStructure in
            let identifier = UUID()
            let properties = BasicTableRowController.Properties(title: dataStructure.title,
                                                                subtitle: dataStructure.subtitle,
                                                                showsDisclosure: true,
                                                                identifier: identifier)
            actionLookup[identifier] = .selectedDataStructure(dataStructure)
            return properties
        }
        
        return identifiableProperties
    }
    
    
    func makeCatgorySideScrollerSection() -> BasicTableSectionController {
        let section = CategoryRowTableRowController()
        
        let categories = DataStructure.Category.allCases
        
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
        
        let controller = BasicTableSectionController()
        controller.rows = [section]
        return controller
    }
    
    public func makeAllSectiions() -> [TableSectionController] {
        
        var returnSections: [TableSectionController] = []
        let identifiableSections = sectionFactory.makeAllDataStructureSections()
        
        identifiableSections.forEach { section in
            returnSections.append(section.seciton)
            
            section.identifiers.forEach { identifier in
                actionLookup[identifier.key] = identifier.value
            }
            
        }
        
        let categorySection = makeCatgorySideScrollerSection()
        returnSections.insert(categorySection, at: 0)
        
        return returnSections
    }
}

extension DataStructurePresenter: DataStructruesViewActionDispatching {
    func dispatch(_ action: DataStructuresViewController.Action) {
        switch action {
        case let .selectedItem(identifier):
            
            guard let action = actionLookup[identifier] else {
                return
            }
            
            dispatcher?.dispatch(action)
        }
    }
}

