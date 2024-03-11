//
//  SimulatorDataParserProtocol.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 11/03/2024.
//

import Foundation

protocol SimulatorDataParserProtocol {
    
    func parsedSimulators(from input: String) -> [Simulator]
}
