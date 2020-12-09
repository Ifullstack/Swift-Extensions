//
//  SearchBar.swift
//  recipe-app
//
//  Created by Cane on 28/08/2020.
//

import Foundation
import SwiftUI

struct SearchBar:UIViewRepresentable {
    
    @Binding var texto:String
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var texto:String
        init( texto:Binding<String> ) {
            _texto = texto
        }
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            texto = searchText
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(texto: $texto)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = texto
    }
    
    
}
