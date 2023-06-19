<template>
  <div class="flex flex-col gap-5 m-3">
    <div
      v-for="answer in answers"
      :key="answer.id"
    >
      <div
        class="flex w-full justify-between border rounded-md"
        :class="{ 'bg-green-100 border border-green-400 text-green-700': answer.is_best_answer }"
      >
        <div class="p-3 w-full">
          <div
            class="flex gap-3 items-center"
            v-if="answer.is_best_answer"
          >
            <svg version="1.1" id="_x32_" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="512px" height="512px" viewBox="0 0 512 512" style="width: 48px; height: 48px; opacity: 1;" xml:space="preserve"><g><path class="st0" d="M512,180.219c0-21.484-17.422-38.891-38.906-38.891c-21.469,0-38.891,17.406-38.891,38.891c0,10.5,4.172,20,10.938,27c-26.453,54.781-77.016,73.891-116.203,56.578c-34.906-15.422-47.781-59.547-52.141-93.734c14.219-7.5,23.922-22.406,23.922-39.594c0-24.719-20.016-44.734-44.719-44.734c-24.719,0-44.734,20.016-44.734,44.734c0,17.188,9.703,32.094,23.938,39.594c-4.359,34.188-17.25,78.313-52.141,93.734C143.875,281.109,93.328,262,66.859,207.219c6.75-7,10.938-16.5,10.938-27c0-21.484-17.422-38.891-38.906-38.891S0,158.734,0,180.219c0,19.766,14.734,36.031,33.813,38.531l55.75,207.516h332.875l55.75-207.516C497.25,216.25,512,199.984,512,180.219z" style="fill: rgb(32,197,94);"></path></g></svg>
            <span class="font-bold">ベストアンサー</span>
          </div>
          <div class="flex gap-3 items-center">
            <a :href=profilePath(answer.user_id) class="inline-flex items-center">
              <img :src=userImgPath(answer.user_id) class="w-8 h-8 rounded-full flex-shrink-0 object-cover object-center">
              <span class="flex-grow flex flex-col pl-3">
                <span class="font-bold text-gray-900">
                  {{ answer.user_name }}
                  <br/>
                  <span class="text-sm text-gray-400 font-normal">{{ formatDate(answer.created_at) }}</span>
                </span>
              </span>
            </a>
          </div>
          <div
            v-html="answer.content.replace(/\n/g, '<br>')"
            class="text-gray-600 mt-2"
          ></div>
          <button
            class="text-right text-green-500 mt-4"
            @click="repliesFromShow[answer.id] = true"
            v-show="!repliesFromShow[answer.id]"
            v-if="qstatus == 'open'"
          >コメントする</button>

          <div
            v-show="repliesFromShow[answer.id]"
            class="w-full mt-4"
          >
            <textarea
              v-model="repliesFrom[answer.id]"
              maxlength="2000"
              class="w-full bg-white rounded border border-gray-300 focus:border-green-500 focus:ring-2 focus:ring-green-200 h-12 text-base outline-none text-gray-700 py-1 px-3 resize-none leading-6 transition-colors duration-200 ease-in-out"
            ></textarea>
            <button
              class="text-right text-green-500 mt-2"
              type="button"
              @click="clickReply(answer.id)"
            >コメントする</button>
          </div>


        </div>
      </div>

      <template
        v-for="reply in answer.replies"
        :key="reply.id"
      >
        <div class="text-gray-300 font-bold pl-14">|</div>
        <div class="flex justify-between border ml-5  rounded-md">
          <div class="p-3">
            <div class="flex gap-3 items-center">

              <a :href=profilePath(reply.user_id) class="inline-flex items-center">
                <img :src=userImgPath(reply.user_id) class="w-8 h-8 rounded-full flex-shrink-0 object-cover object-center">
                <span class="flex-grow flex flex-col pl-3">
                  <span class="font-bold  text-gray-900">
                    {{ reply.user_name }}
                    <br/>
                    <span class="text-sm text-gray-400 font-normal">{{ formatDate(reply.created_at) }}</span>
                  </span>
                </span>
              </a>
            </div>
            <p class="text-gray-600 mt-2">
                {{ reply.content }}
            </p>
          </div>
        </div>
      </template>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import axios from 'axios'
import dayjs from "dayjs"
import { Answer } from '../../../@types/answer'
import { Question } from '../../../@types/question'

export default defineComponent({
  components: {
  },
  data() {
    return {
      // question_id
      id: location.pathname.split('/').pop(),
      answers: [] as Answer[],
      qstatus: '' as string,
      repliesFrom: [] as string[],
      repliesFromShow: [] as boolean[],
    }
  },
  async created() {
    this.answers = await this.getAnswer()
    this.qstatus = (await this.getQuestion())[0].status
  },
  methods: {
    async clickReply(id) {
      const text = this.repliesFrom[id]
      await this.postReply(id, text)
      this.repliesFrom[id] = ''
      this.answers = await this.getAnswer()
    },
    async getQuestion(): Promise<Question[]> {
      const res = await axios.get('/api/question', { params: { id: this.id } })
      return res.data.rows
    },
    async getAnswer(): Promise<Answer[]> {
      const res = await axios.get('/api/answer', { params: { question_id: this.id, order: '' } })
      return res.data.rows
    },
    async postReply(id, text) {
      await axios.post('/api/reply', { answer_id: id, content: text })
    },
    profilePath(id) {
      return `/profile/${id}`
    },
    userImgPath(id) {
      return `/cdn/user/${id}.jpg`
    },
    formatDate(date) {
      return dayjs(date).format('YYYY/MM/DD HH:mm')
    }
  },
})
</script>
