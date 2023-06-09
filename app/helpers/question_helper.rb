module QuestionHelper
  def question_status(question)
    text = ''
    color = ''
    if question.wip?
      text = '作成中'
      color = 'yellow'
    end
    if question.open?
      text = '質問中'
      color = 'indigo'
    end
    if question.done?
      text = '解決済'
      color = 'red'
    end
    if question.del?
      text = '取下げ'
      color = 'gray'
    end
    "<span class='py-1 px-2 rounded bg-#{color}-100 text-#{color}-500 text-xs font-medium tracking-widest mb-2'>#{text}</span>"
  end

  def question_content(content)
    if content.length > 60
      content[0...60] + "..."
    else
      content
    end
  end

  def question_user_name(user_name)
    if user_name.nil?
      'NoName.'
    else
      user_name
    end
  end

  def question_tags(tags)
    tags.split(',').reduce('') {|html, tag|
      html += "<span class='py-1 px-2 rounded bg-green-50 text-green-500 text-xs font-medium tracking-widest mr-1'>#{tag}</span>"
    }
  end
end
