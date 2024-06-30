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
    
    private var nextEpisodePageUrl: String? = nil
    
    private let selectedEpisodeSubject = BehaviorSubject<Episode?>(value: nil)
    var selectedEpisode: Observable<Episode?> {
        return selectedEpisodeSubject.asObservable()
    }
    
    private let isLoadingSubject = BehaviorSubject<Bool>(value: true)
    var isLoading: Observable<Bool> {
        return isLoadingSubject.asObservable()
    }
    
    
    func getEpisodes() {
        
        NetworkManager.shared.fetchEpisodes().subscribe(onNext: { [weak self] response in
            guard let self = self, let response = response else { return }

            isLoadingSubject.onNext(true)
            
            self.episodesSubject.onNext(response.results)
            
            if response.info.next != nil {
                nextEpisodePageUrl = response.info.next
            } else {
                nextEpisodePageUrl = nil
            }
            
            isLoadingSubject.onNext(false)
        }).disposed(by: disposeBag)
    }
    
    
    func getNextEpisodes() {
        guard let nextEpisodePageUrl = nextEpisodePageUrl else { return }
        
        isLoadingSubject.onNext(true)
        
        NetworkManager.shared.fetchEpisodesNextPage(nextEpisodePageUrl).subscribe(onNext: { [weak self] response in
            guard let self = self, let response = response else { return }
            let currentEpisodes = try? self.episodesSubject.value()
            
            self.episodesSubject.onNext((currentEpisodes ?? []) + response.results)
            
            if response.info.next != nil {
                self.nextEpisodePageUrl = response.info.next
            } else {
                self.nextEpisodePageUrl = nil
            }
            
            isLoadingSubject.onNext(false)
        }).disposed(by: disposeBag)
    }
    
    
    func updateSelectedEpisode(id: Int) {
        guard let currentEpisodes = try? episodesSubject.value() else { return }
        
        if let targetIndex = currentEpisodes.firstIndex(where: { $0?.id == id }) {
            selectedEpisodeSubject.onNext(currentEpisodes[targetIndex])
        }
    }
}
