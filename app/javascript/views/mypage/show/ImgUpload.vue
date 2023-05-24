<template>
  <div>
    <h3>画像を選択</h3>
    <input
      type="file"
      accept="image/*"
      @change="setImage"
    >
    <br>
    <div
      v-if="imgSrc != null"
      style="width: 200px; height:200px; border: 1px solid gray; display: inline-block;"
    >
      <vue-cropper
        ref="cropper"
        :guides="true"
        :view-mode="2"
        drag-mode="crop"
        :auto-crop-area="0.5"
        :min-container-width="200"
        :min-container-height="200"
        :background="true"
        :rotatable="false"
        :src="imgSrc"
        :img-style="{ 'width': '200px', 'height': '200px' }"
        :aspect-ratio="2 / 2"
      >
      </vue-cropper>
    </div>
    <br>

    <button
      type="button"
      @click="cropImage"
      v-if="imgSrc != null"
    >トリミングする</button>

    <div
      v-if="cropImg != null"
    >
      <img
        :src="cropImg"
        style="width: 200px; height: 200px; border: 1px solid gray;"
        alt="Cropped Image"
      >
      <button type="submit">画像を登録</button>
    </div>
    <input
      ref="logo"
      type="hidden"
      name="logo"
    >
  </div>

</template>

<script lang="ts">
import { defineComponent } from 'vue'
// TODO 整理
import '~/../../../node_modules/cropperjs/dist/cropper.js'
import '~/../../../node_modules/cropperjs/dist/cropper.css'
import VueCropper from 'vue-cropperjs';
import 'cropperjs/dist/cropper.css';

// TODO リファクタリング
export default defineComponent({
  components: {
    VueCropper
  },
  data() {
    return {
      imgSrc: null as any,
      filename: null as any,
      cropImg: null as any
    }
  },
  mounted() {
  },
  methods: {
    setImage(e) {
      const file = e.target.files[0]
      this.filename = file.name
      const reader = new FileReader()
      reader.onload = event => {
        this.imgSrc = event!.target!.result ?? null
        ;(this.$refs as any).cropper.replace(event!.target!.result)
      }
      reader.readAsDataURL(file)
    },
    cropImage() {
      const dataurl = (this.$refs as any).cropper.getCroppedCanvas().toDataURL()
      this.cropImg = dataurl
      ;(this.$refs as any).logo.value = dataurl
    }
  },
})
</script>
