//
//  TaskModel.swift
//  Bucket List
//
//  Created by administrator on 20/10/2021.
//

import Foundation
import Alamofire

class TaskModel {
//    static func getAllTasks(completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
//        let url = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/")
//        let session = URLSession.shared
//        let task = session.dataTask(with: url!, completionHandler: completionHandler)
//        task.resume()
//
//
//    }
    
    static func getAllTasks(completionHandler:@escaping(_ taskList: [TaskResponse]?, _ error: Error?) -> Void) {
       
        AF.request("https://saudibucketlistapi.herokuapp.com/tasks/").responseDecodable(of: [TaskResponse].self) { response in
            let taskList = response.value
        //    debugPrint(response)
        
        completionHandler(taskList,nil)
        }
    }
    static func postTasks(objective : String, completionHandler: @escaping(_ response: TaskResponse?, _ error : Error?) -> Void) {
          let parameters =  ["objective": objective]
  
          AF.request("https://saudibucketlistapi.herokuapp.com/tasks/", method: .post, parameters: parameters).responseDecodable ( of: TaskResponse.self){ response in
              if let response = response.value{
                  completionHandler(response , nil)
              }
          }
      }
    
    static func editTasks(id: Int , objective : String, completionHandler: @escaping(_ response: TaskResponse?, _ error : Error?) -> Void) {
          let parameters =  ["objective": objective]
  
          AF.request("https://saudibucketlistapi.herokuapp.com/tasks/\(id)/", method: .put, parameters: parameters).responseDecodable ( of: TaskResponse.self){ response in
              if let response = response.value{
                  completionHandler(response , nil)
              }
          }
      }
    
    static func removeTasks(id: Int, completionHandler: @escaping(_ response: TaskResponse?, _ error : Error?) -> Void) {
          
  
          AF.request("https://saudibucketlistapi.herokuapp.com/tasks/\(id)/", method: .delete, parameters: nil).responseDecodable ( of: TaskResponse.self){ response in
              if let response = response.value{
                  completionHandler(response , nil)
              }
          }
      }
}

struct TaskResponse : Codable {
    let created_at : String
    let id : Int
    let objective : String
}
