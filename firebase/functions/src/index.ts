import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

admin.initializeApp();

exports.getAllUsers = functions.https.onRequest((req, res) => {
    var allUsers: any[] = [];
    return admin.auth().listUsers()
        .then(function (listUsersResult) {
            listUsersResult.users.forEach(function (userRecord) {
                var userData = userRecord.toJSON();
                allUsers.push(userData);
            });
            res.status(200).send(JSON.stringify(allUsers));
        })
        .catch(function (error) {
            console.log("Error listing users:", error);
            res.status(500).send(error);
        });
});