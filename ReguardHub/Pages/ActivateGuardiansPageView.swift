//
//  ActivateGuardiansView.swift
//  ReguardHub
//
//  Created by Timothy Tong on 1/17/21.
//

import SwiftUI

private struct ActivateGuardianPageBtn {
    static let Confirm = "Confirm"
}

struct ActivateGuardiansPageView: View {
    @EnvironmentObject var guardianManager: GuardianManager
    @EnvironmentObject var appState: AppState
    @State var btnSelection: String? = nil
    @State private var guardianControlChange = GuardianControlChange()
    @State private var showConfirmation = false
    
    private func confirmGuardianControlChanges() {
        let userId = "user" // TODO: Update when user system is ready
        let deviceIdsToActivate = guardianControlChange.devicesToArm.map { device in
            device.id
        }
        let deviceIdsToDeactivate = guardianControlChange.devicesToDisarm.map { device in
            device.id
        }
        guardianManager.startSessionForDevices(userId: userId, deviceIds: deviceIdsToActivate)
        guardianManager.endSessionForDevices(userId: userId, deviceIds: deviceIdsToDeactivate)
        appState.reloadHome()
    }
    
    func updateGuardianControlChange(device: Device, isChecked: Bool) {
        if (device.status == "GUARDING") {
            if (!isChecked) {
                guardianControlChange.devicesToDisarm.insert(device)
            } else {
                guardianControlChange.devicesToDisarm.remove(device)
            }
        } else {
            if (isChecked) {
                guardianControlChange.devicesToArm.insert(device)
            } else {
                guardianControlChange.devicesToArm.remove(device)
            }
        }
    }
    
    var body: some View {
        ZStack {
            List(guardianManager.devices) { device in
                DeviceStatusRow(device: device, isOnCheckList: true, onStatusChange: updateGuardianControlChange(device:isChecked:))
            }.navigationTitle("Activate")
            if (!guardianControlChange.devicesToArm.isEmpty || !guardianControlChange.devicesToDisarm.isEmpty) {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            self.showConfirmation = true
                        }, label: {
                            Image(systemName: "checkmark")
                                .font(.system(.largeTitle))
                                .frame(width: 77, height: 76)
                                .foregroundColor(Color.white)
                                .padding(.bottom, 1)
                        })
                        .background(Color.black)
                        .cornerRadius(38.5)
                        .padding()
                        .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 3, y: 3)
                        .overlay(Circle().inset(by: 16).stroke(Color.white, lineWidth: 1))
                        .alert(isPresented: $showConfirmation, content: {
                                Alert(title: Text("Confirm Guardians"),
                                      message: Text("Confirm changes to guardian devices?"),
                                      primaryButton: .default(Text("OK"), action: { self.confirmGuardianControlChanges() }),
                                      secondaryButton: .cancel())})
                    }
                }
            }
        }
    }
}

struct ActivateGuardiansView_Previews: PreviewProvider {
    static var previews: some View {
        ActivateGuardiansPageView().environmentObject(GuardianManager())
    }
}
