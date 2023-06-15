module QuestionHelper
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
