import { createApp } from 'vue'
import Reply from './Reply.vue'

function build() {
  document.addEventListener('DOMContentLoaded', () => {
    createApp(Reply).mount('#vue-reply')
  })
}

build()