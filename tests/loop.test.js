import { resolve } from "path";

const deviceConfigs = [
    {name: 'testA'},
    {name: 'testB'}
]

describe ('the whole suite', () => {

    for (const config of deviceConfigs) {
        describe (`Stupid Suite Loop ${config.name}`, () => {
            beforeAll(() => {
                console.log(`beforeAll ${config.name}`)
            })
        
            afterAll(() => {
                console.log(`afterAll  ${config.name}`)
            })
        
            it ('should work', async () => {
                console.log(`in should work ${config.name}`)
                await sleep(1000)
                expect(true).toBe(true)
            })
        })
    }
})

const sleep = (time) => {
    return new Promise((resolve, reject) => {
        setTimeout(() => {
            resolve()
        }, time)
    })
}