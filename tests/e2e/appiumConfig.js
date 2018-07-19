const appiumEnv = process.env.APPIUM_ENV || 'local'

const defaultConfig = {
    hostname: 'localhost',
    port: 4723,
    username: '',
    accessKey: '',
    timeout: 60000,
    prepareFiles: async () => {}
}

const configs = {
    'local': {
        hostname: 'localhost',
        port: 4723
    },
    'saucelabs': {
        hostname: 'ondemand.saucelabs.com',
        username: process.env.SAUCELABS_USER,
        accessKey: process.env.SAUCELABS_TOKEN,
        port: 80,
        timeout: 420000,
    }
}

if (!appiumEnv || !configs[appiumEnv]) {
    throw new Error(`No Config defined for APPIUM_ENV ${appiumEnv}`)
}

export default {...defaultConfig, ...configs[appiumEnv]}
