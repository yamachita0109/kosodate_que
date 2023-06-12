import { createApp } from 'vue'
import Tags from '../../shared/Tags.vue'
import BestAnswer from './BestAnswer.vue'

function build() {
  document.addEventListener('DOMContentLoaded', () => {
    const input = document.querySelector('#question_tags')
    createApp(Tags, { inputForm: input }).mount('#vue-tags')

    createApp(BestAnswer, { inputForm: input }).mount('#vue-best-answer')

  })
}

build()