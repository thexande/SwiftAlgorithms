import UIKit

final class AlgorithmPresenter {
    weak var dispatcher: AlogrithmActionDispatching?
    
    public func makeIntroSectionSection() -> ActionTableSectionController {
        
        let actionSection = ActionTableSectionController()
        
        let rowProps: [ActionTableRowController.Properties] = [
            ActionTableRowController.Properties(title: "What are algorithms and data structures?", subtitle: "Pancakes!", icon: UIImage(named: "pancakes"), action: .whatAreAlgorithms),
            ActionTableRowController.Properties(title: "Why learn algorithms?", subtitle: "Worried this isn't your cup of tea? Then read this.", icon: UIImage(named: "?"), action: .whyLearnAlgorithms),
            ActionTableRowController.Properties(title: "Big-O notation", subtitle: "We often say things like, 'This algorithm is O(n).' If you don't know what that means, read this first.", icon: UIImage(named: "line_chart"), action: .bigO),
            ActionTableRowController.Properties(title: "Algorithm design techniques", subtitle: "How do you create your own algorithms?", icon: UIImage(named: "algo")?.withRenderingMode(.alwaysTemplate), action: .designTechniques),
            ActionTableRowController.Properties(title: "How to contribute", subtitle: "Report an issue to leave feedback, or submit a pull request.", icon: UIImage(named: "git"), action: .howToContribute)
            
        ]
        
        let actionRows = rowProps.map(ActionTableRowController.map)
        
        actionSection.rows = actionRows
        actionSection.dispatcher = self.dispatcher
        return actionSection
    }
    
    public func makeGettingStartedSection() -> BasicTableSectionController {
        let starterSection = BasicTableSectionController()
        
        let starterRowProps = AlgorithmSectionProperties.gettingStartedSectionProperties
        
        starterSection.rows = starterRowProps.map(BasicTableRowController.map)
        starterSection.dispatcher = self.dispatcher
        
        starterSection.sectionTitle = "Where to start?"
        starterSection.sectionSubtitle = "If you're new to algorithms and data structures, here are a few good ones to start out with:"
        
        return starterSection
    }
    
    public func makeSearchingSection() -> BasicTableSectionController {
        
        let searchingRowProps = AlgorithmSectionProperties.searchingSectionProperties
        
        let searchingRowSection = BasicTableSectionController()
        let searchingRows = searchingRowProps.map(BasicTableRowController.map)
        searchingRowSection.rows = searchingRows
        searchingRowSection.sectionTitle = "Searching"
        searchingRowSection.dispatcher = self.dispatcher
        
        return searchingRowSection
    }
    
    public func makeStringSearchSection() -> BasicTableSectionController {
        
        let searchRowProps = AlgorithmSectionProperties.stringSearchingSectionProperties
        
        let searchingRowSection = BasicTableSectionController()
        let searchingRows = searchRowProps.map(BasicTableRowController.map)
        
        searchingRowSection.rows = searchingRows
        searchingRowSection.sectionTitle = "String Search"
        searchingRowSection.dispatcher = self.dispatcher
        return searchingRowSection
    }
    
    
    public func makeSortingSection() -> BasicTableSectionController {
        var sortingRows: [RowController] = []
        
        // configure basic sorts
        
        let basicSorts = AlgorithmSectionProperties.Sorting.basic
        
        let basicSortHeader = BasicTableHeaderRowController.map(BasicTableHeaderRowController.Properties(title: "Basic Sorts"))
        sortingRows.append(basicSortHeader)
        sortingRows.append(contentsOf: basicSorts.map(BasicTableRowController.map))
        
        // configure fast sorts
        
        let fastSorts = AlgorithmSectionProperties.Sorting.fast
        
        let fastSortHeader = BasicTableHeaderRowController.map(BasicTableHeaderRowController.Properties(title: "Fast Sorts"))
        sortingRows.append(fastSortHeader)
        sortingRows.append(contentsOf: fastSorts.map(BasicTableRowController.map))
        
        // configure hybrid sorts
        
        let hybridSorts = AlgorithmSectionProperties.Sorting.hybrid
        
        let hybridSortHeader = BasicTableHeaderRowController.map(BasicTableHeaderRowController.Properties(title: "Hybrid Sorts"))
        sortingRows.append(hybridSortHeader)
        sortingRows.append(contentsOf: hybridSorts.map(BasicTableRowController.map))
        
        // configure special purpose sorts
        
        let specialPurposeSorts = AlgorithmSectionProperties.Sorting.special
        
        let specialPurposeSortHeader = BasicTableHeaderRowController.map(BasicTableHeaderRowController.Properties(title: "Basic Sorts"))
        sortingRows.append(specialPurposeSortHeader)
        sortingRows.append(contentsOf: specialPurposeSorts.map(BasicTableRowController.map))
        
        // configure bad sorts
        
        let badSorts = AlgorithmSectionProperties.Sorting.bad
        let badSortHeader = BasicTableHeaderRowController.map(BasicTableHeaderRowController.Properties(title: "Basic Sorts"))
        sortingRows.append(badSortHeader)
        sortingRows.append(contentsOf: badSorts.map(BasicTableRowController.map))
        
        
        let sortingRowsSection = BasicTableSectionController()
        
        sortingRowsSection.rows = sortingRows
        sortingRowsSection.sectionTitle = "Sorting"
        sortingRowsSection.sectionSubtitle = "It's fun to see how sorting algorithms work, but in practice you'll almost never have to provide your own sorting routines. Swift's own sort() is more than up to the job. But if you're curious, read on..."
        sortingRowsSection.dispatcher = self.dispatcher
        
        return sortingRowsSection
    }
    
