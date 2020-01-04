//
//  PersonTableViewViewModel.swift
//  MVVMefc
//
//  Created by eduardo fulgencio on 04/01/2020.
//  Copyright © 2020 Eduardo Fulgencio Comendeiro. All rights reserved.
//

class PersonsTableViewViewModel {

    enum PersonTableViewCellType {
        case normal(cellViewModel: PersonCellViewModel)
        case error(message: String)
        case empty
    }

    var onShowError: ((_ alert: SingleButtonAlert) -> Void)?
    let showLoadingHud: Bindable = Bindable(false)

    let personCells = Bindable([PersonTableViewCellType]())
    let serverClient: ServicePersonClient

    init(serverClient: ServicePersonClient = ServicePersonClient()) {
        self.serverClient = serverClient
    }

    func getPersons() {
        showLoadingHud.value = true
        serverClient.getPersons(completion: { [weak self] result in
            self?.showLoadingHud.value = false
            switch result {
            case .success(let persons):
                guard persons.count > 0 else {
                    self?.personCells.value = [.empty]
                    return
                }
                self?.personCells.value = persons.compactMap { .normal(cellViewModel: $0 as PersonCellViewModel)}
            case .failure(let error):
                self?.personCells.value = [.error(message: error?.getErrorMessage() ?? "Loading failed, check network connection")]
            }
        })
    }

}

// MARK: - AppServerClient.GetFriendsFailureReason
fileprivate extension ServicePersonClient.GetPersonsFailureReason {
    func getErrorMessage() -> String? {
        switch self {
        case .unAuthorized:
            return "Please login to load your friends."
        case .notFound:
            return "Could not complete request, please try again."
        }
    }
}


