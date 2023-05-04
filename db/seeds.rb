Question.delete_all
Question.create!(
  [
    {
      title: 'テストタイトル1',
      tags: 'テストタグ1',
      content: '内容内容1',
      view_cnt: 1,
      answer_cnt: 1,
      status: 'WIP',
      user_id: 1,
    },
    {
      title: 'テストタイトル2',
      tags: 'テストタグ2',
      content: '内容内容2',
      view_cnt: 2,
      answer_cnt: 2,
      status: 'WIP',
      user_id: 1,
    }
  ]
)