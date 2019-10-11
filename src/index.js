import './fade-in.css';
import './loading.css';
import { Elm } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

Elm.Main.init(
    { 
        flags: {
            netlifyFunctionsServer: process.env.ELM_APP_NETLIFY_FUNCTIONS_SERVER || ""
            , applicationTitle: process.env.ELM_APP_APPLICATION_TITLE || "League Tables"
            , windowWidth: window.innerWidth
            , windowHeight: window.innerHeight
        }
    }
);

registerServiceWorker();