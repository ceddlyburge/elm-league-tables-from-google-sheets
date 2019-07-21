import './fade-in.css';
import './loading.css';
import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

var app = Main.embed(document.getElementById('root'), {
    netlifyFunctionsServer: process.env.ELM_APP_NETLIFY_FUNCTIONS_SERVER || ""
});

registerServiceWorker();