import { createApp } from 'vue'
import Tags from '../../shared/Tags.vue'
import BestAnswer from '../shared/BestAnswer.vue'

function build() {
  document.addEventListener('DOMContentLoaded', () => {
    createApp(Tags, { inputForm: document.querySelector('#question_tags') }).mount('#vue-tags')
    createApp(BestAnswer, { inputForm: document.querySelector('#question_answer_id') }).mount('#vue-best-answer')
  })
}

build()