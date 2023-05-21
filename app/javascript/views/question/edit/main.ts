import { createApp } from 'vue'
import Tags from '../../shared/Tags.vue'

function build() {
  document.addEventListener('DOMContentLoaded', () => {
    const input = document.querySelector('#question_tags')
    createApp(Tags, { inputForm: input }).mount('#vue-tags')
  })
}

build()