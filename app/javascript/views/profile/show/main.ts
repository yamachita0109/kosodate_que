import { createApp } from 'vue'
import Activity from './Activity.vue'

function build() {
  document.addEventListener('DOMContentLoaded', () => {
    createApp(Activity).mount('#vue-activity')
  })
}

build()