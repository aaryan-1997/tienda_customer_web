importScripts("https://www.gstatic.com/firebasejs/7.20.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.20.0/firebase-messaging.js");

firebase.initializeApp({
   apiKey: "AIzaSyALDyH9CEtHUe3zfMu6Bbx6t6Lsgbo8sS4",
       authDomain: "tiendaweb-218ec.firebaseapp.com",
       projectId: "tiendaweb-218ec",
       storageBucket: "tiendaweb-218ec.appspot.com",
       messagingSenderId: "1009718506764",
       appId: "1:1009718506764:web:4f62a83e29c94c0c344529",
       measurementId: "G-ZMZQS98Q8E"

});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage---->>Web::::", message);
});