import { createApp } from 'vue'
import ImgUpload from './ImgUpload.vue'

function build() {
  document.addEventListener('DOMContentLoaded', () => {
    createApp(ImgUpload).mount('#vue-img-upload')
  })
}

build()