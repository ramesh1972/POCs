import fs from 'fs';
 
export const readFileSync = async (filename) => { 

    return fs.readFileSync(filename, 'utf8')
}