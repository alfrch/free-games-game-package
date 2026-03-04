//
//  GetListPresenter.swift
//  Game
//
//  Created by Alif Rachmawan on 02/03/26.
//

import Foundation
import Core
import Combine

public class GetListPresenter<
  Request,
    Response,
    GamesUseCase: UseCase,
    SearchUseCase: UseCase
>: ObservableObject where
GamesUseCase.Request == Request,
GamesUseCase.Response == [Response],
SearchUseCase.Request == String,
SearchUseCase.Response == [Response] {
  
  private var cancellables: Set<AnyCancellable> = []
  private let gamesUseCase: GamesUseCase
  private let searchUseCase: SearchUseCase
  
  @Published public var list: [Response] = []
  @Published public var allList: [Response] = []
  @Published public var errorMesasage: String?
  @Published public var isLoading = false
  @Published public var isError = false
  @Published public var searchText = ""
  
  public init(gamesUseCase: GamesUseCase, searchUseCase: SearchUseCase) {
    self.gamesUseCase = gamesUseCase
    self.searchUseCase = searchUseCase
    setupSearchBinding()
  }
  
  private func setupSearchBinding() {
    $searchText
      .debounce(for: .milliseconds(350), scheduler: RunLoop.main)
      .removeDuplicates()
      .map { [weak self] keyword -> AnyPublisher<[Response], Never> in
        guard let self = self else {
          return Just([])
            .eraseToAnyPublisher()
        }
        
        if keyword.isEmpty {
          return Just(self.allList)
            .eraseToAnyPublisher()
        }
        
        return self.searchUseCase.execute(request: keyword)
          .replaceError(with: [])
          .eraseToAnyPublisher()
      }
      .switchToLatest()
      .receive(on: RunLoop.main)
      .assign(to: &$list)
  }
  
  public func getList(request: Request?) {
    isLoading = true
    gamesUseCase.execute(request: request)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { [weak self] completion in
        guard let self else { return }
        self.isLoading = false
        
        switch completion {
        case .failure(let error):
          self.errorMesasage = error.localizedDescription
          self.isError = true
        case .finished: break
        }
      }, receiveValue: { [weak self] list in
        guard let self else { return }
        self.allList = list
        self.list = list
      })
      .store(in: &cancellables)
  }
  
}
