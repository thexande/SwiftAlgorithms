import UIKit

protocol DataStructurePresenterActionDispatching: AnyObject {
    func dispatch(_ action: DataStructurePresenter.Action)
}

final class DataStructurePresenter {
    
    enum Action {
        case selectedCategory(DataStructure.Category)
        case selectedDataStructure(DataStructure)
    }
    
    private var actionLookup: [UUID: Action] = [:]
    
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
    
    public func makeArraySection() -> BasicTableSectionController {
        
        let section = BasicTableSectionController()
        
        let arrayProps = makeIdentifiableProperties(for: DataStructure.Category.array.dataStructures)
        section.rows = arrayProps.map(BasicTableRowController.map)
        
        section.sectionTitle = "Variations on Arrays"
        
        return section
    }
    
    public func makeQueueSection() -> BasicTableSectionController {
        
        let section = BasicTableSectionController()
        
        let arrayProps = makeIdentifiableProperties(for: DataStructure.Category.queue.dataStructures)
        section.rows = arrayProps.map(BasicTableRowController.map)
        
        section.sectionTitle = "Queues"
        
        return section
    }
    
    public func makeListSection() -> BasicTableSectionController {
        
        let section = BasicTableSectionController()
        
        let arrayProps = makeIdentifiableProperties(for: DataStructure.Category.list.dataStructures)
        section.rows = arrayProps.map(BasicTableRowController.map)
        
        section.sectionTitle = "Lists"
        
        return section
    }
    
    public func makeTreeSection() -> BasicTableSectionController {
        
        let section = BasicTableSectionController()
        
        let arrayProps = makeIdentifiableProperties(for: DataStructure.Category.tree.dataStructures)
        section.rows = arrayProps.map(BasicTableRowController.map)
        
        section.sectionTitle = "Trees"
        
        return section
    }
    
    public func makeHashingSection() -> BasicTableSectionController {
        
        let section = BasicTableSectionController()
        
        let arrayProps = makeIdentifiableProperties(for: DataStructure.Category.hash.dataStructures)
        section.rows = arrayProps.map(BasicTableRowController.map)
        
        section.sectionTitle = "Hashing"
        
        return section
    }
    
    public func makeSetSection() -> BasicTableSectionController {
        
        let section = BasicTableSectionController()
        
        let arrayProps = makeIdentifiableProperties(for: DataStructure.Category.set.dataStructures)
        section.rows = arrayProps.map(BasicTableRowController.map)
        
        section.sectionTitle = "Sets"
        
        return section
    }
    
    public func makeGraphSection() -> BasicTableSectionController {
        
        let section = BasicTableSectionController()
        
        let arrayProps = makeIdentifiableProperties(for: DataStructure.Category.graph.dataStructures)
        section.rows = arrayProps.map(BasicTableRowController.map)
        
        section.sectionTitle = "Graphing"
        
        return section
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

