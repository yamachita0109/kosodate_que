<template>
  <div
    v-for="answer in answers"
    class="p-5"
    :key="answer.id"
  >
    {{ answer.is_best_answer ? 'ベストアンサー' : '' }}
    <p v-html="answer.content.replace(/\n/g, '<br>')"></p>
    <br />
    <div
      v-for="reply in answer.replies"
      :key="reply.id"
    >
      ・{{ reply.content }}
    </div>
    <template
      v-if="qstatus == 'open'"
    >
      <textarea
        v-model="repliesFrom[answer.id]"
      ></textarea>
      <br />
      <button type="button" @click="clickReply(answer.id)">返信</button>
    </template>
    <hr />
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
      repliesFrom: [],
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
