import Foundation
import SwiftAlgorithmsDataLayer

final class DataStructureSectionFactory {
    
    struct IdentifiableSectionController {
        let seciton: TableSectionController
        let identifiers: [UUID: DataStructurePresenter.Action]
    }
    
    struct IdentifiableRowProperties {
        let properties: [BasicTableRowController.Properties]
        let identifiers: [UUID: DataStructurePresenter.Action]
    }
    
    private func makeSectionController(title: String,
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
    
    public func makeDataStructureSection(for category: DataStructure.Category) -> IdentifiableSectionController {
        return makeSectionController(title: category.title,
                                     footerText: category.footerText,
                                     dataStructures: category.dataStructures)
    }
    
    public func makeAllDataStructureSections() -> [IdentifiableSectionController] {
        let allDataStructureCategories = DataStructure.Category.allCases
        
        return allDataStructureCategories.map { category in
            let section = makeSectionController(title: category.title,
                                                footerText: category.footerText,
                                                dataStructures: category.dataStructures)
            return section
        }
    }
}
