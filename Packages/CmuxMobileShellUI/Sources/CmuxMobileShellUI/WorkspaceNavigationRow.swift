import CmuxMobileShellModel
import SwiftUI

struct WorkspaceNavigationRow: View {
    let workspace: MobileWorkspacePreview
    let connectionStatus: MobileMacConnectionStatus
    let isSelected: Bool
    let navigationStyle: WorkspaceNavigationStyle
    let wrapWorkspaceTitles: Bool
    let selectWorkspace: (MobileWorkspacePreview.ID) -> Void

    var body: some View {
        Group {
            switch navigationStyle {
            case .push:
                NavigationLink(value: workspace.id) {
                    WorkspaceRow(
                        workspace: workspace,
                        connectionStatus: connectionStatus,
                        isSelected: false,
                        wrapWorkspaceTitles: wrapWorkspaceTitles
                    )
                }
                .simultaneousGesture(TapGesture().onEnded {
                    selectWorkspace(workspace.id)
                })
            case .sidebar:
                Button {
                    selectWorkspace(workspace.id)
                } label: {
                    WorkspaceRow(
                        workspace: workspace,
                        connectionStatus: connectionStatus,
                        isSelected: isSelected,
                        wrapWorkspaceTitles: wrapWorkspaceTitles
                    )
                }
                .buttonStyle(.plain)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isButton)
        .accessibilityIdentifier("MobileWorkspaceRow-\(workspace.id.rawValue)")
        .accessibilityLabel(workspace.name)
        .accessibilityValue(workspace.accessibilitySummary(connectionStatus: connectionStatus))
    }
}
