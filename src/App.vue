<template>
  <div id="app">
    <Header />
    <main v-if="!loadingState" class="container">
      <Catalog />
      <router-view />
    </main>
    <Footer />
  </div>
</template>

<script>
import Header from "@/components/Header";
import Catalog from "@/components/Catalog";
import Footer from "@/components/Footer";
import { mapGetters, mapActions, mapMutations } from "vuex";
export default {
  data: {
    small: false
  },
  computed: {
    ...mapGetters(["loadingState"])
  },
  components: {
    Header,
    Footer,
    Catalog
  },
  methods: {
    ...mapActions(["fetchCatalog", "fetchFeedbacks"]),
    onResize() {
        this.small = window.innerWidth <= 760;
    }
  },
  created() {
    window.addEventListener('resize', this.onResize);
    this.onResize();
    this.fetchCatalog();
    this.fetchFeedbacks();
  },
  destroyed() {
    window.removeEventListener('resize', this.onResize)
  },
  mounted() {
    var $ = require("jquery");
    window.jQuery = $;
    $(".menu-btn").on("click", function(e) {
      e.preventDefault();
      $(this).toggleClass("menu-btn_active");
      $("nav").animate({ width: "toggle" }, 350);
    });
    if (screen.width < 768) {
      $(".menu__item").on("click", () => {
        $(".menu-btn").trigger("click");
      });
    }
  }
};
</script>

<style lang="less">
@import url("style/font-awesome.min.css");
@import url("style/jquery.fancybox.css");
@import url("style/normalize.css");
@import url("style/variables.less");
@import url("style/main.less");
</style>
