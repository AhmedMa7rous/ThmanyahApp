//
//  HomeAPIResponseDTO.swift
//  ThmanyahApp
//
//  Created by Ahmed Mahrous on 17/08/2025.
//

import Foundation

struct HomeSectionsResponseDTO: Codable {
    let sections: [SectionDTO]
    let pagination: PaginationDTO
}