    public func makeCompressionSection() -> BasicTableSectionController {
        let compressionRowProps = AlgorithmSectionProperties.compressionSectionProperties
        
        let compressionRowSection = BasicTableSectionController()
        let compressionRows = compressionRowProps.map(BasicTableRowController.map)
        
        compressionRowSection.rows = compressionRows
        compressionRowSection.sectionTitle = "Compression"
        compressionRowSection.dispatcher = self.dispatcher
        return compressionRowSection
    }
    
    public func makeMiscellaneousSection() -> BasicTableSectionController {
        let miscellaneousRowProps = AlgorithmSectionProperties.miscellaneousSectionProperties
        
        let miscellaneousRowSection = BasicTableSectionController()
        let miscellaneousRows = miscellaneousRowProps.map(BasicTableRowController.map)
        
        miscellaneousRowSection.rows = miscellaneousRows
        miscellaneousRowSection.sectionTitle = "Miscellaneous"
        miscellaneousRowSection.dispatcher = self.dispatcher
        return miscellaneousRowSection
    }
    
    public func makeMathSection() -> BasicTableSectionController {
        let mathRowProps = AlgorithmSectionProperties.mathSectionProperties
        
        let mathRowSection = BasicTableSectionController()
        let mathRows = mathRowProps.map(BasicTableRowController.map)
        
        mathRowSection.rows = mathRows
        mathRowSection.sectionTitle = "Mathematics"
        mathRowSection.dispatcher = self.dispatcher
        return mathRowSection
    }
    
    public func makeMachineLearningSection() -> BasicTableSectionController {
        let machineLearningRowProps = AlgorithmSectionProperties.machineLearningSectionProperties
        
        let machineLearningRowSection = BasicTableSectionController()
        let machineLearningRows = machineLearningRowProps.map(BasicTableRowController.map)
        
        machineLearningRowSection.rows = machineLearningRows
        machineLearningRowSection.sectionTitle = "Machine Learning"
        machineLearningRowSection.dispatcher = self.dispatcher
        return machineLearningRowSection
    }
    
    func makeAboutSection() -> BasicTableSectionController {
        let rowController = JoinTheClubRowController()
        let controller = BasicTableSectionController()
        controller.rows = [rowController]
        return controller
    }
    
    func makeCatgorySideScrollerSection() -> CategoryRowTableSectionController {
        let section = CategoryRowTableSectionController()
        let items: [CategoryTileItemView.Properties] = [
            CategoryTileItemView.Properties(title: "Sorting", image: UIImage(named: "filter"), backgroundColor: .amethist(), category: .math),
            CategoryTileItemView.Properties(title: "Machine Learning", image: UIImage(named: "pcb"), backgroundColor: .coral(), category: .math),
            CategoryTileItemView.Properties(title: "Mathematics", image: UIImage(named: "math"), backgroundColor: .orangeCream(), category: .math),
            CategoryTileItemView.Properties(title: "Searching", image: UIImage(named: "search"), backgroundColor: .turquiose(), category: .math),
            CategoryTileItemView.Properties(title: "Compression", image: UIImage(named: "zip"), backgroundColor: .flatRed(), category: .math),
            ]
        
        section.properties = items
        return section
    }
}

extension AlgorithmPresenter: AlogrithmActionDispatching {
    func dispatch(_ action: AlgorithmViewController.Action) {
        switch action {
        default: dispatcher?.dispatch(action)
        }
    }
}
