<template>
  <div class="mb-4 border-b border-gray-200 dark:border-gray-700">
    <ul class="flex flex-wrap -mb-px text-sm font-medium text-center text-gray-500 dark:text-gray-400" role="tablist">
      <li class="mr-2" role="presentation">
        <button class="inline-block p-4 border-b-2 border-transparent rounded-t-lg hover:text-gray-600 hover:border-gray-300 dark:hover:text-gray-300" id="question-tab-content" type="button" role="tab" aria-controls="question-content" aria-selected="false">
          質問履歴
        </button>
      </li>
      <li role="presentation">
        <button class="inline-block p-4 border-b-2 border-transparent rounded-t-lg hover:text-gray-600 hover:border-gray-300 dark:hover:text-gray-300" id="answer-tab-content" type="button" role="tab" aria-controls="answer-content" aria-selected="false">
          回答した質問
        </button>
      </li>
    </ul>
  </div>
  <div>
    <div class="hidden p-4 rounded-lg" id="question-content" role="tabpanel" aria-labelledby="question-tab-content">
      <p
        v-show="!questions.length"
        class="text-sm text-gray-500"
      >質問はありません</p>
      <section
        v-show="questions.length"
        v-for="question in questions"
        :key="question.id"
        class="text-gray-600 body-font overflow-hidden border-b border-gray-200 pb-4 mb-4"
      >
        <div class="container">
          <div class="w-full">
            <div class="p-8 flex flex-col items-start">
              <h2 class="text-xl title-font font-medium text-gray-900 mb-2"><a :href="`/question/${question.id}`">{{ question.title }}</a></h2>
              <span>
                <span
                  v-for="tag in question.tags.split(',')"
                  :key="tag"
                  class="py-1 px-2 rounded bg-green-50 text-green-500 text-xs font-medium tracking-widest mr-1"
                >{{ tag }}</span>
              </span>
              <p class="leading-relaxed">
                {{ content(question.content) }}
              </p>
            </div>
          </div>
        </div>
      </section>
    </div>
    <div class="hidden p-4 rounded-lg" id="answer-content" role="tabpanel" aria-labelledby="answer-tab-content">
      <p
        v-show="!answerQuestions.length"
        class="text-sm text-gray-500"
      >回答した質問はありません</p>
      <section
        v-for="question in answerQuestions"
        v-show="answerQuestions.length"
        :key="question.id"
        class="text-gray-600 body-font overflow-hidden border-b border-gray-200 pb-4 mb-4"
      >
        <div class="container">
          <div class="w-full">
            <div class="p-8 flex flex-col items-start">
              <h2 class="text-xl title-font font-medium text-gray-900 mb-2"><a :href="`/question/${question.id}`">{{ question.title }}</a></h2>
              <span>
                <span
                  v-for="tag in question.tags.split(',')"
                  :key="tag"
                  class="py-1 px-2 rounded bg-green-50 text-green-500 text-xs font-medium tracking-widest mr-1"
                >{{ tag }}</span>
              </span>
              <p class="leading-relaxed">
                {{ content(question.content) }}
              </p>
            </div>
          </div>
        </div>
      </section>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import axios from 'axios'
import { Tabs } from 'flowbite';
import type { TabItem } from 'flowbite';
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
    const tabElements: TabItem[] = [
      {
        id: 'wip',
        triggerEl: document.querySelector('#question-tab-content')!,
        targetEl: document.querySelector('#question-content')!
      },
      {
        id: 'done',
        triggerEl: document.querySelector('#answer-tab-content')!,
        targetEl: document.querySelector('#answer-content')!
      }
    ]

    const options = {
      defaultTabId: 'settings',
      activeClasses: 'text-green-600 hover:text-green-600 dark:text-green-500 dark:hover:text-green-400 border-b-2 border-green-600 dark:border-green-500',
      inactiveClasses: 'text-gray-500 hover:text-gray-600 dark:text-gray-400 border-gray-100 hover:border-gray-300 dark:border-gray-700 dark:hover:text-gray-300',
    }
    new Tabs(tabElements, options)  },
  methods: {
    async getQuestion(param = {}): Promise<Question[]> {
      const res = await axios.get('/api/question', { params: param })
      return res.data.rows
    },
    content(str): string {
      if (str.length > 60) {
        return str.slice(0, 60) + "..."
      } else {
        return str
      }
    },
  },
})
</script>
