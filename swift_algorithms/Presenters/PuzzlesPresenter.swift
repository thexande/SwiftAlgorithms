import UIKit

protocol PuzzlePresenterActionDispatching: AnyObject {
    func dispatch(_ action: PuzzlesPresenter.Action)
}

final class PuzzlesPresenter {
    
    enum Action {
        case selectPuzzle(Puzzle)
    }
    
    var actionLookup: [UUID: Action] = [:]
    
    weak var dispatcher: PuzzlePresenterActionDispatching?
    
    func makePuzzleSection() -> BasicTableSectionController {
        
        let section = BasicTableSectionController()
        let puzzles = Array(Puzzle.allCases)
        
        let rows: [RowController] = puzzles.map { puzzle in
            
            let identifier = UUID()
            let controller = BasicTableRowController()
            
            actionLookup[identifier] = .selectPuzzle(puzzle)
            
            let properties = BasicTableRowController.Properties(title: puzzle.title,
                                                                subtitle: puzzle.subtitle,
                                                                showsDisclosure: true,
                                                                identifier: identifier)
            controller.properties = properties
            return controller
        }
        
        section.rows = rows
        section.sectionSubtitle = Puzzle.detailInfo
        
        return section
    }
}

extension PuzzlesPresenter: PuzzlesViewActionDispatching {
    func dispatch(_ action: PuzzlesViewController.Action) {
        switch action {
        case let .selectedItem(identifier):
            
            guard let action = actionLookup[identifier] else {
                return
            }
            
            dispatcher?.dispatch(action)
        }
    }
}

