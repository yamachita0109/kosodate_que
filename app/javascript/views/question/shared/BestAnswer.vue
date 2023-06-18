<template>
  <button
    data-modal-target="done-modal"
    data-modal-toggle="done-modal"
    class="flex items-center mt-auto text-white bg-green-500 border-0 py-2 px-6 focus:outline-none hover:bg-green-600 rounded text-sm md:text-lg focus:ring-4 focus:outline-none focus:ring-green-300"
    type="button"
  >
    <svg class="w-4 h-4 mr-2" style="fill: #FFF;" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512"><!--! Font Awesome Pro 6.4.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license (Commercial License) Copyright 2023 Fonticons, Inc. --><path d="M297.2 248.9C311.6 228.3 320 203.2 320 176c0-70.7-57.3-128-128-128S64 105.3 64 176c0 27.2 8.4 52.3 22.8 72.9c3.7 5.3 8.1 11.3 12.8 17.7l0 0c12.9 17.7 28.3 38.9 39.8 59.8c10.4 19 15.7 38.8 18.3 57.5H109c-2.2-12-5.9-23.7-11.8-34.5c-9.9-18-22.2-34.9-34.5-51.8l0 0 0 0c-5.2-7.1-10.4-14.2-15.4-21.4C27.6 247.9 16 213.3 16 176C16 78.8 94.8 0 192 0s176 78.8 176 176c0 37.3-11.6 71.9-31.4 100.3c-5 7.2-10.2 14.3-15.4 21.4l0 0 0 0c-12.3 16.8-24.6 33.7-34.5 51.8c-5.9 10.8-9.6 22.5-11.8 34.5H226.4c2.6-18.7 7.9-38.6 18.3-57.5c11.5-20.9 26.9-42.1 39.8-59.8l0 0 0 0 0 0c4.7-6.4 9-12.4 12.7-17.7zM192 128c-26.5 0-48 21.5-48 48c0 8.8-7.2 16-16 16s-16-7.2-16-16c0-44.2 35.8-80 80-80c8.8 0 16 7.2 16 16s-7.2 16-16 16zm0 384c-44.2 0-80-35.8-80-80V416H272v16c0 44.2-35.8 80-80 80z"/></svg>
    解決した
  </button>

  <div
    id="done-modal"
    tabindex="-1"
    aria-hidden="true"
    class="fixed top-0 left-0 right-0 z-50 hidden w-full p-4 overflow-x-hidden overflow-y-auto md:inset-0 h-[calc(100%-1rem)] max-h-full"
  >
    <div class="relative w-full max-w-2xl max-h-full">
      <div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
        <div class="flex items-start justify-between p-4 border-b rounded-t dark:border-gray-600">
          <h3 class="text-xl font-semibold text-gray-900 dark:text-white">
            質問を解決
          </h3>
          <button type="button" class="text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-600 dark:hover:text-white" data-modal-hide="done-modal">
            <svg aria-hidden="true" class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
            <span class="sr-only">Close modal</span>
          </button>
        </div>
        <div class="p-6 space-y-6">
          <p class="text-xl font-semibold text-gray-900 dark:text-white">
            ベストアンサーを選ぶ
          </p>
          <p class="text-base leading-relaxed text-gray-500 dark:text-gray-400">
            回答の中で一番良いと感じたものを「ベストアンサー」として選んでください。
          </p>
          <ul class="grid w-full gap-6 md:grid-cols-2">
            <li
              v-for="answer in answers"
              :key="answer.id"
            >
              <input
                type="radio"
                :id=answer.id
                name="answer_id"
                :value=answer.id
                class="hidden peer"
                required
                @change="selectAnswer"
              >
              <label
                :for=answer.id
                class="inline-flex items-center justify-between w-full p-5 text-gray-500 bg-white border border-gray-200 rounded-lg cursor-pointer dark:hover:text-gray-300 dark:border-gray-700 dark:peer-checked:text-green-500 peer-checked:border-green-600 peer-checked:text-green-600 hover:text-gray-600 hover:bg-gray-100 dark:text-gray-400 dark:bg-gray-800 dark:hover:bg-gray-700"
              >
                <div class="block">
                  <div class="w-full text-lg font-semibold flex gap-3 items-center mb-4">
                    <img :src=userImgPath(answer.user_id) class="w-8 h-8 rounded-full flex-shrink-0 object-cover object-center" />
                    {{ answer.user_name }}
                  </div>
                  <div class="w-full">{{ answer.content }}</div>
                </div>
              </label>
            </li>
          </ul>
        </div>
        <div class="relative text-center p-6 space-x-2 border-t border-gray-200 rounded-b dark:border-gray-600">
          <button
            type="submit"
            class="text-white bg-green-500 hover:bg-green-600 focus:ring-4 focus:outline-none focus:ring-green-300 rounded text-lg px-6 py-4 text-center dark:bg-green-600 dark:hover:bg-green-700 dark:focus:ring-green-800"
          >解決にする</button>
        </div>
      </div>
    </div>
  </div>


</template>

<script lang="ts">
import { defineComponent } from 'vue'
import axios from 'axios'
import { Answer } from 'app/javascript/@types/answer'

export default defineComponent({
  props: {
    // 実際に送信するForm
    inputForm: {
      type: HTMLInputElement,
      required: true,
    },
  },
  data() {
    return {
      // question_id
      id: location.pathname.split('/')[2],
      answers: [] as Answer[],
    }
  },
  async created() {
    this.answers = await this.getAnswer()
  },
  mounted() {
  },
  methods: {
    async getAnswer(): Promise<Answer[]> {
      const res = await axios.get('/api/answer', { params: { question_id: this.id, order: '' } })
      return res.data.rows
    },
    selectAnswer(e) {
      this.inputForm.value = e.target.value || null
    },
    userImgPath(id) {
      return `/user/${id}.jpg`
    },
  },
})
</script>
