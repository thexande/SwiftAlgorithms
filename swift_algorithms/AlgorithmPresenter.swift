import UIKit


final class AlgorithmPresenter {
    
    enum Action {
        case selectedCategory(Algorithm.Category)
        case selectedAlgorithm(Algorithm)
    }
    
    var actionLookup: [UUID: Action] = [:]
    
    weak var dispatcher: AlgorithmPresenterActionDispatching?
    
    public func makeIntroSectionSection() -> ActionTableSectionController {

        let actionSection = ActionTableSectionController()
        
        let actions: [Algorithm] = [.whatAreAlgorithms, .whyLearnAlgorithms, .bigO, .designTechniques, .howToContribute]
        
        let identifiableProperties: [ActionTableRowController.Properties] = actions.map { action in
            let identifier = UUID()
            let properties = ActionTableRowController.Properties(title: action.title, subtitle: action.subtitle, icon: action.actionImage, identifier: identifier)
            actionLookup[identifier] = .selectedAlgorithm(action)
            return properties
        }

        let actionRows = identifiableProperties.map(ActionTableRowController.map)

        actionSection.rows = actionRows
//        actionSection.rows.insert(makeCatgorySideScrollerSection(), at: 0)
        return actionSection
    }
    
    public func makeGettingStartedSection() -> BasicTableSectionController {
        
        let starterSection = BasicTableSectionController()
        
        let gettingStartedAlgorithms: [Algorithm] = [.stack, .queue, .insertionSort, .binarySearch, .binarySearchTree, .mergeSort, .boyerMoore]
        
        let identifiableProperties: [BasicTableRowController.Properties] = gettingStartedAlgorithms.map { algorithm in
            let identifier = UUID()
            let properties = BasicTableRowController.Properties(title: algorithm.title, subtitle: algorithm.subtitle, showsDisclosure: false, identifier: identifier)
            actionLookup[identifier] = .selectedAlgorithm(algorithm)
            return properties
        }
        
        starterSection.rows = identifiableProperties.map(BasicTableRowController.map)
        
        starterSection.sectionTitle = "Where to start?"
        starterSection.sectionSubtitle = "If you're new to algorithms and data structures, here are a few good ones to start out with:"
        
        return starterSection
    }
    
//    public func makeSearchingSection() -> BasicTableSectionController {
//
//        let searchingRowProps = AlgorithmSectionProperties.searchingSectionProperties
//
//        let searchingRowSection = BasicTableSectionController()
//        let searchingRows = searchingRowProps.map(BasicTableRowController.map)
//        searchingRowSection.rows = searchingRows
//        searchingRowSection.sectionTitle = "Searching"
//        searchingRowSection.dispatcher = self.dispatcher
//
//        return searchingRowSection
//    }
//
//    public func makeStringSearchSection() -> BasicTableSectionController {
//
//        let searchRowProps = AlgorithmSectionProperties.stringSearchingSectionProperties
//
//        let searchingRowSection = BasicTableSectionController()
//        let searchingRows = searchRowProps.map(BasicTableRowController.map)
//
//        searchingRowSection.rows = searchingRows
//        searchingRowSection.sectionTitle = "String Search"
//        searchingRowSection.dispatcher = self.dispatcher
//        return searchingRowSection
//    }
//
//
//    public func makeSortingSection() -> BasicTableSectionController {
//        var sortingRows: [RowController] = []
//
//        // configure basic sorts
//
//        let basicSorts = AlgorithmSectionProperties.Sorting.basic
//
//        let basicSortHeader = BasicTableHeaderRowController.map(BasicTableHeaderRowController.Properties(title: "Basic Sorts"))
//        sortingRows.append(basicSortHeader)
//        sortingRows.append(contentsOf: basicSorts.map(BasicTableRowController.map))
//
//        // configure fast sorts
//
//        let fastSorts = AlgorithmSectionProperties.Sorting.fast
//
//        let fastSortHeader = BasicTableHeaderRowController.map(BasicTableHeaderRowController.Properties(title: "Fast Sorts"))
//        sortingRows.append(fastSortHeader)
//        sortingRows.append(contentsOf: fastSorts.map(BasicTableRowController.map))
//
//        // configure hybrid sorts
//
//        let hybridSorts = AlgorithmSectionProperties.Sorting.hybrid
//
//        let hybridSortHeader = BasicTableHeaderRowController.map(BasicTableHeaderRowController.Properties(title: "Hybrid Sorts"))
//        sortingRows.append(hybridSortHeader)
//        sortingRows.append(contentsOf: hybridSorts.map(BasicTableRowController.map))
//
//        // configure special purpose sorts
//
//        let specialPurposeSorts = AlgorithmSectionProperties.Sorting.special
//
//        let specialPurposeSortHeader = BasicTableHeaderRowController.map(BasicTableHeaderRowController.Properties(title: "Basic Sorts"))
//        sortingRows.append(specialPurposeSortHeader)
//        sortingRows.append(contentsOf: specialPurposeSorts.map(BasicTableRowController.map))
//
//        // configure bad sorts
//
//        let badSorts = AlgorithmSectionProperties.Sorting.bad
//        let badSortHeader = BasicTableHeaderRowController.map(BasicTableHeaderRowController.Properties(title: "Basic Sorts"))
//        sortingRows.append(badSortHeader)
//        sortingRows.append(contentsOf: badSorts.map(BasicTableRowController.map))
//
//
//        let sortingRowsSection = BasicTableSectionController()
//
//        sortingRowsSection.rows = sortingRows
//        sortingRowsSection.sectionTitle = "Sorting"
//        sortingRowsSection.sectionSubtitle = "It's fun to see how sorting algorithms work, but in practice you'll almost never have to provide your own sorting routines. Swift's own sort() is more than up to the job. But if you're curious, read on..."
//        sortingRowsSection.dispatcher = self.dispatcher
//
//        return sortingRowsSection
//    }
//
//    public func makeCompressionSection() -> BasicTableSectionController {
//        let compressionRowProps = AlgorithmSectionProperties.compressionSectionProperties
//
//        let compressionRowSection = BasicTableSectionController()
//        let compressionRows = compressionRowProps.map(BasicTableRowController.map)
//
//        compressionRowSection.rows = compressionRows
//        compressionRowSection.sectionTitle = "Compression"
//        compressionRowSection.dispatcher = self.dispatcher
//        return compressionRowSection
//    }
//
//    public func makeMiscellaneousSection() -> BasicTableSectionController {
//        let miscellaneousRowProps = AlgorithmSectionProperties.miscellaneousSectionProperties
//
//        let miscellaneousRowSection = BasicTableSectionController()
//        let miscellaneousRows = miscellaneousRowProps.map(BasicTableRowController.map)
//
//        miscellaneousRowSection.rows = miscellaneousRows
//        miscellaneousRowSection.sectionTitle = "Miscellaneous"
//        miscellaneousRowSection.dispatcher = self.dispatcher
//        return miscellaneousRowSection
//    }
//
//    public func makeMathSection() -> BasicTableSectionController {
//        let mathRowProps = AlgorithmSectionProperties.mathSectionProperties
//
//        let mathRowSection = BasicTableSectionController()
//        let mathRows = mathRowProps.map(BasicTableRowController.map)
//
//        mathRowSection.rows = mathRows
//        mathRowSection.sectionTitle = "Mathematics"
//        mathRowSection.dispatcher = self.dispatcher
//        return mathRowSection
//    }
//
//    public func makeMachineLearningSection() -> BasicTableSectionController {
//        let machineLearningRowProps = AlgorithmSectionProperties.machineLearningSectionProperties
//
//        let machineLearningRowSection = BasicTableSectionController()
//        let machineLearningRows = machineLearningRowProps.map(BasicTableRowController.map)
//
//        machineLearningRowSection.rows = machineLearningRows
//        machineLearningRowSection.sectionTitle = "Machine Learning"
//        machineLearningRowSection.dispatcher = self.dispatcher
//        return machineLearningRowSection
//    }
//
//    func makeAboutSection() -> BasicTableSectionController {
//        let rowController = JoinTheClubRowController()
//        let controller = BasicTableSectionController()
//        controller.rows = [rowController]
//        return controller
//    }
//
//    func makeCatgorySideScrollerSection() -> CategoryRowTableRowController {
//        let section = CategoryRowTableRowController()
//        section.dispatcher = self.dispatcher
//
//        let items: [CategoryTileItemView.Properties] = [
//            .gettingStarted, .searching, .machineLearning, .math, .stringSearch, .sorting, .compression, .misc
//        ].map(CategoryTileItemView.Properties.init)
//
//        section.properties = items
//        return section
//    }
}


extension AlgorithmPresenter: AlgorithmViewActionDispatching {
    func dispatch(_ action: AlgorithmViewController.Action) {
        switch action {
        case let .selectedItem(identifier):
            
            guard let action = actionLookup[identifier] else {
                return
            }
            
            dispatcher?.dispatch(action)
//        default: dispatcher?.dispatch(action)
        }
    }
}
