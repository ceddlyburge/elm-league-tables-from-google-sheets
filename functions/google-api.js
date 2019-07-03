// from https://github.com/depadiernos/token-hider-inator
const axios = require("axios")

export function handler(event, context, callback) {
  const { ELM_APP_GOOGLE_SHEET, ELM_APP_GOOGLE_API_KEY } = process.env 
  const URL = `https://sheets.googleapis.com/v4/spreadsheets/${ELM_APP_GOOGLE_SHEET}/values/${event.queryStringParameters.leagueTitle}?key=${ELM_APP_GOOGLE_API_KEY}` 

  console.log(event)
  console.log(context)

  const pass = (body) => {
    callback( null, {
      statusCode: 200,
      headers: { 
        "content-type": "application/json; charset=UTF-8",
        "access-control-allow-origin": "*",
        "access-control-expose-headers": "content-encoding,date,server,content-length"
      },
      body: JSON.stringify(body)
    })
  }

  const get = () => {
    console.log("Perform the API call to ", URL)
    const newHeaders = {
        "Accept": "application/json",
        "Host": "sheets.googleapis.com",
        "accept": "application/json",
        "host": "sheets.googleapis.com",
    }
    const headers = {...event.headers, ...newHeaders}
    console.log(headers)
    axios.get(URL, {
      headers: headers
    })
    .then((response) =>
      {
        pass(response.data)
      }
    )
    .catch(pass)
  }
  if(event.httpMethod == 'GET'){
    get()
  };
};

// exports.handler = (event, context, callback) => {
//   // The "callback" ends the execution of the function and returns a reponse back to the caller
//   return callback(null, {
//     statusCode: 200,
//     headers: { 
//       "content-type": "application/json; charset=UTF-8",
//       "access-control-allow-origin": "*",
//       "access-control-expose-headers": "content-encoding,date,server,content-length"
//     },
//     body: JSON.stringify({
//         "range": "'Regional Div 1'!A1:Z1000",
//         "majorDimension": "ROWS",
//         "values": [
//           [
//             "Home Team",
//             "Home Score",
//             "Away Score",
//             "Away Team",
//             "Date Played"
//           ],
//           [
//             "Blackwater",
//             "",
//             "",
//             "Nomad"
//           ],
//           [
//             "Castle",
//             "2",
//             "1",
//             "Meridian",
//             "2018-06-04 10:40"
//           ],
//           [
//             "Blackwater",
//             "3",
//             "0",
//             "Clapham",
//             "2018-06-04 10:20"
//           ],
//           [
//             "Battersea",
//             "",
//             "",
//             "Clapham",
//             "2018-06-03 11:20"
//           ]
//         ]
//       })
//   })
// }