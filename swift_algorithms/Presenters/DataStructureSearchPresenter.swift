import UIKit
import SwiftAlgorithmsDataLayer

protocol DataStructureSearchPresenterDispatching: AnyObject {
    func dispatch(_ action: DataStructureSearchPresenter.Action)
}

final class DataStructureSearchPresenter {
    
    enum Action {
        case selectedDataStructure(DataStructure)
    }
    
    weak var dispatcher: DataStructureSearchPresenterDispatching?
    
    var actionLookup: [UUID: Action] = [:]
    
    var dataStructures: [DataStructure] = []
    
    var deliver: (([SearchResultsTableViewController.Properties]) -> Void)?
    
    var searchedProperties: [SearchResultsTableViewController.Properties] = [] {
        didSet {
            deliver?(searchedProperties)
        }
    }
    
    func makeSearchableDataStructureProperties() {
        let allDataStructureProperties = DataStructure.allCases
        dataStructures = allDataStructureProperties
        searchedProperties = makeCategorySections(for: dataStructures)
    }
    
    private func makeCategorySections(for dataStructures: [DataStructure]) -> [SearchResultsTableViewController.Properties] {
        // reset action hash map
        actionLookup = [:]
        
        let categories = DataStructure.Category.allCases
        
        let categoryProps: [SearchResultsTableViewController.Properties] = categories.compactMap { category in
            
            let categoryDataStructures = dataStructures.filter { dataStructure in
                
                let dataStructureCategory = DataStructure.category(for: dataStructure)
                guard dataStructureCategory == category else {
                        return false
                }
                
                return true
            }
            
            let categoryDataStructureRowProps = categoryDataStructures.map(makeIdentifiableAction(for:))
            
            let props = SearchResultsTableViewController.Properties(sectionTitle: category.title,
                                                                    rows: categoryDataStructureRowProps)
            
            guard categoryDataStructureRowProps.count > 0 else {
                return nil
            }
            
            return props
        }
        
        return categoryProps
    }
    
    private func makeIdentifiableAction(for dataStructure: DataStructure) -> SearchResultsRowController.Properties {
        let identifier = UUID()
        let prop = SearchResultsRowController.Properties(title: dataStructure.title,
                                                         indicatorColor: (dataStructure.category?.color ?? .black),
                                                         identifier: identifier)
        
        actionLookup[identifier] = .selectedDataStructure(dataStructure)
        return prop
    }
    
    private func handleSearch(_ term: String) {
        
        if term == "" {
            let all = makeCategorySections(for: dataStructures)
            searchedProperties = all
            return
        }
        
        let searchedDataStructures = dataStructures.filter { dataStructure in
            return "\(dataStructure.title)\(dataStructure.subtitle ?? "")".contains(term)
        }
        
        searchedProperties = makeCategorySections(for: searchedDataStructures)
    }
    
    private func handleSelected(with identifier: UUID) {
        guard let action = actionLookup[identifier] else {
            return
        }
        
        dispatcher?.dispatch(action)
    }
}


extension DataStructureSearchPresenter: SearchActionDispatching {
    func dispatch(_ action: SearchResultsTableViewController.Action) {
        switch action {
        case let .searchedTerm(term):
            handleSearch(term)
        case let .selectedTerm(identifier):
            handleSelected(with: identifier)
        }
    }
}
