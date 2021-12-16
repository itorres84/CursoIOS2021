//
//  AppDelegate.swift
//  APNSTest
//
//  Created by Isrrael Torres Alvarado on 14/12/21.
//

import UIKit
//MARK: Incluir el framework necesario para gestionar las notificaciones
import UserNotifications
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    //MARK: Primer metodo que se carga al crear la aplicacion o APP
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //Configura firebase
        FirebaseApp.configure()
        
        //Registra para mandar notificaciones
        registerForPushNotification(application: application)
        
        Messaging.messaging().delegate = self
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    //APNs me conteste el token que identica el app en el servicio de APNs solo es compatible con disposotivos reales
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            
        let tokenParts = deviceToken.map { data in  String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Device token: \(token)")
        //se debe guardar en un backEnd
        Messaging.messaging().apnsToken = deviceToken
        
    }
    
}

//MARK: Este metodo sirve para pedir permisos al usuario de recibir notificaciones
extension AppDelegate {
    
    //.badge: muestra un numero entero en la esquina del icono de mi aplicacion
    //.sound: Reproducir un sonido
    //.alert: Muestra un texto de mi notificacion
    
    func registerForPushNotification(application: UIApplication) {
    
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
//
//             print("permission granted: \(granted)")
//
//            guard granted else { return }
//            self.getNotificationSettings()
//
//        }
        
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
          )
        } else {
          let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
        
    }

}

//MARK: Este metodo sirve para validar la autorizacion previa y para registrar el dispositivo con el servicio de apple push notification Service(APNs)
extension AppDelegate {
    
    func getNotificationSettings() {
        
        UNUserNotificationCenter.current().getNotificationSettings { settings in
                
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
            
        }
        
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    

}

//MARK: MessagingDelegate
extension AppDelegate: MessagingDelegate {
  // [START refresh_token]
  
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
    print("Firebase registration token: \(String(describing: fcmToken))")

    let dataDict: [String: String] = ["token": fcmToken ?? ""]
    NotificationCenter.default.post(
      name: Notification.Name("FCMToken"),
      object: nil,
      userInfo: dataDict
    )
    // TODO: If necessary send token to application server.
    // Note: This callback is fired at each app startup and whenever a new token is generated.
  }

  // [END refresh_token]
}


