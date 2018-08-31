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
                               subtitle: String?,
                               dataStructures: [DataStructure]) -> IdentifiableSectionController {
        
        let sectionController = BasicTableSectionController()
        let identifiableProperties = makeIdentifiableProperties(for: dataStructures)
        
        sectionController.rows = identifiableProperties.properties.map(BasicTableRowController.map)
        sectionController.sectionTitle = title
        sectionController.sectionSubtitle = subtitle
        
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
        
        section.sectionTitle = "Graphs"
        
        section.footerText = """
        The choice of data structure for a particular task depends on a few things.
        
        First, there is the shape of your data and the kinds of operations that you'll need to perform on it. If you want to look up objects by a key you need some kind of dictionary; if your data is hierarchical in nature you want a tree structure of some sort; if your data is sequential you want a stack or queue.
        
        Second, it matters what particular operations you'll be performing most, as certain data structures are optimized for certain actions. For example, if you often need to find the most important object in a collection, then a heap or priority queue is more optimal than a plain array.
        
        Most of the time using just the built-in Array, Dictionary, and Set types is sufficient, but sometimes you may want something more fancy...
        """
        
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

