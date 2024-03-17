// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Common {
    internal enum Action {
      /// Copy
      internal static let copy = L10n.tr("Localizable", "common.action.copy", fallback: "Copy")
      /// Create
      internal static let create = L10n.tr("Localizable", "common.action.create", fallback: "Create")
      /// Import
      internal static let `import` = L10n.tr("Localizable", "common.action.import", fallback: "Import")
      /// OK
      internal static let ok = L10n.tr("Localizable", "common.action.ok", fallback: "OK")
      /// Open
      internal static let `open` = L10n.tr("Localizable", "common.action.open", fallback: "Open")
      /// Remove
      internal static let remove = L10n.tr("Localizable", "common.action.remove", fallback: "Remove")
      /// Rename
      internal static let rename = L10n.tr("Localizable", "common.action.rename", fallback: "Rename")
      /// Save
      internal static let save = L10n.tr("Localizable", "common.action.save", fallback: "Save")
    }
    internal enum Alert {
      internal enum Copy {
        /// The text has been copied to the clipboard.
        internal static let message = L10n.tr("Localizable", "common.alert.copy.message", fallback: "The text has been copied to the clipboard.")
        /// Copied
        internal static let title = L10n.tr("Localizable", "common.alert.copy.title", fallback: "Copied")
      }
    }
    internal enum Directory {
      internal enum `Type` {
        /// Deeplink
        internal static let deeplinkFile = L10n.tr("Localizable", "common.directory.type.deeplinkFile", fallback: "Deeplink")
        /// Folder
        internal static let folder = L10n.tr("Localizable", "common.directory.type.folder", fallback: "Folder")
      }
    }
  }
  internal enum Details {
    internal enum EmptyState {
      /// Please select the deeplink for customization and perform
      internal static let message = L10n.tr("Localizable", "details.emptyState.message", fallback: "Please select the deeplink for customization and perform")
      /// Localizable.strings
      ///   SBDeeplinkOpener
      /// 
      ///   Created by Tuan Pham on 16/03/2024.
      internal static let title = L10n.tr("Localizable", "details.emptyState.title", fallback: "You have't select any deeplink for opening")
    }
    internal enum Fields {
      /// Deeplink
      internal static let deeplink = L10n.tr("Localizable", "details.fields.deeplink", fallback: "Deeplink")
      /// Parameters
      internal static let parameters = L10n.tr("Localizable", "details.fields.parameters", fallback: "Parameters")
      /// Path
      internal static let path = L10n.tr("Localizable", "details.fields.path", fallback: "Path")
      /// Schema
      internal static let schema = L10n.tr("Localizable", "details.fields.schema", fallback: "Schema")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
