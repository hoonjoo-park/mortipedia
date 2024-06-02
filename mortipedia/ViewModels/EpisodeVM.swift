//
//  EpisodeVM.swift
//  mortipedia
//
//  Created by Hoonjoo Park on 6/2/24.
//

import Foundation
import RxSwift

class EpisodeVM {
    static let shared = EpisodeVM()
    private let disposeBag = DisposeBag()
    
    private let episodesSubject = BehaviorSubject<[Episode?]>(value: [])
    var episodes: Observable<[Episode?]> {
        return episodesSubject.asObservable()
    }
    
    private let selectedEpisodeSubject = BehaviorSubject<Episode?>(value: nil)
    var selectedEpisode: Observable<Episode?> {
        return selectedEpisodeSubject.asObservable()
    }
    
    
    func getEpisodes() {
        NetworkManager.shared.fetchEpisodes().subscribe(onNext: { [weak self] response in
            guard let self = self else { return }
            
            self.episodesSubject.onNext(response)
        }).disposed(by: disposeBag)
    }
    
    
    func updateSelectedEpisode(id: Int) {
        guard let currentEpisodes = try? episodesSubject.value() else { return }
        
        if let targetIndex = currentEpisodes.firstIndex(where: { $0?.id == id }) {
            selectedEpisodeSubject.onNext(currentEpisodes[targetIndex])
        }
    }
}
