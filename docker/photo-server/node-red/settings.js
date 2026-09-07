// Minimal Node-RED settings.js for the Databasus -> Nextcloud Talk relay.
// This mostly mirrors Node-RED's defaults, with one addition: it exposes
// Node's built-in `crypto` module to Function nodes via global context,
// since the HMAC signature Nextcloud Talk's Bot API requires can't be
// computed without it.

module.exports = {
    flowFile: 'flows.json',
    uiPort: process.env.PORT || 1880,

    // Exposes require('crypto') to Function nodes as global.get('crypto')
    functionGlobalContext: {
        crypto: require('crypto')
    },

    logging: {
        console: {
            level: 'info',
            metrics: false,
            audit: false
        }
    },

    editorTheme: {
        projects: {
            enabled: false
        }
    }
};
