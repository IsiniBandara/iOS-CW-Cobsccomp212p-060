//
//  AuthService.swift
//  iOS CW - COBSCCOMP212P-060
//
//  Created by Isini Bandara on 2023-05-15.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthService  {
    public static let shared = AuthService()
    
    private init() {}
    
    
    /// A Method to Register User
    /// - Parameters:
    ///   - userRequest: The user information (email, username, password)
    ///   - completion: A completion with two values....
    ///   - Bool: wasRegistered - Determines if the user was registered and save in the database
    ///   - Error?:  An optional error Firebase Provided
    public func registerUser(with userRequest: User, completion: @escaping(Bool, Error?)-> Void){
        let username = userRequest.username
        let email = userRequest.email
        let password = userRequest.password
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(false, error)
                return
            }
            
            guard let resultUser = result?.user else {
                completion(false, nil)
                return
            }
            
            let db = Firestore.firestore()
            
            db.collection("users").document(resultUser.uid).setData([
                "username": username,
                "email": email
            ]) { error in
                if let error = error {
                    completion(false, error)
                    return
                }
                
                completion(true, nil)
            }
        }
    }
    
    
    public func signIn(with userRequest: LoginUserRequest, completion: @escaping(Error?)-> Void){
        Auth.auth().signIn(withEmail: userRequest.email, password: userRequest.password) {result,error in
            if let  error = error {
                completion(error)
                return
            } else {
                completion(nil)
            }
        }
    }
    
    public func signOut(completion: @escaping(Error?)-> Void){
        do{
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    public func forgetPassword(with email: String, completion: @escaping (Error?) -> Void){
        Auth.auth().sendPasswordReset(withEmail: email){ error in
            completion(error)
        }
    }
    
    public func fetchUser(completion: @escaping (FetchUser?, Error?) -> Void){
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        
        db.collection("users").document(userUID).getDocument { snapshot, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let snapshot = snapshot,
               let snapshotData = snapshot.data(),
               let username = snapshotData["username"] as? String,
                let email = snapshotData["email"] as? String,
               let gender = snapshotData["gender"] as? String,
                let age = snapshotData["age"] as? String,
               let height = snapshotData["height"] as? String,
               let weight = snapshotData["weight"] as? String,
               let goal = snapshotData["goal"] as? String,
               let activity_level = snapshotData["activity_level"] as? String
            {
                let user = FetchUser(username: username, email: email, userUID: userUID, gender: gender, age: age, height: height, weight: weight, goal: goal, activity_level: activity_level)
                completion(user, nil)
            }
        }
    }
    
    public func fetchMainWorkouts(completion: @escaping ([WorkoutMainList]?, Error?) -> Void){
            // Create a Firestore reference to the Firestore database
            var workout = [WorkoutMainList]()
            let db = Firestore.firestore()

            // Create a reference to the "cool_down" collection under "/Female/Gryffindor Strength"
            let Ref = db.collection("Workouts")

            // Fetch the data from the Firestore collection
            Ref.getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error fetching documents: \(error)")
                    completion(nil, error)
                    return
                }

                guard let snapshot = snapshot else {
                    print("Snapshot is nil")
                    completion(nil, error)
                    return
                }

                for document in snapshot.documents {
                    let data = document.data()
                    // Process the retrieved data here
                    // Access specific fields using the data dictionary
                    let id = data["id"] as? Int
                    let title = data["title"] as? String
                    let duration = data["duration"] as? String
                    let burn_cal = data["burn_cal"] as? String
                    let covered_area = data["covered_area"] as? String
                    let interval = data["interval"] as? String
                    let url = data["url"] as? String
                    
                    // Do further processing or store the retrieved data as needed
                    workout.append(WorkoutMainList(ID: id!, burn_cal: burn_cal ?? "100 cal", covered_area: covered_area ?? "", duration: duration ?? "", interval: interval ?? "", title: title ?? "", url: url ?? ""))
                    
                }
                
                completion(workout, nil)
            }
        }
}
