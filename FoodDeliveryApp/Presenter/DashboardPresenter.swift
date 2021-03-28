//
//  DashboardPresenter.swift
//  FoodDeliveryApp
//
//  Created by Nitin Agnihotri on 28/03/21.
//  
//

import Foundation

class DashboardPresenter: ViewToPresenterDashboardProtocol {

    // MARK: Properties
    var view: PresenterToViewDashboardProtocol?
    var interactor: PresenterToInteractorDashboardProtocol?
    var router: PresenterToRouterDashboardProtocol?
}

extension DashboardPresenter: InteractorToPresenterDashboardProtocol {
    
}
