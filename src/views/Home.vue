<template>
  <div class="content">
    <ul class="filters" v-if="countCategory">
      <li class="filter">
        <div class="filter__name">Цена</div>
        <div class="filter__content">
          <label>
            <span class="filter__label">От</span>
            <input
              @change="filterCategory(filters)"
              @keyup="filterCategory(filters)"
              v-model="filters.priceMin"
              type="number"
              placeholder="от"
            />
          </label>
          <label>
            <span class="filter__label">До</span>
            <input
              @change="filterCategory(filters)"
              @keyup="filterCategory(filters)"
              v-model="filters.priceMax"
              type="number"
              placeholder="до"
            />
          </label>
        </div>
      </li>
      <li class="filter" v-for="(spec, index) in filters.specifications" :key="spec.name">
        <div class="filter__name">{{spec.name}}</div>
        <div class="filter__content">
          <label>
            <span class="filter__label">От</span>
            <input
              @change="filterCategory(filters)"
              @keyup="filterCategory(filters)"
              v-model.number="filters.specifications[index].min"
              type="number"
              placeholder="от"
            />
          </label>
          <label>
            <span class="filter__label">До</span>
            <input
              @change="filterCategory(filters)"
              @keyup="filterCategory(filters)"
              v-model.number="filters.specifications[index].max"
              type="number"
              placeholder="до"
            />
          </label>
        </div>
      </li>
    </ul>
    <div class="products">
      <product v-for="product in filteredCatalog" :product="product" :key="product.id" />
    </div>
  </div>
</template>

<script>
import Product from "@/components/Product";
import { mapGetters, mapMutations } from "vuex";
export default {
  data() {
    return {
      haveProps: false,
      filters: {
        priceMax: 999999,
        priceMin: 0,
        specifications: [
          // {
          //   name: 'Мощность',
          //   min: 0,
          //   max: 10000
          // },
          // {
          //   name: 'Шум',
          //   min: 0,
          //   max: 100
          // }
        ]
      }
    };
  },
  methods: {
    ...mapMutations(["filterCategory"])
  },
  computed: {
    ...mapGetters(["filteredCatalog", "currentCategory", "countCategory"])
  },
  watch: {
    currentCategory: function(val) {
      this.filters.specifications = [];
      if (val && this.filteredCatalog.length) {
        if (this.filteredCatalog[0].hasOwnProperty("spec")) {
          if (this.filteredCatalog[0].spec.length) {
            console.log(this.filteredCatalog[0]);
            this.haveProps = true;
            this.filteredCatalog[0].spec.forEach(element => {
              if (element.filter == 1) {
                let filter = {
                  name: element.prop,
                  min: 100000,
                  max: 0
                };
                this.filteredCatalog.forEach(element => {
                  const prop = element.spec.find(el => el.prop == filter.name);
                  if (prop.value <= filter.min) filter.min = prop.value;
                  if (prop.value >= filter.max) filter.max = prop.value;
                });
                this.filters.specifications.push(filter);
              }
            });
          } else this.haveProps = false;
        }
      }
      console.log(this.haveProps);
    }
  },
  components: {
    product: Product
  }
};
</script>

<style lang="less" scoped>
@import url("../style/variables.less");
.products {
  display: grid;
  gap: 25px;
  grid-template-columns: repeat(4, 1fr);
  @media (max-width: @phone) {
    gap: 5px;
    grid-template-columns: repeat(2, 1fr);
  }
}
.filters {
  padding: 0;
  margin: 0 0 20px 0;
  display: flex;
  flex-wrap: wrap;
}
.filter {
  display: flex;
  align-items: center;
  margin-right: 22px;
  margin-bottom: 15px;
  &__name {
    text-transform: capitalize;
    margin-top: 5px;
  }
  &__label {
    position: absolute;
    top: 2px;
    left: 10px;
    color: grey;
    display: inline-block;
  }
  &__content {
    display: flex;
    label {
      position: relative;
      margin-top: 5px;
    }
    input {
      margin-left: 5px;
      text-align: right;
      box-sizing: border-box;
      width: 125px;
    }
  }
}
</style>