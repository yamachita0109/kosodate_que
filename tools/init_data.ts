const puppeteer = require('puppeteer')
const { Parser } = require('json2csv')
const fs = require('fs')

const main = async () => {
  const browser = await puppeteer.launch()
  const page = await browser.newPage()

  const url = 'https://www.mcfh.or.jp/netsoudan/article.php?id=:id'
  const objs = [] as any[]

  for await (let i of Array.from({ length: 101 }, (_, index) => 1700 + index)) {
    const u = url.replace(':id', i.toString())
    await new Promise(resolve => setTimeout(resolve, 1000))
    console.log(u, 'start.')
    await page.goto(u)
    const obj = {} as any
    try {
      // #js-wrapper > div.c-container.cf > main > article > h3:nth-child(3)
      obj.title = await page.$eval('#js-wrapper > div.c-container.cf > main > article > h3:nth-child(3)', item => item.textContent.replace(/^Q\.\s*/, '').replace(/\s*\(\d{4}\.\d{1,2}\)$/, ''))
      // #js-wrapper > div.c-container.cf > main > article > p:nth-child(5)
      obj.question = await page.$eval('#js-wrapper > div.c-container.cf > main > article > p:nth-child(5)', item => item.textContent.replace(/\s+/g, '').replace(/\r?\n/g, ''))
      // #js-wrapper > div.c-container.cf > main > article > p:nth-child(7)
      obj.answer = await page.$eval('#js-wrapper > div.c-container.cf > main > article > p:nth-child(7)', item => item.textContent.replace(/\s+/g, '').replace(/\r?\n/g, ''))

      const text = `行動1:
下記指示に則ってください
・オリジナル文章のタイトル、質問から簡潔なタグを3つから5つほど作成し、カンマ区切りで出力する
・オリジナル文章のタイトルを人の目を引くような文章にする
・オリジナル文章の質問部分を人の目を引くような文章にする
・オリジナル文章の回答部分を専門的な用語を排除して素人でもわかりやすい文章にする

オリジナリ文章
タイトル: "${obj.title}"
質問: "${obj.question}"
回答: "${obj.answer}"

出力フォーマット:
・タイトル:
・タグ:
・質問:
・回答:

行動2:タイトル、タグ、質問、回答を書きRubyのコードに埋め込んでください。
また、contentとanswerには改行コードを入れてください。

ary.push({
  :title => タイトル,
  :tags => タグ（配列ではなく、カンマ区切りの文字列）,
  :content => 質問,
  :answer => 回答,
})`
      fs.writeFileSync(`./tmp/tools/${i.toString()}.txt`, text, 'utf-8')

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
  fs.writeFileSync('./tmp/tools/output.csv', parsedCsv, 'utf-8')

  await browser.close()
}

main()