<template>
  <div class="default">
    <LayoutHeader />
    <LayoutMenu />
    <slot />
    <LayoutFooter />
    <UiFormPopup />
  </div>
</template>

<style lang="scss" scoped>
.default {
  background-color: #1d1d1d;
  color: #fff;
}
</style>
