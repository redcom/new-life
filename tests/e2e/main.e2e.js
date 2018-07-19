import wd from 'wd'
import config from './appiumConfig'
import deviceConfigs from './deviceConfigs'

describe ('the whole suite', () => {
  beforeAll(async () => {
  })

  const filteredDeviceConfigs = process.env.TEST_PLATFORM ? deviceConfigs.filter(deviceConfig => deviceConfig.platformName === process.env.TEST_PLATFORM) : deviceConfigs
  for (const deviceConfig of filteredDeviceConfigs) {
    const myConfig = {...config}
    myConfig.deviceConfig = deviceConfig
    describe (`Single Device ${myConfig.deviceConfig.platformName}`, () => {
      const client = wd.promiseChainRemote(myConfig.hostname, myConfig.port, myConfig.username, myConfig.accessKey)
      jasmine.DEFAULT_TIMEOUT_INTERVAL = myConfig.timeout

      beforeAll(async () => {
        await client.init(myConfig.deviceConfig)
        await client.setImplicitWaitTimeout(5000)
      })

      afterAll(async () => {
        await client.quit()
        console.log('quit client')
      })

      it('should welcome the user', async () => {
        expect(await client.hasElementByAccessibilityId('welcome-message')).toBe(true)
        const welcomeMessageElement = await client.elementByAccessibilityId('welcome-message')
        const welcomeMessageText = await welcomeMessageElement.text()
        console.log(welcomeMessageText)
        expect(welcomeMessageText).toBe('Welcome to React Native!')
      })

      it ('alert button should display an alert', async () => {
        expect(await client.hasElementByAccessibilityId('alert-message')).toBe(false)
        await client.elementByAccessibilityId('click-button').click()
        expect(await client.hasElementByAccessibilityId('alert-message')).toBe(true)
      })

      it ('should remove alert with empty input', async () => {
        if (process.env.TEST_PLATFORM === 'iOS') {
        } else {
          const inputField = await client.elementByAccessibilityId('input-field')
          await inputField.clear()
          expect(await client.hasElementByAccessibilityId('alert-message')).toBe(false)
        }
      })

      it ('should input', async () => {
        const inputField = await client.elementByAccessibilityId('input-field')
        await inputField.clear()
        const inputText = 'Hello World!'
        await inputField.type(inputText)
        expect(await inputField.text()).toBe(inputText)
      })
    })
  }
})
