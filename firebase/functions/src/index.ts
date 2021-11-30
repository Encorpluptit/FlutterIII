import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

const customRegionFunction = functions.region("europe-west2");

exports.addUserToFirestorage = customRegionFunction.auth.user().onCreate((user) => {
    admin.firestore().collection("users").doc(user.uid).create({
        uid: user.uid,
        email: user.email,
        role: "User",
    }).then(() => {
        return ("OK");
    }).catch(() => {
        return ("NOT OK");
    });
});

exports.deleteUserOnFirestorage = customRegionFunction.auth.user().onDelete((user) => {
    admin.firestore().collection("users").doc(user.uid).delete().then(() => {
        return ("OK");
    }).catch(() => {
        return ("NOT OK");
    });
});
