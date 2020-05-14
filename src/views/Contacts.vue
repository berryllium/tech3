<template>
  <div class="content">
    <h1>Контакты</h1>
    <div class="contacts">
      <div class="address">
        <div class="info__item">
          <i class="fa fa-map-marker left-icon" aria-hidden="true"></i>
          <p>{{getContacts.city}}, {{getContacts.street}}</p>
        </div>
        <div class="info__item">
          <i class="fa fa-phone left-icon" aria-hidden="true"></i>
          <p>
            <a :href="'tel: '+ getContacts.phone">{{getContacts.phone}}</a>
          </p>
          <div class="soc-icons">
            <a :href="getContacts.whatsapp">
              <i class="fa fa-whatsapp" aria-hidden="true"></i>
            </a>
            <a :href="getContacts.telegram">
              <i class="fa fa-telegram" aria-hidden="true"></i>
            </a>
          </div>
        </div>
        <div class="info__item">
          <i class="fa fa-envelope-o left-icon" aria-hidden="true"></i>
          <p><a :href="'mailto: '+ getContacts.email">{{getContacts.email}}</a></p>
        </div>
        <div class="info__item">
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
      <div v-if="this.$parent.small" class="map">
        <iframe src="https://yandex.ru/map-widget/v1/?um=constructor%3Af1ee48f526c937a08a9f4716c0d01103b6a37a027f1f39c5f92f73c0b9a84252&amp;source=constructor" width=100% height="350" frameborder="0"></iframe>
      </div>
      <div v-else class="map">
        <iframe src="https://yandex.ru/map-widget/v1/?um=constructor%3Af1ee48f526c937a08a9f4716c0d01103b6a37a027f1f39c5f92f73c0b9a84252&amp;source=constructor" width="550" height="350" frameborder="0"></iframe>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from "vuex";
export default {
  computed: {
    ...mapGetters(["getContacts"])
  }
};
</script>

<style lang="less" scoped>
@import url("../style/variables.less");
.contacts {
  display: flex;
  justify-content: space-between;
  @media (max-width: @phone) {
    flex-direction: column-reverse;
  }
}
.info__item {
  color: @grey;
  margin-bottom: 30px;
  display: flex;
  flex-direction: column;
  position: relative;
  padding-left: 50px;
  font-size: 1.1em;
  @media (max-width: @phone) {
    font-size: 0.9em;
  }
  p {
    margin: 4px 0;
  }
  .left-icon {
    position: absolute;
    font-size: 1.5em;
    top: 0;
    left: 0;
    color: @blue;
  }
  .soc-icons {
    margin-top: 15px;
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
}
</style>