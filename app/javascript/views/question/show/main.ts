import { createApp } from 'vue'
import Reply from './Reply.vue'
import AiAnswer from './AiAnswer.vue'

function build() {
  document.addEventListener('DOMContentLoaded', () => {
    createApp(Reply).mount('#vue-reply')
    createApp(AiAnswer).mount('#vue-ai-answer')
  })
}

build()