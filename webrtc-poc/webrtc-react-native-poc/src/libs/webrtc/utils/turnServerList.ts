//import { request } from "https";// Node Get ICE STUN and TURN list

function getGoogleICEServers(): any {
    return {
        iceServers: [
            {
                urls: "stun:stun.l.google.com:19302",
            },
            {
                urls: "stun:stun1.l.google.com:19302",
            },
            {
                urls: "stun:stun2.l.google.com:19302",
            },
            {
                urls: "stun:stun3.l.google.com:19302",
            },
            {
                urls: "stun:stun4.l.google.com:19302",
            },
            {
                urls: "stun:stun.services.mozilla.com",
            },
        ],
    }
}

function getOpenRelayICEServers(): any {
    return {
        iceServers: [
            {
                urls: "stun:stun.l.google.com:19302",
            },
            {
              urls: "stun:stun.relay.metered.ca:80",
            },
            {
              urls: "turn:global.relay.metered.ca:80",
              username: "f5461d6c9cc5012234086b79",
              credential: "nSc6xmPVwNOagAD2",
            },
            {
              urls: "turn:global.relay.metered.ca:80?transport=tcp",
              username: "f5461d6c9cc5012234086b79",
              credential: "nSc6xmPVwNOagAD2",
            },
            {
              urls: "turn:global.relay.metered.ca:443",
              username: "f5461d6c9cc5012234086b79",
              credential: "nSc6xmPVwNOagAD2",
            },
            {
              urls: "turns:global.relay.metered.ca:443?transport=tcp",
              username: "f5461d6c9cc5012234086b79",
              credential: "nSc6xmPVwNOagAD2",
            },
        ],
    }
}
/* 
function getXirsysICEServers(): any {
    let o = {
        format: "urls"
    };

    let bodyString = JSON.stringify(o);

    let options = {
        host: "global.xirsys.net",
        path: "/_turn/colab",
        method: "PUT",
        headers: {
            "Authorization": "Basic " + Buffer.from("rameshvk:bbb53db8-2dc5-11ef-a656-0242ac150002").toString("base64"),
            "Content-Type": "application/json",
            "Content-Length": bodyString.length
        }
    };


    let iceList = "";
    let httpreq = request(options, function (httpres) {
        let str = "";
        httpres.on("data", function (data) { str += data; });
        httpres.on("error", function (e) { console.log("error: ", e); });
        httpres.on("end", function () {
            console.log("ICE List: ", str);
            iceList = JSON.parse(str).v.iceServers;
        });
    });

    httpreq.on("error", function (e) { console.log("request error: ", e); });
    httpreq.end();

    return iceList;
}
 */
export { getGoogleICEServers, getOpenRelayICEServers };