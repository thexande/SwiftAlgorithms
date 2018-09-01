import Foundation

final class AlgorithmSectionFactory {
    
    struct IdentifiableRowProperties {
        let properties: [BasicTableRowController.Properties]
        let identifiers: [UUID: AlgorithmPresentationAction]
    }
    
    struct IdentifiableSectionController {
        let seciton: TableSectionController
        let identifiers: [UUID: AlgorithmPresentationAction]
    }
    
    public func makeSection(for category: Algorithm.Category) -> IdentifiableSectionController? {
        switch category {
        case .gettingStarted:
            return makeGettingStartedSection()
        case .searching:
            return makeSearchingSection()
        case .stringSearch:
            return makeStringSearchSection()
        case .sorting:
            return nil
        case .compression:
            return makeCompressionSection()
        case .misc:
            return makeMiscellaneousSection()
        case .math:
            return makeMathematicsSection()
        case .machineLearning:
            return makeMachineLearningSection()
        }
    }
    
    public func makeSection(for sortingCategory: Algorithm.Sorting) -> IdentifiableSectionController {
        switch sortingCategory {
        case .basic:
            return makeBasicSortingSection()
        case .fast:
            return makeFastSortingSection()
        case .hybrid:
            return makeHybridSortingSection()
        case .specialPurpose:
            return makeSpecialPurposeSortingSection()
        case .bad:
            return makeBadSortingSection()
        }
    }
    
    public func makeAllSortingSections() -> [IdentifiableSectionController] {
        return Algorithm.Sorting.allCases.map(makeSection(for:))
    }
    
    private func makeIdentifiableProperties(for algorithms: [Algorithm]) -> IdentifiableRowProperties {
        
        var actionLookup: [UUID: AlgorithmPresentationAction] = [:]
        
        let identifiableProperties: [BasicTableRowController.Properties] = algorithms.map { algorithm in
            let identifier = UUID()
            let properties = BasicTableRowController.Properties(title: algorithm.title,
                                                                subtitle: algorithm.subtitle,
                                                                showsDisclosure: true,
                                                                identifier: identifier)
            actionLookup[identifier] = .selectedAlgorithm(algorithm)
            return properties
        }
        
        return IdentifiableRowProperties(properties: identifiableProperties,
                                         identifiers: actionLookup)
    }
    
    func makeSectionController(title: String,
                               subtitle: String?,
                               algorithms: [Algorithm]) -> IdentifiableSectionController {
        
        let sectionController = BasicTableSectionController()
        let identifiableProperties = makeIdentifiableProperties(for: algorithms)
        
        sectionController.rows = identifiableProperties.properties.map(BasicTableRowController.map)
        sectionController.sectionTitle = title
        sectionController.sectionSubtitle = subtitle
        
        return IdentifiableSectionController(seciton: sectionController,
                                             identifiers: identifiableProperties.identifiers)
    }
    
    public func makeGettingStartedSection() -> IdentifiableSectionController {
        
        let category = Algorithm.Category.gettingStarted
        return makeSectionController(title: category.title,
                                     subtitle: category.sectionSubtitle,
                                     algorithms: Algorithm.gettingStarted)
    }
    
    public func makeBasicSortingSection() -> IdentifiableSectionController {
        
        let category = Algorithm.Category.sorting
        return makeSectionController(title: category.title,
                                     subtitle: category.sectionSubtitle,
                                     algorithms: Algorithm.Sorting.basic.algorithms)
    }
    
    public func makeFastSortingSection() -> IdentifiableSectionController {
        
        let category = Algorithm.Sorting.fast
        return makeSectionController(title: category.title,
                                     subtitle: nil,
                                     algorithms: category.algorithms)
    }
    
    public func makeBadSortingSection() -> IdentifiableSectionController {
        
        let category = Algorithm.Sorting.bad
        return makeSectionController(title: category.title,
                                     subtitle: category.subtitle,
                                     algorithms: Algorithm.Sorting.bad.algorithms)
    }
    
    public func makeHybridSortingSection() -> IdentifiableSectionController {
        
        let category = Algorithm.Sorting.hybrid
        return makeSectionController(title: category.title,
                                     subtitle: nil,
                                     algorithms: category.algorithms)
    }
    
    public func makeSpecialPurposeSortingSection() -> IdentifiableSectionController {
        
        let category = Algorithm.Sorting.specialPurpose
        return makeSectionController(title: category.title,
                                     subtitle: nil,
                                     algorithms: category.algorithms)
    }
    
    public func makeSearchingSection() -> IdentifiableSectionController {
        
        let category = Algorithm.Category.searching
        return makeSectionController(title: category.title,
                                     subtitle: category.sectionSubtitle,
                                     algorithms: Algorithm.searching)
    }
    
    public func makeStringSearchSection() -> IdentifiableSectionController {
        
        let category = Algorithm.Category.stringSearch
        return makeSectionController(title: category.title,
                                     subtitle: category.sectionSubtitle,
                                     algorithms: Algorithm.stringSearch)
    }
    
    public func makeCompressionSection() -> IdentifiableSectionController {
        
        let category = Algorithm.Category.compression
        return makeSectionController(title: category.title,
                                     subtitle: category.sectionSubtitle,
                                     algorithms: Algorithm.compression)
    }
    
    public func makeMiscellaneousSection() -> IdentifiableSectionController {
        
        let category = Algorithm.Category.misc
        return makeSectionController(title: category.title,
                                     subtitle: category.sectionSubtitle,
                                     algorithms: Algorithm.miscellaneous)
    }
    
    public func makeMathematicsSection() -> IdentifiableSectionController {
        
        let category = Algorithm.Category.math
        return makeSectionController(title: category.title,
                                     subtitle: category.sectionSubtitle,
                                     algorithms: Algorithm.mathematics)
    }
    
    public func makeMachineLearningSection() -> IdentifiableSectionController {
        
        let category = Algorithm.Category.machineLearning
        return makeSectionController(title: category.title,
                                     subtitle: category.sectionSubtitle,
                                     algorithms: Algorithm.machineLearning)
    }
}
