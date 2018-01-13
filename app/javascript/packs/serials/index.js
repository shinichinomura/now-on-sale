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
          if (event.target.value != '') {
            axios.get(
              '/serials',
              {
                params: { query: event.target.value }
              }
            ).then(function(response){
              vm.serials = response.data;
            })
          }
        }, 1000);
      };
    })(),
    subscribe: function(serial_id){
      var vm = this;

      navigator.serviceWorker.ready
        .then(function(registration) {
          console.log('[Companion]', 'Service worker registered!');

          return registration.pushManager.getSubscription().then(function(subscription) {
            if (subscription) {
              return subscription;
            }
            return registration.pushManager.subscribe({
              userVisibleOnly: true
            });
          })
        }).then(function(subscription) {
          var endpoint = subscription.endpoint;
          var registration_id = endpoint.replace("https://android.googleapis.com/gcm/send/", "");

          console.log('[Companion]', "pushManager endpoint:", endpoint);

          $.post('/service_worker_push_subscriptions',
            {
              registration_id: registration_id
            },
            function(data) {
              if (data.result == 'success') {
                console.log('[Companion]', "pushManager endpoint saved (or already saved).");

                axios.post(
                  '/subscriptions',
                  {
                    serial_id: serial_id
                  }
                ).then(function(response){
                  Vue.set(vm.subscriptions, serial_id, true);
                })
              }
              else {
                console.log('[Companion]', "pushManager endpoint couldn't be saved.");
              }
            }
          );
        }).catch(function(error) {
          console.warn('[Companion]', "serviceWorker error:", error);
        });
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
