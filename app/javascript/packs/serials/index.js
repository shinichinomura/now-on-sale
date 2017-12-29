import Vue from 'vue/dist/vue.esm';
import axios from 'axios';

new Vue({
  el: '#SerialsIndex',
  methods: {
    search: (function(event){
      var timer_id = null;

      return function(event){
        clearTimeout(timer_id);

        timer_id = setTimeout(function(){
          axios.get(
            '/serials',
            {
              params: { query: event.target.value }
            }
          ).then(function(response){
            console.log(response.data);
          })
        }, 1000);
      };
    })()
  }
});
