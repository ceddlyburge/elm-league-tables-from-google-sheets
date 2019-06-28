// from https://github.com/depadiernos/token-hider-inator
const axios = require("axios")
//const qs = require("qs")

export function handler(event, context, callback) {
  // apply our function to the queryStringParameters and assign it to a variable
  //const API_PARAMS = qs.stringify(event.queryStringParameters)
  // Get env var values defined in our Netlify site UI
  //const { API_TOKEN, API_URL } = process.env
  // In this example, the API Key needs to be passed in the params with a key of key.
  // We're assuming that the ApiParams var will contain the initial ?
  //const URL = `https://sheets.googleapis.com/v4/spreadsheets/1DeqpunDFihCDghs_5JeqSASCTxF8vUsaYQfwVrrWaDM/values/Div 1?key=AIzaSyCjcd6FnVIYZX1VqTtpaLP1HcEiN2vQbao` 

  //console.log(process.env)
  const { ELM_APP_GOOGLE_SHEET, ELM_APP_GOOGLE_API_KEY } = process.env 
  //console.log(event.queryStringParameters.leagueTitle)
  const URL = `https://sheets.googleapis.com/v4/spreadsheets/${ELM_APP_GOOGLE_SHEET}/values/${event.queryStringParameters.leagueTitle}?key=${ELM_APP_GOOGLE_API_KEY}` 
  //`${API_URL}?${API_PARAMS}&key=${API_TOKEN}`


  // Let's log some stuff we already have.
  //console.log("Injecting token to", API_URL);
  //console.log("logging event.....", event)
  //console.log("Constructed URL is ...", URL)

   // Here's a function we'll use to define how our response will look like when we call callback
  const pass = (body) => {
    //console.log(body)
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
    axios.get(URL)
    .then((response) =>
      {
        pass(response.data)
      }
    )
    .catch(err => pass(err))
  }
  if(event.httpMethod == 'GET'){
    get()
  };
};

// exports.handler = (event, context, callback) => {
//   // "event" has informatiom about the path, body, headers etc of the request
//   console.log('event', event)
//   // "context" has information about the lambda environment and user details
//   console.log('context', context)

//   http.request

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