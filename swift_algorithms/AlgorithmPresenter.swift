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


final class AlgorithmPresenter {
    
    enum Action {
        case selectedCategory(Algorithm.Category)
        case selectedAlgorithm(Algorithm)
    }
    
    var actionLookup: [UUID: Action] = [:]
    
    weak var dispatcher: AlgorithmPresenterActionDispatching?
    
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
            let properties = ActionTableRowController.Properties(title: action.title,
                                                                 subtitle: action.subtitle,
                                                                 icon: action.actionImage,
                                                                 identifier: identifier)
            actionLookup[identifier] = .selectedAlgorithm(action)
            return properties
        }

        let actionRows = identifiableProperties.map(ActionTableRowController.map)

        actionSection.rows = actionRows
        actionSection.rows.insert(makeCatgorySideScrollerSection(), at: 0)
        return actionSection
    }
    
    public func makeGettingStartedSection() -> BasicTableSectionController {
        
        let starterSection = BasicTableSectionController()
        
        let identifiableProperties = makeIdentifiableProperties(for: Algorithm.gettingStarted)

        starterSection.rows = identifiableProperties.map(BasicTableRowController.map)
        
        starterSection.sectionTitle = "Where to start?"
        starterSection.sectionSubtitle = "If you're new to algorithms and data structures, here are a few good ones to start out with:"
        
        return starterSection
    }
    
    public func makeSearchingSection() -> BasicTableSectionController {

        let searchingAlgorithms = makeIdentifiableProperties(for: Algorithm.searching)

        let searchingRowSection = BasicTableSectionController()
        let searchingRows = searchingAlgorithms.map(BasicTableRowController.map)
        searchingRowSection.rows = searchingRows
        searchingRowSection.sectionTitle = "Searching"

        return searchingRowSection
    }

    public func makeStringSearchSection() -> BasicTableSectionController {

        let searchRowProps = makeIdentifiableProperties(for: Algorithm.stringSearch)

        let searchingRowSection = BasicTableSectionController()
        let searchingRows = searchRowProps.map(BasicTableRowController.map)

        searchingRowSection.rows = searchingRows
        searchingRowSection.sectionTitle = "String Search"
        return searchingRowSection
        
    }


    public func makeSortingSections() -> [BasicTableSectionController] {
        var sortingSections: [BasicTableSectionController] = []

        // configure basic sorts

        let basicSorts = makeIdentifiableProperties(for: Algorithm.Sorting.basic)

        let basicSection = BasicTableSectionController()
        basicSection.sectionTitle = "Basic Sorts"
        
        basicSection.sectionTitle = "Sorting"
        basicSection.sectionSubtitle = "It's fun to see how sorting algorithms work, but in practice you'll almost never have to provide your own sorting routines. Swift's own sort() is more than up to the job. But if you're curious, read on..."

        basicSection.rows = basicSorts.map(BasicTableRowController.map)
        sortingSections.append(basicSection)

        // configure fast sorts

        let fastSorts = makeIdentifiableProperties(for: Algorithm.Sorting.fast)

        let fastSection = BasicTableSectionController()
        fastSection.sectionTitle = "Fast Sorts"
        fastSection.rows = fastSorts.map(BasicTableRowController.map)
        sortingSections.append(fastSection)

        // configure hybrid sorts

        let hybridSorts = makeIdentifiableProperties(for: Algorithm.Sorting.hybrid)

        let hybridSection = BasicTableSectionController()
        hybridSection.sectionTitle = "Hybrid Sorts"
        hybridSection.rows = hybridSorts.map(BasicTableRowController.map)
        sortingSections.append(hybridSection)

        // configure special purpose sorts

        let specialPurposeSorts = makeIdentifiableProperties(for: Algorithm.Sorting.specialPurpose)

        let specialPurposeSection = BasicTableSectionController()
        specialPurposeSection.sectionTitle = "Special Purpose Sorts"
        specialPurposeSection.rows = specialPurposeSorts.map(BasicTableRowController.map)
        sortingSections.append(specialPurposeSection)

        // configure bad sorts

        let badSorts = makeIdentifiableProperties(for: Algorithm.Sorting.bad)
        let badSortSection = BasicTableSectionController()
        badSortSection.rows = badSorts.map(BasicTableRowController.map)

        return sortingSections
    }

    public func makeCompressionSection() -> BasicTableSectionController {
        let compressionRowProps = makeIdentifiableProperties(for: Algorithm.compression)

        let compressionRowSection = BasicTableSectionController()
        let compressionRows = compressionRowProps.map(BasicTableRowController.map)

        compressionRowSection.rows = compressionRows
        compressionRowSection.sectionTitle = "Compression"
        
        return compressionRowSection
    }

    public func makeMiscellaneousSection() -> BasicTableSectionController {
        let miscellaneousRowProps = makeIdentifiableProperties(for: Algorithm.miscellaneous)

        let miscellaneousRowSection = BasicTableSectionController()
        let miscellaneousRows = miscellaneousRowProps.map(BasicTableRowController.map)

        miscellaneousRowSection.rows = miscellaneousRows
        miscellaneousRowSection.sectionTitle = "Miscellaneous"
        
        return miscellaneousRowSection
    }

    public func makeMathSection() -> BasicTableSectionController {
        let mathRowProps = makeIdentifiableProperties(for: Algorithm.mathematics)

        let mathRowSection = BasicTableSectionController()
        let mathRows = mathRowProps.map(BasicTableRowController.map)

        mathRowSection.rows = mathRows
        mathRowSection.sectionTitle = "Mathematics"
        
        return mathRowSection
    }

    public func makeMachineLearningSection() -> BasicTableSectionController {
        let machineLearningRowProps = makeIdentifiableProperties(for: Algorithm.machineLearning)

        let machineLearningRowSection = BasicTableSectionController()
        let machineLearningRows = machineLearningRowProps.map(BasicTableRowController.map)

        machineLearningRowSection.rows = machineLearningRows
        machineLearningRowSection.sectionTitle = "Machine Learning"
        
        return machineLearningRowSection
    }

    func makeAboutSection() -> BasicTableSectionController {
        let rowController = JoinTheClubRowController()
        let controller = BasicTableSectionController()
        controller.rows = [rowController]
        return controller
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
