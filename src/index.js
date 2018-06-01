import './main.css';
import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

var app = Main.embed(document.getElementById('root'), {
    googleSheet: "hello"//process.env.ELM_APP_GOOGLE_SHEET,
});

registerServiceWorker();

// ports related code
app.ports.requestSheet.subscribe(function(googleSheet) {
    app.ports.googleSheet.send('this is a google sheet, honestly')
});