
// function to connect to mysql database
function connect() {
    var mysql = require('mysql');
    var con = mysql.createConnection({
        host: "localhost",
        user: "root",
        password: "root",
        database: "karmic-wheel-def"
    });

    con.connect(function(err) {
        if (err) throw err;
        console.log("Connected!");
    });
    return con;
}

// function to get all classes
