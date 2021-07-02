//
//  GenreViewModel.swift
//  TheMoviesDb
//
//  Created by Jennifer Ruiz on 26/06/21.
//

import UIKit

struct GenreViewViewModel {
    
    private var genre: Genre
    
    init(genre: Genre) {
        self.genre = genre
    }
    
    var title: String {
        return genre.name
    }
    
}
