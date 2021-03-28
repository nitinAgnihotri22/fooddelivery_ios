//
//  DashboardRouter.swift
//  FoodDeliveryApp
//
//  Created by Nitin Agnihotri on 28/03/21.
//  
//

import Foundation
import UIKit

class DashboardRouter: PresenterToRouterDashboardProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = DashboardViewController()
        
        let presenter: ViewToPresenterDashboardProtocol & InteractorToPresenterDashboardProtocol = DashboardPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = DashboardRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = DashboardInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
