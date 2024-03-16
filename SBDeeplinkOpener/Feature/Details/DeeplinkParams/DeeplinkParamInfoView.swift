//
//  DeeplinkParamInfoView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 12/03/2024.
//

import SwiftUI

struct DeeplinkParamInfoView: View {
    
    @State var key: String
    @State var value: String
    
    var onKeyChanged: ((String) -> Void)?
    var onValueChanged: ((String) -> Void)?
    var onRemoving: VoidCallBack?
    var onAdding: VoidCallBack?
    
    init(
        key: String,
        value: String,
        onKeyChanged: ((String) -> Void)? = nil,
        onValueChanged: ((String) -> Void)? = nil,
        onRemoving: VoidCallBack? = nil,
        onAdding: VoidCallBack? = nil
    ) {
        self._key = State(wrappedValue: key)
        self._value = State(wrappedValue: value)
        self.onKeyChanged = onKeyChanged
        self.onValueChanged = onValueChanged
        self.onRemoving = onRemoving
        self.onAdding = onAdding
    }
    
    var body: some View {
        
        HStack {
            TextField("Param", text: $key)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.white))
            TextField("Value", text: $value)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color.white))
            Spacer()
            
            HStack {
                    Asset.delete.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: DSIconSize.medium, height: DSIconSize.medium)
                        .clipped()
                        .onTapGesture {
                            onRemoving?()
                        }
                    
                    Asset.plus.swiftUIImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: DSIconSize.medium, height: DSIconSize.medium)
                        .clipped()
                        .onTapGesture {
                            onAdding?()
                        }
                
            }
        }
        .padding(.leading, .dimensionSpace4)
        .padding(.vertical, .dimensionSpace1)
        .onChange(of: key) { oldValue, newValue in
            onKeyChanged?(newValue)
        }
        .onChange(of: value) { oldValue, newValue in
            onValueChanged?(newValue)
        }
    }
}

#Preview {
    DeeplinkParamInfoView(
        key: "Code", value: "Value"
    )
}
