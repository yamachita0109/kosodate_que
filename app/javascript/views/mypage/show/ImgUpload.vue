<template>
  <div class="p-5 text-center">
    <button
      type="button"
      @click="clickChgIcon()"
      class="inline-flex text-white bg-green-500 border-0 py-2 px-6 focus:outline-none hover:bg-green-600 rounded text-base"
    >画像を変更する</button>
  </div>
  <div
    ref="modal"
    tabindex="-1"
    aria-hidden="true"
    class="fixed top-0 left-0 right-0 z-50 hidden w-full p-4 overflow-x-hidden overflow-y-auto md:inset-0 h-[calc(100%-1rem)] max-h-full"
  >
    <div class="relative w-full max-w-2xl max-h-full">
      <div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
        <div class="flex items-start justify-between p-4 border-b rounded-t dark:border-gray-600">
          <h3 class="text-xl font-semibold text-green-600 dark:text-white">
            画像を変更する
          </h3>
          <button
            type="button"
            class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-600 dark:hover:text-white"
            @click="clickClose"
          >
            <svg aria-hidden="true" class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
            <span class="sr-only">Close modal</span>
          </button>
        </div>

        <div class="p-6 space-y-6">
          <div class="text-base leading-relaxed text-gray-500 dark:text-gray-400">
            <input
              class="block w-full mb-5 text-xs text-gray-900 border border-gray-300 rounded-lg cursor-pointer bg-gray-50 dark:text-gray-400 focus:outline-none dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400"
              type="file"
              accept="image/*"
              @change="setImage"
            >

            <div
              v-show="imgSrc != null"
              class="flex flex-col items-center mb-4"
            >
            <div
                style="width: 200px; height:200px; border: 1px solid gray; display: block;"
                class="mb-4"
              >
                <vue-cropper
                  ref="cropper"
                  :guides="true"
                  :view-mode="2"
                  drag-mode="crop"
                  :auto-crop-area="0.5"
                  :min-container-width="200"
                  :min-container-height="200"
                  :background="true"
                  :rotatable="false"
                  :src="imgSrc"
                  :img-style="{ 'width': '200px', 'height': '200px' }"
                  :aspect-ratio="2 / 2"
                >
                </vue-cropper>
              </div>
              <button
                type="button"
                class="text-white bg-green-500 border-0 py-2 px-6 focus:outline-none hover:bg-green-600 rounded text-lg focus:ring-4 focus:outline-none focus:ring-green-300"
                @click="cropImage"
              >トリミングする</button>
            </div>

            <div
              v-show="cropImg != null"
              class="flex flex-col items-center mb-4"
            >
              <img
                :src="cropImg"
                style="width: 200px; height: 200px; border: 1px solid gray;"
                alt="Cropped Image"
                class="mb-4"
              >
              <button
                type="submit"
                class="text-white bg-green-500 border-0 py-2 px-6 focus:outline-none hover:bg-green-600 rounded text-lg focus:ring-4 focus:outline-none focus:ring-green-300"
              >この画像を登録</button>
              <input
                ref="logo"
                type="hidden"
                name="logo"
              >
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
// TODO 整理
import '~/../../../node_modules/cropperjs/dist/cropper.js'
import '~/../../../node_modules/cropperjs/dist/cropper.css'
import VueCropper from 'vue-cropperjs';
import 'cropperjs/dist/cropper.css';
import { Modal } from 'flowbite'
import type { ModalInterface } from 'flowbite'

// TODO リファクタリング
export default defineComponent({
  components: {
    VueCropper
  },
  data() {
    return {
      modal: null as unknown as ModalInterface,
      imgSrc: null as any,
      filename: null as any,
      cropImg: null as any
    }
  },
  mounted() {
    const modal: HTMLElement = (this.$refs.modal as HTMLElement)
    this.modal = new Modal(modal)
  },
  methods: {
    clickChgIcon() {
      this.modal.show()
    },
    clickClose() {
      this.modal.hide()
    },
    setImage(e) {
      const file = e.target.files[0]
      this.filename = file.name
      const reader = new FileReader()
      reader.onload = event => {
        this.imgSrc = event!.target!.result ?? null
        ;(this.$refs as any).cropper.replace(event!.target!.result)
      }
      reader.readAsDataURL(file)
    },
    cropImage() {
      const dataurl = (this.$refs as any).cropper.getCroppedCanvas().toDataURL()
      this.cropImg = dataurl
      ;(this.$refs as any).logo.value = dataurl
    }
  },
})
</script>
