Question.delete_all
Question.create!(
  (0..100).map {|i|
    {
      title: "#{i}テストタイトル",
      tags: "#{i}テストタグ",
      content: "#{i}テスト内容内容内容内容",
      view_cnt: 1,
      answer_cnt: 1,
      status: 'WIP',
      user_id: 1,
    }
  }
)