<template>
  <NavbarComponent />

  <section class="mt-5">
    <div class="container">
      <div class="columns">
        <div class="column">
          <AddressConverter/>
        </div>
        <div class="column">
          <TenetConverter/>
        </div>
        <div class="column"></div>
      </div>
    </div>
  </section>
</template>

<script setup>
import AddressConverter from "@/components/AddressConverter.vue";
import NavbarComponent from "@/components/NavbarComponent.vue";
import TenetConverter from "@/components/TenetConverter.vue";
</script>
