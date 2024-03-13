//
//  DeeplinkParamListView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 12/03/2024.
//

import SwiftUI

struct DeeplinkParamListView: View {
    
    let params: [DeeplinkParamEntity]
    var onDataSourceChanged: ([DeeplinkParamEntity]) -> Void
    var onRemovingParam: (Int) -> Void
    var onAddingNewParam: (Int) -> Void
    
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
                                params[index].key = newKey
                                onDataSourceChanged(params)
                            },
                            onValueChanged: { newValue in
                                params[index].value = newValue
                                onDataSourceChanged(params)
                            },
                            onRemoving: {                              
                                if param.key.isEmpty {
                                    onRemovingParam(index)
                                } else {
                                    removingParamIndex = index
                                    isRemovingAlertPresented = true
                                }
                            },
                            onAdding: {
                                onAddingNewParam(index)
                            }
                        )
                    }
                }
                .padding(.leading, .dimensionSpace12)
            }
            .alert("Confirm for removing the param", isPresented: $isRemovingAlertPresented) {
                Button("Confirm") {
                    if let removingParamIndex {
                        onRemovingParam(removingParamIndex)
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
        params: params,
        onDataSourceChanged: {
            params = $0
        },
        onRemovingParam: { index in
        },
        onAddingNewParam: { index in
        }
    )
}
