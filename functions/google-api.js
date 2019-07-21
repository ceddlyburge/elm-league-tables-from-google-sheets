const axios = require("axios")

export function handler(event, context, callback) {
  const ELM_APP_GOOGLE_SHEET = process.env.ELM_APP_GOOGLE_SHEET
  const ELM_APP_GOOGLE_API_KEY = process.env.ELM_APP_GOOGLE_API_KEY
  //const URL = `https://sheets.googleapis.com/v4/spreadsheets/${ELM_APP_GOOGLE_SHEET}/values/${event.queryStringParameters.leagueTitle}?key=${ELM_APP_GOOGLE_API_KEY}` 
  const requiredReponseHeaders = { 
    "content-type": "application/json; charset=UTF-8",
    "access-control-allow-origin": "*",
    "access-control-expose-headers": "content-encoding,date,server,content-length"
  }
  const requiredRequestHeaders = { 
    "Accept": "application/json",
    "accept": "application/json",
    "Host": "sheets.googleapis.com",
    "host": "sheets.googleapis.com"
  }

  const url = () => {
    if (event.queryStringParameters.leagueTitle) {
      return `https://sheets.googleapis.com/v4/spreadsheets/${ELM_APP_GOOGLE_SHEET}/values/${event.queryStringParameters.leagueTitle}?key=${ELM_APP_GOOGLE_API_KEY}`
    } else {
      return `https://sheets.googleapis.com/v4/spreadsheets/${ELM_APP_GOOGLE_SHEET}?key=${ELM_APP_GOOGLE_API_KEY}`
    }
  }

  const get = () => {
    console.log("Perform the API call to ", url())
    axios.get(
      url(),
      { headers: {...event.headers, ...requiredRequestHeaders} 
      }
    ).then(success)
    .catch(failure)
  }

  const success = (response) => {
    console.log(response)
    callback( null, {
      statusCode: response.status,
      // The required headers are already returned by the google api
      headers: {...requiredReponseHeaders, ...response.headers},
      body: JSON.stringify(response.data)
    })
  }

  const failure = (error) => {
    console.log(error)
    if (error.response) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx
      callback( null, {
        statusCode: error.response.status,
        headers: {...requiredReponseHeaders, ...error.response.headers},
        body: JSON.stringify(error.response.data)
      })
    } else if (error.request) {
      // The request was made but no response was received
      // `error.request` is an instance of XMLHttpRequest in the browser and an instance of
      // http.ClientRequest in node.js
      callback( null, {
        statusCode: 408, // Request Timeout seems most appropriate
        headers: requiredReponseHeaders,
        body: JSON.stringify("No response received from Google Api")
      })
    } else {
      // Something happened in setting up the request that triggered an Error
      callback( null, {
        statusCode: 500,
        headers: requiredReponseHeaders,
        body: JSON.stringify(error.message)
      })
    }
  }

  if(event.httpMethod == 'GET') {
    get()
  }
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