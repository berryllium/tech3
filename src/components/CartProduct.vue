<template>
  <div class="cart-product">
    <router-link :to="'/product'+ id " class="cart-product__img">
      <img
        :src="`db/images/products/small/${product.id}/${product.photos[0].src}`"
        alt="photo"
        class="cart-product__img"
      />
    </router-link>
    <router-link :to="'/product'+ id " class="cart-product__name">{{product.title}}</router-link>
    <div class="cart-product__count">
      <div v-if="this.$parent.$parent.small" class="cart-product__minus" @click="minus">-</div>
      <input
        type="number"
        min="1"
        name="count"
        class="cart-product__input"
        autocomplete="off"
        v-model.number="count"
        onkeypress="return false"
        @change="changeCount"
      />
      <label for="count">шт.</label>
      <div v-if="this.$parent.$parent.small" class="cart-product__plus" @click="plus">+</div>
    </div>
    <div class="cart-product__bottom" v-if="this.$parent.$parent.small">
      <div v-if="!this.$parent.$parent.small" class="cart-product__price">{{product.price_new}} руб.</div>
      <div class="cart-product__price"><span v-if="this.$parent.$parent.small">Цена: </span>{{price}} руб.</div>
      <button class="cart-product__remove" @click="rem">&times;</button>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapMutations } from "vuex";
export default {
  data() {
    return {
      count: 1
    };
  },
  props: ["id"],
  computed: {
    product() {
      return this.$store.getters.oneProduct(this.id);
    },
    price() {
      return this.count * this.product.price_new;
    }
  },
  methods: {
    ...mapMutations(["getCount", "setCount", "removeFromCart"]),
    changeCount() {
      this.setCount({ id: this.id, count: this.count });
    },
    rem() {
      this.removeFromCart(this.id);
    },
    plus() {
      this.count++;
      this.changeCount();
    },
    minus() {
      if (this.count > 0) this.count--;
      this.changeCount();
    }
  },
  mounted() {
    this.count = this.$store.getters.getCount(this.id);
  }
};
</script>

<style lang="less" scoped>
@import url("../style/variables.less");
.cart-product {
  display: grid;
  grid-template-columns: 20% 25% 20% 15% 15% 5%;
  align-items: center;
  margin-bottom: 20px;
  &__img {
    width: 150px;
    height: 150px;
    object-fit: contain;
  }
  &__name {
    font-size: 1.2em;
  }
  &__input {
    width: 50px;
  }
  &__remove {
    margin-left: auto;
    border: none;
    outline: none;
    display: flex;
    justify-content: center;
    align-items: center;
    width: 30px;
    height: 30px;
    font-size: 1.5em;
    background: @grey;
    border-radius: 50%;
    color: white;
    &:hover {
      cursor: pointer;
      background-color: red;
    }
    &:active {
      transform: scale(0.95);
    }
  }
}

@media (max-width: @phone) {
  .cart-product {
    display: flex;
    flex-direction: column;
    &__count {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 10px;
      width: 230px;
    }
    &__plus,
    &__minus {
      width: 30px;
      height: 30px;
      border-radius: 15px;
      display: flex;
      align-items: center;
      justify-content: center;
      background-color: @blue;
      color: white;
    }
    &__bottom {
      padding: 10px;
      display: flex;
      align-items: center;
      width: 230px;
      justify-content: space-between;
    }
  }
}
</style>