const puppeteer = require('puppeteer')
const { Parser } = require('json2csv')
const fs = require('fs')
// const { setTimeout } = require('timers/promises')

const main = async () => {
  const browser = await puppeteer.launch()
  const page = await browser.newPage()

  const url = 'https://www.mcfh.or.jp/netsoudan/article.php?id=:id'
  const objs = [] as any[]

  for await (let i of Array.from({ length: 101 }, (_, index) => 1700 + index)) {
    const u = url.replace(':id', i.toString())
    // await setTimeout(1000)
    console.log(u, 'start.')
    await page.goto(u)
    const obj = {} as any
    try {
      // #js-wrapper > div.c-container.cf > main > article > h3:nth-child(3)
      obj.title = await page.$eval('#js-wrapper > div.c-container.cf > main > article > h3:nth-child(3)', item => item.textContent.replace(/^Q\.\s*/, '').replace(/\s*\(\d{4}\.\d{1,2}\)$/, ''))
      // #js-wrapper > div.c-container.cf > main > article > p:nth-child(5)
      obj.question = await page.$eval('#js-wrapper > div.c-container.cf > main > article > p:nth-child(5)', item => item.textContent)
      // #js-wrapper > div.c-container.cf > main > article > p:nth-child(7)
      obj.answer = await page.$eval('#js-wrapper > div.c-container.cf > main > article > p:nth-child(7)', item => item.textContent)
    } catch (error) {
      console.log(u, 'error.')
      continue
    }
    objs.push(obj)
    console.log(u, 'finish.')
  }
  const fields = [
      { label: 'title', value: 'title'},
      { label: 'question', value: 'question'},
      { label: 'answer', value: 'answer'},
  ]

  const json2csvParser = new Parser({fields, header:true, withBOM: true})
  const parsedCsv = json2csvParser.parse(objs)
  fs.writeFileSync('./output.csv', parsedCsv, 'utf-8')

  await browser.close()
}

main()