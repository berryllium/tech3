<template>
  <div class="modal" @click="close">
    <div class="bg"></div>
    <div class="form-wrap">
      <form class="form" @submit.prevent="onSubmit">
        <div class="form__close">&times;</div>
        <h3 class="form__header">Обратный звонок</h3>
        <div v-if="done" class="form__done">
          Спасибо за заявку!
          <br />Мы с вами свяжемся!
        </div>
        <div v-else class="form__content">
          <div class="form__user">
            <label for="name">Ваше имя</label>
            <input v-model="user.name" 
              type="name" 
              class="form__name" 
              name="name" 
              placeholder="Имя" />
            <label for="phone">Ваш телефон</label>
            <input
              v-model="user.phone"
              type="phone"
              class="form__phone"
              name="phone"
              placeholder="Номер телефона"
            />
          </div>
        <input type="submit" class="form__button" name="order" value="Заказать звонок" />
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import { mapActions } from 'vuex';
export default {
  data() {
    return {
      user: {
        name: "",
        phone: ""
      },
      done: false
    };
  },
  methods: {
    onSubmit() {
      this.done = true;
      this.$emit('call', this.user)
    },
    close() {
      this.$emit("closeForm", event.target.className);
    }
  }
};
</script>

<style lang="less" scoped>
@import url("../style/variables.less");
.modal {
  position: fixed;
  width: 100vw;
  height: 100vh;
  top: 0;
  left: 0;
  z-index: 1;
}
.form-wrap {
  position: absolute;
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 100%;
}
.bg {
  position: absolute;
  background-color: black;
  opacity: 0.5;
  width: 100%;
  height: 100%;
}
.form {
  position: relative;
  margin: 0 auto;
  padding: 20px;
  width: 30%;
  background-color: #fff;
    @media (max-width: @phone) {
    width: 100%;
  }
  &__close {
    cursor: pointer;
    font-size: 1.5em;
    position: absolute;
    padding: 15px;
    top: 0;
    right: 0;
  }
  &__header {
    margin: 20px 0;
  }
  &__done {
    width: 100%;
    height: 100px;
    display: flex;
    justify-content: center;
    align-items: center;
    text-transform: uppercase;
    text-align: center;
    color: @blue;
    font-size: 1.2em;
  }
  input,
  textarea {
    box-sizing: border-box;
    width: 100%;
    padding: 5px;
    margin: 5px 0 10px 0;
  }
  &__button {
    display: block;
    margin-top: 20px;
    text-align: center;
    border: none;
    outline: none;
    padding: 10px;
    background-color: @blue;
    color: white;
    &:hover {
      cursor: pointer;
      background-color: darken(@blue, 10%);
    }
    &:active {
      transform: scale(0.95);
    }
  }
}
</style>