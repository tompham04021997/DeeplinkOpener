//
//  AppContainer.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 16/03/2024.
//

import Foundation
import Factory

extension Container {
    
    var treeDataManager: Factory<TreeDataManager> {
        self {
            TreeDataManager()
        }
        .scope(.singleton)
    }
    
    var dataStorageService: Factory<DeeplinkDataStorageServiceProtocol> {
        self {
            LocalDataStorageService()
        }
        .scope(.unique)
    }
    
    var deeplinkParser: Factory<DeeplinkParserProtocol> {
        self {
            DeeplinkParser()
        }
        .scope(.cached)
    }
    
    var deeplinkCombiner: Factory<DeeplinkCombinerProtocol> {
        self {
            DeeplinkCombiner()
        }
        .scope(.cached)
    }
    
    var simulatorManager: Factory<SimulatorManagerProtocol> {
        self {
            SimulatorManager()
        }
        .scope(.shared)
    }
    
    var simulatorDataParser: Factory<SimulatorDataParserProtocol> {
        self {
            SimulatorDataParser()
        }
        .scope(.shared)
    }
    
    var deeplinkOpener: Factory<DeeplinkOpenerProtocol> {
        self {
            AppDeeplinkOpener()
        }
        .scope(.shared)
    }
    
    var treeItemViewFactory: Factory<any DeeplinkTreeItemViewFactoryProtocol> {
        self {
            DeeplinkTreeItemViewFactory()
        }
        .scope(.shared)
    }
}
