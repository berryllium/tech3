<template>
  <aside class="catalog">
    <div class="catalog__header" @click="toggleCatalog" v-if="this.$parent.small">
      <div class="left">
        <i class="fa fa-bars"></i>
        <div class="catalog__title">Каталог товаров</div>
      </div>
      <router-link class="right" to="/cart">
        <i class="fa fa-shopping-cart" aria-hidden="true">
          <div v-if="getAllCount" class="cart-count">{{getAllCount}}</div>
        </i>
      </router-link>
    </div>
    <div class="catalog__header" @click="toggleCatalog" v-else>
      <div class="catalog__title">Каталог товаров</div>
      <i class="fa fa-bars"></i>
    </div>

    <ul class="catalog__list" @click="closeMenu" v-if="showCatalog">
      <catalog-sub
        :showMenu="showMenu"
        v-for="category in allCategories"
        :category="category"
        :key="category.name"
      />
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
      showMenu: true,
      showCatalog: true
    };
  },
  computed: {
    ...mapGetters(["allCategories", "getAllCount"])
  },
  methods: {
    closeMenu() {
      this.showMenu = false;
      setTimeout(() => (this.showMenu = true), 1000);
      this.toggleCatalog();
    },
    toggleCatalog() {
      if (event.target.classList.contains("fa-shopping-cart")) this.showCatalog = false
      else if (this.$parent.small) {
        this.showCatalog = !this.showCatalog;
      }
    }
  },
  mounted() {
    if (this.$parent.small) {
      this.showCatalog = false;
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
    .left {
      display: flex;
      .fa {
        margin-right: 5px;
      }
    }
  }

  &__title {
    text-transform: uppercase;
  }

  &__list {
    list-style-type: none;
    padding: 0px;
  }
}

@media (max-width: @phone) {
  .catalog {
    width: 100%;
    &__header {
      padding: 10px;
      align-items: center;
    }
  }
  .fa-shopping-cart {
      position: relative;
      font-size: 1.6em;
      margin-right: 15px;
      .cart-count {
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 0.6em;
        width: 20px;
        height: 20px;
        border-radius: 20px;
        color: white;
        background-color: @blue;
        position: absolute;
        right: -10px;
        top: -5px;
      }
    }
}
</style>