<template>
  <div
    v-for="answer in answers"
    :key="answer.id"
  >
    {{ answer.content }}
    <br />
      <div
        v-for="reply in answer.replies"
        :key="reply.id"
      >
        ・{{ reply.content }}
      </div>
    <textarea v-model="repliesFrom[answer.id]"></textarea>
    <br />
    <button type="button" @click="clickReply(answer.id)">返信</button>
    <hr />
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import axios from 'axios'
import { Answer } from '../../../@types/answer'

export default defineComponent({
  components: {
  },
  data() {
    return {
      id: location.pathname.split('/').pop(),
      answers: [] as Answer[],
      repliesFrom: [],
    }
  },
  async created() {
    const res = await this.getAnswer()
    this.answers = res.data.rows
  },
  methods: {
    async clickReply(id) {
      const text = this.repliesFrom[id]
      await this.postReply(id, text)
      const res = await this.getAnswer()
      this.answers = res.data.rows
    },
    async getAnswer() {
      // TODO API client.
      return await axios.get('/api/answer', { params: { question_id: this.id, order: '' } })
    },
    async postReply(id, text) {
      // TODO API client.
      await axios.post('/api/reply', { answer_id: id, content: text })
    }
  },
})
</script>
