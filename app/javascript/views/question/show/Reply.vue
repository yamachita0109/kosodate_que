<template>
  <div class="flex flex-col gap-5 m-3">
    <!-- Comment Container -->
    <div
      v-for="answer in answers"
      :key="answer.id"
    >
      <div
        class="flex w-full justify-between border rounded-md"
      >
        <div class="p-3 w-full">
          <div class="flex gap-3 items-center">
            <img src="https://avatars.githubusercontent.com/u/22263436?v=4" class="object-cover w-10 h-10 rounded-full border-2 border-emerald-400  shadow-emerald-400">
            <h3 class="font-bold">
              User 1
              <br>
              <span class="text-sm text-gray-400 font-normal">2023/06/09 23:29</span>
            </h3>
          </div>
          {{ answer.is_best_answer ? 'ベストアンサー' : '' }}
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
              <img src="https://avatars.githubusercontent.com/u/22263436?v=4" class="object-cover w-10 h-10 rounded-full border-2 border-emerald-400  shadow-emerald-400">
              <h3 class="font-bold">User 2<br><span class="text-sm text-gray-400 font-normal">Level 1</span></h3>
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
    }
  },
})
</script>
