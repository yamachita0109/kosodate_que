import { createApp } from 'vue'
import Reply from './Reply.vue'
import AiAnswer from './AiAnswer.vue'
import BestAnswer from '../shared/BestAnswer.vue'

function build() {
  document.addEventListener('DOMContentLoaded', () => {
    createApp(Reply).mount('#vue-reply')
    createApp(AiAnswer).mount('#vue-ai-answer')
    createApp(BestAnswer, { inputForm: document.querySelector('#question_answer_id') }).mount('#vue-best-answer')
  })
}

build()