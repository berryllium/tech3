import $ from 'jquery'

export default {
  actions: {
    sendMail(ctx, message) {
      $.ajax({
        type: "POST",
        url: "/admin/index.php?page=api&act=mail",
        data: {
          message: message
        },
        success: function (msg) { 
          console.log(msg)
        }
      })
    },
    sendCart(ctx, user) {
      $.ajax({
        type: "POST",
        url: "/admin/index.php?page=api&act=order",
        data: {
          user: user,
          cart: ctx.state.cart
        },
        success: function (msg) { 
          console.log(msg)
          ctx.commit('clearCart')
        }
      })
    },
  quickBuy(ctx, order) {
    console.log(order)
    $.ajax({
      type: "POST",
      url: "/admin/index.php?page=api&act=order",
      data: {
        user: order.user,
        cart: [{id: order.id_prod, count: 1}]
      },
      success: function (msg) { 
        (msg)
      }
    })
  }
},
  mutations: {
    addToCart(state, id) {
      let product = state.cart.find(el => el.id === id)
      if (product) product.count++
      else {
        product = { id: id, count: 1 }
        state.cart.push(product)
      }
      state.jsonCart = JSON.stringify(state.cart)
    },
    setCount(state, item) {
      let product = state.cart.find(el => el.id === item.id)
      if (item.count > 0) product.count = item.count
      state.jsonCart = JSON.stringify(state.cart)
    },
    removeFromCart(state, id) {
      state.cart = state.cart.filter(el => el.id !== id)
      state.jsonCart = JSON.stringify(state.cart)
    },
    setCart(state) {
      state.cart = JSON.parse(state.jsonCart)
    },
    clearCart(state) {
      state.cart = []
      state.jsonCart = JSON.stringify(state.cart)
    }
  },
  state: {
    cart: [],
    jsonCart: "[]"
  },
  getters: {
    allCart(state) {
      return state.cart
    },
    getJsonCart(state) {
      return state.jsonCart
    },
    getCount: (state) => (id) => {
      return state.cart.find(element => element.id == id).count
    },
    getAllCount: (state) => {
      return state.cart.length ? state.cart.length : ''
    }
  }
}