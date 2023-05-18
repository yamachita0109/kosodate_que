Question.delete_all
Question.create!(
  (0..10).map {|i|
    {
      title: "#{i}テストタイトル作業中",
      tags: "#{i}テストタグ",
      content: "#{i}テスト内容内容内容内容",
      view_cnt: 1,
      answer_cnt: 1,
      status: 'WIP',
      user_id: 1,
    }
  }
)
Question.create!(
  (0..10).map {|i|
    {
      title: "#{i}テストタイトル本番",
      tags: "#{i}テストタグ",
      content: "#{i}テスト内容内容内容内容",
      view_cnt: 1,
      answer_cnt: 1,
      status: 'OPEN',
      user_id: 1,
    }
  }
)