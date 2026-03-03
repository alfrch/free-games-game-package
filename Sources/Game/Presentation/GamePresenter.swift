//
//  GamePresenter.swift
//  Game
//
//  Created by Alif Rachmawan on 03/03/26.
//

import Foundation
import Combine
import Core

public class GamePresenter<
  GameUseCase: UseCase,
  FavoriteUseCase: UseCase
>: ObservableObject where
GameUseCase.Request == String,
GameUseCase.Response == GameModel,
FavoriteUseCase.Request == String,
FavoriteUseCase.Response == GameModel {
  
  @Published public var item: GameModel?
  @Published public var isLoading = false
  @Published public var errorMessage: String?
  
  private let gameUseCase: GameUseCase
  
  private var cancellables = Set<AnyCancellable>()
  
  public init(gameUseCase: GameUseCase) {
    self.gameUseCase = gameUseCase
  }
  
  public func getGame(request: GameUseCase.Request) {
    isLoading = true
    defer { isLoading = false }
    
    gameUseCase.execute(request: request)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { [weak self] completion in
        guard let self else { return }
        switch completion {
        case .finished: break
        case .failure(let error):
          self.errorMessage = error.localizedDescription
        }
      }, receiveValue: { [weak self] item in
        guard let self else { return }
        self.item = item
      })
      .store(in: &cancellables)
  }
}
