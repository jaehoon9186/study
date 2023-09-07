import Foundation

func solution(_ my_strings:[String], _ parts:[[Int]]) -> String {
    return my_strings.indices.map { my_strings[$0].map { String($0) }[parts[$0][0]...parts[$0][1]].joined() }.joined()
}