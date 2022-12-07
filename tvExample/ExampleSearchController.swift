//
//  ExampleSearchController.swift
//  tvExample
//
//  Created by Kurniadi on 5/12/22.
//

import UIKit

class SuggestedEntry: NSObject, UISearchSuggestion {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? SuggestedEntry {
            return object.name == name
        }
        
        return false
    }
    
    var localizedSuggestion: String? {
        return name
    }
    
    var iconImage: UIImage? {
        return nil
    }
    
    var representedObject: Any?
    
    
}

class ExampleSearchController: UIViewController {

    
    private var searchController: UISearchController!
    private var searchControllerContainer: UISearchContainerViewController!
    private var searchGridControlelr: SearchResultCollectionViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        self.searchGridControlelr = (storyboard.instantiateViewController(withIdentifier: "SearchResultCollectionViewController") as! SearchResultCollectionViewController)
      
        self.searchController = UISearchController(searchResultsController: searchGridControlelr)
        
        self.searchController.searchBar.scopeButtonTitles = ["One", "Two"]
        self.searchController.searchBar.showsScopeBar = true
       
        self.searchControllerContainer = UISearchContainerViewController(searchController: searchController)
        addChild(searchControllerContainer)
        searchControllerContainer.view.frame = view.bounds
        
        view.addSubview(searchControllerContainer.view)
        searchControllerContainer.didMove(toParent: self)
        
        searchController.searchResultsUpdater = self
                
        if #available(tvOS 15.0, *) {
            self.searchController.setContentScrollView(searchGridControlelr.collectionView, for: .all)
        } else {
            self.searchController.searchControllerObservedScrollView = searchGridControlelr.collectionView
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ExampleSearchController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        print(">>> selecte scope \(selectedScope)")
    }
}

extension ExampleSearchController: UISearchResultsUpdating {
    @available(tvOS 14.0, *)
    func updateSearchResults(for searchController: UISearchController, selecting searchSuggestion: UISearchSuggestion) {
        print(">>> kepanggil sih")
    }
    func updateSearchResults(for searchController: UISearchController) {
        if let search = searchController.searchBar.text,
           !search.isEmpty
        {
            let suggestedEntry = AppData.allWords
                .map ({ $0.lowercased() })
                .filter { $0.contains(search.lowercased()) }
                .map { SuggestedEntry(name: $0) }
            
            searchGridControlelr.updateResult(contens: AppData.all().filter { $0.title.lowercased().contains(search.lowercased())})
            if #available(tvOS 14.0, *) {
                searchController.searchSuggestions = suggestedEntry
            } else {
                // Fallback on earlier versions
            }
        } else {
            searchGridControlelr.updateResult(contens: AppData.all())
            if #available(tvOS 14.0, *) {
                let suggestedEntry = AppData.allWords
                    .map { SuggestedEntry(name: $0) }
                searchController.searchSuggestions = suggestedEntry
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
