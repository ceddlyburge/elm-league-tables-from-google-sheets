import './fade-in.css';
import './loading.css';
import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

var app = Main.embed(document.getElementById('root'), {
    googleSheet: process.env.ELM_APP_GOOGLE_SHEET,
    googleApiKey: process.env.ELM_APP_GOOGLE_API_KEY,
});

registerServiceWorker();
