<template>
  <p>
    <input
      ref='tags'
      v-model="tags"
      @change="changeTags"
      class="w-full bg-white rounded border border-gray-300 focus:border-green-500 focus:ring-2 focus:ring-green-200 text-base outline-none text-gray-700 py-1 px-3 leading-8 transition-colors duration-200 ease-in-out"
    >
  </p>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import axios from 'axios'
// @see https://yaireo.github.io/tagify/
import Tagify from '@yaireo/tagify'
import '@yaireo/tagify/dist/tagify.css'

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
      tags: '',
    }
  },
  async mounted() {
    this.tags = this.inputForm.value
    const res = await this.getTags()
    const tags = res?.data?.rows ?? []
    const inputInside = this.$refs.tags
    new Tagify(inputInside, { whitelist: tags })
  },
  methods: {
    async getTags() {
      // TODO API client.
      return await axios.get('/api/tags')
    },
    changeTags(e) {
      const val = e.target.value
      if (val) {
        this.inputForm.value = JSON.parse(val).map((v) => v.value).join(',')
      } else {
        this.inputForm.value = ''
      }
    }
  },
})
</script>