import Vue from 'vue/dist/vue.esm';
import axios from 'axios';

axios.defaults.headers.common['X-CSRF-Token'] = document
  .querySelector('meta[name="csrf-token"]')
  .getAttribute('content');

new Vue({
  el: '#SerialsIndex',
  data: {
    serials: [],
    subscriptions: {}
  },
  mounted: function(){
    var vm = this;

    axios.get(
      '/subscriptions'
    ).then(function(response){
      vm.subscriptions = response.data;
    })
  },
  methods: {
    search: (function(){
      var timer_id = null;

      return function(event){
        clearTimeout(timer_id);
        var vm = this;

        timer_id = setTimeout(function(){
          axios.get(
            '/serials',
            {
              params: { query: event.target.value }
            }
          ).then(function(response){
            vm.serials = response.data;
          })
        }, 1000);
      };
    })(),
    subscribe: function(serial_id){
      var vm = this;

      axios.post(
        '/subscriptions',
        {
          serial_id: serial_id
        }
      ).then(function(response){
        Vue.set(vm.subscriptions, serial_id, true);
      })
    },
    unsubscribe: function(serial_id){
      var vm = this;

      axios.delete(
        '/subscriptions',
        {
          params: {
            serial_id: serial_id
          }
        }
      ).then(function(response){
        Vue.set(vm.subscriptions, serial_id, false);
      })
    }
  }
});
