import { createApp } from 'vue'
import ImgUpload from './ImgUpload.vue'
import QuestionsTab from './QuestionsTab.vue'

function build() {
  document.addEventListener('DOMContentLoaded', () => {
    createApp(ImgUpload).mount('#vue-img-upload')
    createApp(QuestionsTab).mount('#vue-questions-tab')
  })
}

build()