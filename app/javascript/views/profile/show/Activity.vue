<template>
  <div>
    <h3>質問</h3>
    <div
      v-for="question in questions"
      :key="question.id"
    >{{ question.title }}</div>
    <h3>回答した</h3>
    <div
      v-for="question in answerQuestions"
      :key="question.id"
    >{{ question.title }}</div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import axios from 'axios'
import { Question } from '../../../@types/question'

export default defineComponent({
  data() {
    return {
      // user_id
      id: location.pathname.split('/').pop(),
      questions: [] as Question[],
      answerQuestions: [] as Question[],
    }
  },
  async created() {
    this.questions = await this.getQuestion({ user_id: this.id })
    this.answerQuestions = await this.getQuestion({ answer_user_id: this.id })
  },
  mounted() {
  },
  methods: {
    async getQuestion(param = {}): Promise<Question[]> {
      const res = await axios.get('/api/question', { params: param })
      return res.data.rows
    },
  },
})
</script>
