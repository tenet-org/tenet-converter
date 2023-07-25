import { createApp } from 'vue'
import App from './App.vue'

import 'bulma/bulma.sass'

import { Buffer } from 'buffer';

// @ts-ignore
window.Buffer = Buffer;

createApp(App).mount('#app')
