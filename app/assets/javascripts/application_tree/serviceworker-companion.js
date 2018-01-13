if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/serviceworker.js', { scope: './' });

  navigator.serviceWorker.ready
    .then(function(registration) {
      console.log('[Companion]', 'Service worker registered!');
    });
}
