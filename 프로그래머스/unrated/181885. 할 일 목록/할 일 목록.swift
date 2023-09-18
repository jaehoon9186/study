import Foundation

func solution(_ todo_list:[String], _ finished:[Bool]) -> [String] {
    return zip(todo_list, finished).filter { $1 == false }.map { $0.0 } 
}