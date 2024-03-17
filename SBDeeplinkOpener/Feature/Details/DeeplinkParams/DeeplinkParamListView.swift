//
//  DeeplinkParamListView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 12/03/2024.
//

import SwiftUI

struct DeeplinkParamListView: View {
    
    @Binding var params: [DeeplinkParamEntity]
    
    @State var isRemovingAlertPresented = false
    @State var removingParamIndex: Int?
    
    var body: some View {
        if !params.isEmpty {
            VStack(alignment: .leading) {
                
                HStack {
                    Text("Parameters:")
                    Spacer()
                }
                
                VStack {
                    ForEach(Array(params.enumerated()), id: \.element.id) { index, param in
                        DeeplinkParamInfoView(
                            key: param.key,
                            value: param.value,
                            onKeyChanged: { newKey in
                                var updatingParams = params
                                updatingParams[index].setKey(newKey)
                                params = updatingParams
                            },
                            onValueChanged: { newValue in
                                var updatingParams = params
                                updatingParams[index].setValue(newValue)
                                params = updatingParams
                            },
                            onRemoving: {                              
                                if param.key.isEmpty {
                                    if params.count <= 1 {
                                        params = [.empty()]
                                    } else {
                                        params.remove(at: index)
                                    }
                                } else {
                                    removingParamIndex = index
                                    isRemovingAlertPresented = true
                                }
                            },
                            onAdding: {
                                params.append(.empty())
                            }
                        )
                    }
                }
                .padding(.leading, .dimensionSpace12)
            }
            .alert("Confirm for removing the param", isPresented: $isRemovingAlertPresented) {
                Button("Confirm") {
                    if let removingParamIndex {
                        params.remove(at: removingParamIndex)
                    }
                }
                
                Button("Cancel") {
                    isRemovingAlertPresented = false
                }
            } message: {
                Text("By click Confirm, this param will be removed from your deeplink")
                    .font(.bodyS)
                    .foregroundStyle(Color.white)
            }
        }
    }
}

#Preview {
    
    @State var params = [
        DeeplinkParamEntity(key: "1", value: "2")
    ]
    return DeeplinkParamListView(
        params: $params
    )
}
