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

exports.getAllUsers = functions.region("europe-west2").https.onCall((data, context) => {
    const allUsers: any[] = [];
    return admin.auth().listUsers()
        .then(function (listUsersResult) {
            listUsersResult.users.forEach(function (userRecord) {
                const userData = userRecord.toJSON();
                allUsers.push(userData);
            });
            return (JSON.stringify(allUsers));
        })
        .catch(function (error) {
            console.log("Error listing users:", error);
            throw new functions.https.HttpsError("unknown", error.message, error);
        });
});
