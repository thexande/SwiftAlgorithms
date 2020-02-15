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
    
    public func makeSection(for category: AlgorithmCategory) -> IdentifiableSectionController? {
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
    
    public func makeSections(for category: AlgorithmCategory) -> [IdentifiableSectionController] {
        switch category {
        case .gettingStarted:
            return [makeGettingStartedSection()]
        case .searching:
            return [makeSearchingSection()]
        case .stringSearch:
            return [makeStringSearchSection()]
        case .sorting:
            return makeAllSortingSections()
        case .compression:
            return [makeCompressionSection()]
        case .misc:
            return [makeMiscellaneousSection()]
        case .math:
            return [makeMathematicsSection()]
        case .machineLearning:
            return [makeMachineLearningSection()]
        }
    }
    
    public func makeSection(for sortingCategory: SortingLevel) -> IdentifiableSectionController {
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
        return SortingLevel.allCases.map(makeSection(for:))
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
        
        let category = AlgorithmCategory.gettingStarted
        return makeSectionController(title: category.title,
                                     subtitle: category.sectionSubtitle,
                                     algorithms: GettingStartedAlgorithm.allCases)
    }
    
    public func makeBasicSortingSection() -> IdentifiableSectionController {
        
        let category = AlgorithmCategory.sorting
        return makeSectionController(title: category.title,
                                     subtitle: category.sectionSubtitle,
                                     algorithms: SortingLevel.basic.algorithms)
    }
    
    public func makeFastSortingSection() -> IdentifiableSectionController {
        
        let category = SortingLevel.fast
        return makeSectionController(title: category.title,
                                     subtitle: nil,
                                     algorithms: category.algorithms)
    }
    
    public func makeBadSortingSection() -> IdentifiableSectionController {
        
        let category = SortingLevel.bad
        return makeSectionController(title: category.title,
                                     subtitle: category.subtitle,
                                     algorithms: SortingLevel.bad.algorithms)
    }
    
    public func makeHybridSortingSection() -> IdentifiableSectionController {
        
        let category = SortingLevel.hybrid
        return makeSectionController(title: category.title,
                                     subtitle: nil,
                                     algorithms: category.algorithms)
    }
    
    public func makeSpecialPurposeSortingSection() -> IdentifiableSectionController {
        
        let category = SortingLevel.specialPurpose
        return makeSectionController(title: category.title,
                                     subtitle: nil,
                                     algorithms: category.algorithms)
    }
    
    public func makeSearchingSection() -> IdentifiableSectionController {
        
        let category = AlgorithmCategory.searching
        return makeSectionController(title: category.title,
                                     subtitle: category.sectionSubtitle,
                                     algorithms: SearchingAlgorithm.allCases)
    }
    
    public func makeStringSearchSection() -> IdentifiableSectionController {
        
        let category = AlgorithmCategory.stringSearch
        return makeSectionController(title: category.title,
                                     subtitle: category.sectionSubtitle,
                                     algorithms: StringSearchAlgorithm.allCases)
    }
    
    public func makeCompressionSection() -> IdentifiableSectionController {
        
        let category = AlgorithmCategory.compression
        return makeSectionController(title: category.title,
                                     subtitle: category.sectionSubtitle,
                                     algorithms: CompressionAlgorithm.allCases)
    }
    
    public func makeMiscellaneousSection() -> IdentifiableSectionController {
        
        let category = AlgorithmCategory.misc
        return makeSectionController(title: category.title,
                                     subtitle: category.sectionSubtitle,
                                     algorithms: MiscAlgorithm.allCases)
    }
    
    public func makeMathematicsSection() -> IdentifiableSectionController {
        
        let category = AlgorithmCategory.math
        return makeSectionController(title: category.title,
                                     subtitle: category.sectionSubtitle,
                                     algorithms: MathematicsAlgorithm.allCases)
    }
    
    public func makeMachineLearningSection() -> IdentifiableSectionController {
        
        let category = AlgorithmCategory.machineLearning
        return makeSectionController(title: category.title,
                                     subtitle: category.sectionSubtitle,
                                     algorithms: MachineLearningAlgorithm.allCases)
    }
}
