<template>
  <div class="p-5">
    <button
      type="button"
      @click="clickAiAnswer()"
      class="inline-flex text-white bg-blue-500 border-0 py-2 px-6 focus:outline-none hover:bg-blue-600 rounded text-base"
    >子育てAIに聞いてみる</button>
    <p>
      {{ answer }}
    </p>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import axios from 'axios'

export default defineComponent({
  components: {
  },
  data() {
    return {
      // question_id
      id: location.pathname.split('/').pop(),
      answer: '' as string,
    }
  },
  methods: {
    async clickAiAnswer() {
      this.answer = await this.getAnswer()
    },
    async getAnswer(): Promise<string> {
      const res = await axios.get('/api/ai/answer', { params: { question_id: this.id } })
      return res.data.message
    },
  },
})
</script>
