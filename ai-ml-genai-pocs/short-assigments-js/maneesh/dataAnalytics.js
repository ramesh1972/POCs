import { getCompletion } from "../setup.js"
import { readFileSync } from "../fileops.js"

console.log("hello world")

let file_data = readFileSync("./maneesh/junk.json")

console.log(file_data)
