if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/serviceworker.js', { scope: './' })

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

      $.post('/service_worker_push_subscriptions', {
          registration_id: registration_id
        },
        function(data) {
          if (data.result == 'success') {
            console.log('[Companion]', "pushManager endpoint saved (or already saved).");
          }
          else {
            console.log('[Companion]', "pushManager endpoint couldn't be saved.");
          }
        }
      );
    }).catch(function(error) {
      console.warn('[Companion]', "serviceWorker error:", error);
    });
}
