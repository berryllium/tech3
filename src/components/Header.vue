<template>
  <header>
    <div class="container">
      <a to="/" class="menu-btn">
        <span></span>
      </a>
      <nav id="menu">
        <router-link class="menu__item" to="/">Главная</router-link>
        <router-link class="menu__item" to="/about">О нас</router-link>
        <router-link class="menu__item" to="/delivery">Доставка и оплата</router-link>
        <router-link class="menu__item" to="/contacts">Контакты</router-link>
        <router-link class="menu__item" to="/guarantee">Гарантия</router-link>
        <router-link class="menu__item" to="/feedback">Отзывы</router-link>
        <input
          v-model="searchStr"
          @keyup="search"
          type="text"
          name="search"
          id="top-search"
          placeholder="Поиск"
        />
        <router-link class="menu__item" to="/cart">
          <i class="fa fa-shopping-cart" aria-hidden="true">
            <div v-if="getAllCount" class="cart-count">{{getAllCount}}</div>
          </i>
        </router-link>
      </nav>
      <div class="header-info">
        <div class="header-info__item header-logo">
          <a href="/">
            <img src="images/logo.png" />
          </a>
        </div>
        <div class="header-info__item">
          <i class="fa fa-map-marker left-icon" aria-hidden="true"></i>
          <p>{{getContacts.city}}, {{getContacts.street}}</p>
          <p>Доставка по Москве за 2-4 часа</p>
        </div>
        <div class="header-info__item">
          <i class="fa fa-phone left-icon" aria-hidden="true"></i>
          <p>
            <a :href="'tel: '+ getContacts.phone">{{getContacts.phone}}</a>
          </p>
          <!-- <p>
            <a :href="'mailto: '+ getContacts.email">{{getContacts.email}}</a>
          </p>-->
          <div class="soc-icons">
            <a :href="getContacts.whatsapp">
              <i class="fa fa-whatsapp" aria-hidden="true"></i>
            </a>
            <a :href="getContacts.telegram">
              <i class="fa fa-telegram" aria-hidden="true"></i>
            </a>
          </div>
          <div class="call">
            <button class="call-btn" @click="showForm=true">Обратный звонок</button>
          </div>
        </div>
        <div class="header-info__item">
          <i class="fa fa-clock-o left-icon" aria-hidden="true"></i>
          <p>
            Прием заказов и доставка
            <b>{{getContacts.time1}}</b>
          </p>
          <p>
            Самовывоз
            <b>{{getContacts.time2}}</b>
          </p>
          <p>Работаем без выходных</p>
        </div>
      </div>
    </div>
    <CallForm v-if="showForm" @closeForm="closeForm" @call="send($event)" />
  </header>
</template>

<script>
import { mapGetters, mapActions } from "vuex";
import CallForm from "@/components/CallForm";
export default {
  data() {
    return {
      searchStr: "",
      showForm: false
    };
  },
  computed: {
    ...mapGetters(["getAllCount", "getContacts"])
  },
  methods: {
    ...mapActions(["sendMail"]),
    search() {
      this.$store.dispatch("search", this.searchStr);
      if (this.$route.fullPath != "/") this.$router.push("/");
    },
    closeForm(target) {
      if (target == "form-wrap" || target == "form__close")
        this.showForm = false;
    },
    send(user) {
      console.log(user);
      let name = user.name;
      let phone = user.phone;
      let message = `Позвоните покупателю ${name} по номеру телефона ${phone}!`;
      this.sendMail(message);
    }
  },
  mounted() {
    console.log(this.getContacts);
  },
  components: {
    CallForm
  }
};
</script>

<style lang="less" scoped>
@import url("../style/variables.less");
.menu-btn {
  display: none;
  position: absolute;
  z-index: 2;
  justify-content: center;
  top: 10px;
  left: 10px;
  width: 40px;
  height: 40px;
  border-radius: 20px;
  background-color: @blue;

  span,
  span:before,
  span:after {
    position: absolute;
    display: block;
    top: 50%;
    margin-top: -1px;
    left: 50%;
    margin-left: -10px;
    width: 20px;
    height: 2px;
    background-color: #fff;
  }

  span:before,
  span:after {
    content: "";
    transition: 0.5s;
    transform-origin: left bottom;
  }

  span:before {
    transform: translateY(5px);
  }

  span:after {
    transform: translateY(-5px);
  }

  @media (max-width: @phone) {
    display: block;
  }
}
.menu-btn_active {
  span:before,
  span:after {
    width: 10px;
  }

  span:before {
    transform: rotate(45deg);
  }

  span:after {
    transform: rotate(-45deg);
  }
}
#menu {
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 45px;
  border-bottom: 2px solid #e1e1e1;
  .menu__item {
    text-transform: uppercase;
    text-decoration: none;
    font-size: 0.9em;
    color: @grey;
    padding: 0;
    &:hover {
      transform: scale(1.05);
      color: @blue;
    }
    .fa-shopping-cart {
      position: relative;
      font-size: 2em;
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
  #top-search {
    outline: none;
    box-sizing: border-box;
    border: 1px solid lighten(@grey, 30%);
    border-radius: 10px;
    padding: 5px;
    @media (max-width: @phone) {
      display: none;
    }
  }
  @media (max-width: @phone) {
    display: flex;
    display: none;
    position: fixed;
    z-index: 1;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    padding-left: 50px;
    padding-top: 50px;
    background: lighten(@grey, 50%);
    flex-direction: column;
    .menu__item {
      font-size: 1.5em;
      display: block;
      padding: 20px;
      min-width: 250px;
      &:hover {
        transform: scale(1);
        color: @blue;
      }
      .fa-shopping-cart {
        display: none;
      }
    }
  }
}
.header-logo {
  width: 250px;
  img {
    width: 100%;
    height: auto;
    object-fit: contain;
  }
}
.header-info {
  display: flex;
  justify-content: space-between;
  margin: 10px 0 30px 0;
  .header-info__item:not(:first-child) {
    display: flex;
    flex-direction: column;
    position: relative;
    padding-left: 30px;
    p {
      margin-bottom: 10px;
    }
    .left-icon {
      position: absolute;
      font-size: 1.5em;
      top: 0;
      left: 0;
      color: @blue;
    }
    .soc-icons {
      i {
        opacity: 0.8;
        transition-duration: 0.3s;
        font-size: 1.5em;
        margin-right: 10px;
        &.fa-whatsapp {
          color: #11c200;
        }
        &.fa-telegram {
          color: #0088cc;
        }
        &:hover {
          opacity: 1;
        }
      }
    }
    .call {
      margin-top: 5px;
    }
    .call-btn {
      width: 100%;
      transition-duration: 0.3s;
      border-radius: 5px;
      padding: 5px 5px;
      border: 1px solid @blue;
      background: none;
      color: @blue;
      outline: none;
      &:hover {
        cursor: pointer;
        background-color: @blue;
        color: white;
      }
      &:active {
        transform: scale(0.95);
      }
    }
  }
}
</style>
