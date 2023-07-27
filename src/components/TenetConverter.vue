<template>
  <div class="box">
    <div class="field">
      <label class="label">TENET</label>
      <div class="control">
        <input class="input" v-model="tenetInput" type="text" placeholder="0">
      </div>
    </div>

    <div class="field">
      <label class="label">aTENET</label>
      <div class="control">
        <input class="input" v-model="atenetInput" type="text" placeholder="0">
      </div>
    </div>
  </div>
</template>

<script setup>
import {ref, watch} from "vue";
import web3 from "web3";

let tenetInput = ref("");
let atenetInput = ref("");

watch(tenetInput, (val) => {
  try {
    atenetInput.value = web3.utils.toWei(val, "ether");
  } catch(e) {
    console.log(e);
    atenetInput.value = "";
  }
})

watch(atenetInput, (val) => {
  try {
    tenetInput.value = web3.utils.fromWei(val, "ether");
  } catch(e) {
    console.log(e);
    tenetInput.value = "";
  }
})
</script>
