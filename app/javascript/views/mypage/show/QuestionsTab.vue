<template>
  <div class="mb-4 border-b border-gray-200 dark:border-gray-700">
    <ul class="flex flex-wrap -mb-px text-sm font-medium text-center text-gray-500 dark:text-gray-400" id="tabExample" role="tablist">
      <li class="mr-2" role="presentation">
        <button class="inline-block p-4 border-b-2 border-transparent rounded-t-lg hover:text-gray-600 hover:border-gray-300 dark:hover:text-gray-300" id="wip-tab-content" type="button" role="tab" aria-controls="wip-content" aria-selected="false">
          下書き
        </button>
      </li>
      <li class="mr-2" role="presentation">
        <button class="inline-block p-4 border-b-2 border-transparent rounded-t-lg hover:text-gray-600 hover:border-gray-300 dark:hover:text-gray-300" id="open-tab-content" type="button" role="tab" aria-controls="open-content" aria-selected="false">
          質問中
        </button>
      </li>
      <li role="presentation">
        <button class="inline-block p-4 border-b-2 border-transparent rounded-t-lg hover:text-gray-600 hover:border-gray-300 dark:hover:text-gray-300" id="done-tab-content" type="button" role="tab" aria-controls="done-content" aria-selected="false">
          解決済
        </button>
      </li>
    </ul>
  </div>
  <div id="tabContentExample">
    <div class="hidden p-4 rounded-lg" id="wip-content" role="tabpanel" aria-labelledby="wip-tab-content">
      <p
        v-show="!wipQuestions.length"
        class="text-sm text-gray-500"
      >下書きはありません</p>
      <section
        v-show="wipQuestions.length"
        v-for="question in wipQuestions"
        :key="question.id"
        class="text-gray-600 body-font overflow-hidden border-b border-gray-200 pb-4 mb-4"
      >
        <div class="container px-5 py-6 mx-auto">
          <div class="w-full -m-12">
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
    <div class="hidden p-4 rounded-lg " id="open-content" role="tabpanel" aria-labelledby="open-tab-content">
      <p
        v-show="!openQuestions.length"
        class="text-sm text-gray-500"
      >質問中はありません</p>
      <section
        v-show="openQuestions.length"
        v-for="question in openQuestions"
        :key="question.id"
        class="text-gray-600 body-font overflow-hidden border-b border-gray-200 pb-4 mb-4"
      >
        <div class="container px-5 py-6 mx-auto">
          <div class="w-full -m-12">
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
    <div class="hidden p-4 rounded-lg" id="done-content" role="tabpanel" aria-labelledby="done-tab-content">
      <p
        v-show="!doneQuestions.length"
        class="text-sm text-gray-500"
      >解決済みはありません</p>
      <section
        v-for="question in doneQuestions"
        v-show="doneQuestions.length"
        :key="question.id"
        class="text-gray-600 body-font overflow-hidden border-b border-gray-200 pb-4 mb-4"
      >
        <div class="container px-5 py-6 mx-auto">
          <div class="w-full -m-12">
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
import { Question } from 'app/javascript/@types/question';

export default defineComponent({
  components: {
  },
  data() {
    return {
      wipQuestions: [] as Question[],
      openQuestions: [] as Question[],
      doneQuestions: [] as Question[],
    }
  },
  async mounted() {
    const tabElements: TabItem[] = [
      {
        id: 'wip',
        triggerEl: document.querySelector('#wip-tab-content')!,
        targetEl: document.querySelector('#wip-content')!
      },
      {
        id: 'open',
        triggerEl: document.querySelector('#open-tab-content')!,
        targetEl: document.querySelector('#open-content')!
      },
      {
        id: 'done',
        triggerEl: document.querySelector('#done-tab-content')!,
        targetEl: document.querySelector('#done-content')!
      }
    ]

    const options = {
      defaultTabId: 'settings',
      activeClasses: 'text-green-600 hover:text-green-600 dark:text-green-500 dark:hover:text-green-400 border-b-2 border-green-600 dark:border-green-500',
      inactiveClasses: 'text-gray-500 hover:text-gray-600 dark:text-gray-400 border-gray-100 hover:border-gray-300 dark:border-gray-700 dark:hover:text-gray-300',
    }
    new Tabs(tabElements, options);
    const data = await this.getQuestion()
    this.wipQuestions = data.filter((d) => d.status == 'wip')
    this.openQuestions = data.filter((d) => d.status == 'open')
    this.doneQuestions = data.filter((d) => d.status == 'done')
  },
  methods: {
    async getQuestion(): Promise<Question[]> {
      const res = await axios.get('/api/question', { params: { is_self: true } })
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
