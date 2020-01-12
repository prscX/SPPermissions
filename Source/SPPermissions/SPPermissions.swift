// The MIT License (MIT)
// Copyright © 2019 Ivan Vorobei (ivanvorobei@icloud.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

@objc public class SPPermissionBridge: NSObject {
    @objc public static func show(from: UIViewController, type: String, permissions: Array<String>) {
        var selectedPermissions: [SPPermission] = []

        for permission in permissions {
            if permission == "Camera" {
                selectedPermissions.append(.camera)
            } else if permission == "Contacts" {
                selectedPermissions.append(.contacts)
            } else if permission == "Calendar" {
                selectedPermissions.append(.calendar)
            } else if permission == "PhotoLibrary" {
                selectedPermissions.append(.photoLibrary)
            } else if permission == "Notification" {
                selectedPermissions.append(.notification)
            } else if permission == "Microphone" {
                selectedPermissions.append(.microphone)
            } else if permission == "Reminders" {
                selectedPermissions.append(.reminders)
            } else if permission == "SpeechRecognizer" {
                selectedPermissions.append(.speech)
            } else if permission == "Location" {
                selectedPermissions.append(.locationAlwaysAndWhenInUse)
            } else if permission == "Motion" {
                selectedPermissions.append(.motion)
            } else if permission == "MediaLibrary" {
                selectedPermissions.append(.mediaLibrary)
            } else if permission == "Bluetooth" {
                selectedPermissions.append(.bluetooth)
            }
        }
        
        let controller = SPPermissions.dialog(selectedPermissions)
        controller.present(on: from)
    }
}

public enum SPPermissions {
    
    /**
     Request all permissions by each and with native dialog. Force mode. Show alert if permission denied.
     
     - parameter permissions: List of permissions for request.
     */
    public static func native(_ permissions: [SPPermission]) -> SPPermissionsNativeController {
        let controller = SPPermissionsNativeController(removeDublicates(permissions))
        return controller
    }
    
    #if os(iOS)
    /**
     Request permissions as list in modal controller. In iPad open as `formSheet`.
     
     - warning: Not present it from parent controller method. Use in class method `present(on:)`.
     - parameter permissions: List of permissions for request.
     - returns: Controller for configure texts. Ready for present.
     */
    public static func list(_ permissions: [SPPermission]) -> SPPermissionsListController {
        let controller = SPPermissionsListController(removeDublicates(permissions))
        return controller
    }

    /**
     Request permissions as dialog. Available swipe-down for dismiss.
     
     - warning: Not present it from parent controller method. Use in class method `present(on:)`.
     - parameter permissions: List of permissions for request.
     - returns: Controller for configure data. Ready for present.
     */
    public static func dialog(_ permissions: [SPPermission]) -> SPPermissionsDialogController {
        let controller = SPPermissionsDialogController(removeDublicates(permissions))
        return controller
    }
    #endif
    
    /**
     Remove dublicates permissions if added as mistake.
     
     - parameter permissions: List permissions for uniquary.
     */
    private static func removeDublicates(_ permissions: [SPPermission]) -> [SPPermission] {
        var result = [SPPermission]()
        for permission in permissions {
            if !result.contains(permission) { result.append(permission) }
        }
        return result
    }
}
