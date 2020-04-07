<template>
  <aside class="catalog" @click="closeMenu">
    <div class="catalog__header">
      <div class="catalog__title">Каталог товаров</div>
      <i class="fa fa-bars"></i>
    </div>
    <ul class="catalog__list">
      <catalog-sub :showMenu="showMenu" v-for="category in allCategories" :category="category" :key="category.name" />
    </ul>
  </aside>
</template>
<script>
import CatalogSubMenu from "@/components/CatalogSubMenu";
import { mapGetters } from "vuex";
export default {
  components: {
    "catalog-sub": CatalogSubMenu
  },
  data() {
    return {
      showMenu: true
    };
  },
  computed: {
    ...mapGetters(["allCategories"])
  },
  methods: {
    closeMenu() {
      this.showMenu = false;
      setTimeout(() => (this.showMenu = true), 200);
    }
  }
};
</script>
<style lang="less" scoped>
@import url("../style/variables.less");
.catalog {
  box-sizing: border-box;
  position: relative;
  width: @catalogW;
  height: 100%;
  border: 1px solid @bg;
  box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.16);

  &__header {
    background-color: #f3c10c;
    color: black;
    display: flex;
    justify-content: space-between;
    padding: 15px;
  }

  &__title {
    text-transform: uppercase;
  }

  &__list {
    list-style-type: none;
    padding: 0px;
  }
}
</style>