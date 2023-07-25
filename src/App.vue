<template>
  <section class="section">
    <div class="container">
      <h1 class="is-1 title">Tenet Converter</h1>
      <div class="columns">
        <div class="column">
          <div class="box">
            <div class="field">
              <label class="label">Address</label>
              <div class="control">
                <input class="input" v-model="addressInput" type="text" placeholder="tenet1px8tpk4f8t6zxyv8v80ghdle4ujc6jveetl9vd">
              </div>

              <ul v-if="address" class="list">
                <li><b>Address (EIP-55)</b> {{ address.eip55 }}</li>
                <li><b>Bech32 Acc</b> {{ address.acc }}</li>
                <li><b>Bech32 Val</b> {{ address.val }}</li>
              </ul>
            </div>
          </div>
        </div>
        <div class="column">
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
        </div>
        <div class="column">
          Third column
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
import {bech32} from "bech32";
import {ref, watch} from "vue";
import * as eip55 from "eip55";
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

let addressInput = ref("");
let address = ref(null);

watch(addressInput, (val) => {
    try {
      let words = [];

      if (val.startsWith("0x") && val.length === 42 && eip55.verify(val, true)) {
        words = bech32.toWords(hexToBytes(val.substr(2)));
      } else {
        words = bech32.decode(val).words;
      }

      address.value = {
        eip55: eip55.encode("0x" + bytesToHex(bech32.fromWords(words))),
        acc: bech32.encode('tenet', words),
        val: bech32.encode('tenetval', words),
      }
    } catch(e) {
      console.log(e);
      address.value = null;
    }
})

// Convert a hex string to a byte array
function hexToBytes(hex) {
  let bytes = [];
  for (let c = 0; c < hex.length; c += 2)
    bytes.push(parseInt(hex.substr(c, 2), 16));
  return bytes;
}

// Convert a byte array to a hex string
function bytesToHex(bytes) {
  let hex = [];
  for (let i = 0; i < bytes.length; i++) {
    let current = bytes[i] < 0 ? bytes[i] + 256 : bytes[i];
    hex.push((current >>> 4).toString(16));
    hex.push((current & 0xF).toString(16));
  }
  return hex.join("");
}
</script>

<style scoped>
.list {
  white-space: nowrap;
  overflow: scroll;
  max-width: 100%;

  margin-top: 10px;
}

.list b {
  display: block;
}

.list li {
  margin-top: 10px;
}
</style>
