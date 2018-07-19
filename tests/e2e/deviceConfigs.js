import path from 'path'
const appiumEnv = process.env.APPIUM_ENV || 'local'

const configs = {
  local: [
    {
      platformName: 'Android',
      deviceName: 'Android Emulator',
      app: path.resolve(__dirname, '../../android/app/build/outputs/apk/app-debug.apk')
    },
    {
      platformName: 'iOS',
      platformVersion: '11.3',
      deviceName: 'iPhone Simulator',
      app: path.resolve(__dirname, '../../ios/build/Build/Products/Debug-iphonesimulator/fresh.app')
    }
  ],
  saucelabs: [
    {
      name: 'my-android-test',
      browserName: '',
      appiumVersion: '1.8.1',
      platformName: 'Android',
      platformVersion: '7.1',
      deviceName: 'Android GoogleAPI Emulator',
      app: 'sauce-storage:android.apk'
    },
    {
      name: 'my-ios-test',
      browserName: '',
      appiumVersion: '1.8.1',
      deviceName: 'iPhone X Simulator',
      platformName: 'iOS',
      platformVersion: '11.3',
      app: 'sauce-storage:iphone.zip'
    }
  ]
}

if (!appiumEnv || !configs[appiumEnv]) {
  throw new Error(`No Device Config defined for APPIUM_ENV ${appiumEnv}`)
}

export default configs[appiumEnv]
