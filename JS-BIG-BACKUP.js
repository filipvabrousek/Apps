const functions = require('firebase-functions');
const admin = require("firebase-admin");
admin.initializeApp(functions.config().firebase);
// https://stackoverflow.com/questions/45150934/receive-push-notifications-on-firebase-database-child-added?rq=1


exports.sendPushNotification = functions.database.ref("/Chat/{id}").onWrite((change, context) => {
	// https://stackoverflow.com/questions/43913139/firebase-http-cloud-functions-read-database-once
	const snapshot = change.after;
	
    
    console.log("No need to install in xCodmmm :)");
    console.log("Snapshot is " + snapshot);
    console.log(snapshot.child("body").val());
	
    const payload = {
		notification: {
			title: "Hello ",
			body: "I am texting :) " + snapshot.child("body").val(),
			badge: "1",
			sound: "default"
		}
	};
    
    
	return admin.database().ref("fcmAuth").once("value").then(all => {
		if (all.val()) {
			const token = Object.keys(all.val());
			return admin.messaging().sendToDevice(token, payload).then(response =>  {});
		}
	});
});
// firebase deploy --only functions





// or return admin.database()....
/*   return admin.database().ref('/Chat/{id}').once('child_added').then(function(snap) {
 

      
        let m = snap.child("text");
console.log("Snap is " + snap); 
    console.log("Value is ");
        // or log m
        console.log(m.val());
  
        
        
 
    };*/
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });
