const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.onUserDeleted = functions.auth.user().onDelete(async (user) => {
  let firestore = admin.firestore();
  let userRef = firestore.doc("users/" + user.uid);
  await firestore.collection("users").doc(user.uid).delete();
});
const OneSignal = require("@onesignal/node-onesignal");

const kUserKey =
  "os_v2_org_twenjl66rvcdfdvlajtyapjblxtardrhwegugvnbuhgdkdrd73ywa2at3xk4n5wfg535mtwjhkz2zin44r4xb2eg3642tuv7ql5qkfi";
const kAPIKey =
  "os_v2_app_62g6lyqeifcplogc6lmr4dyblhkyt72zsakewhngciacl6aevnmrxgclpceqirwouaxbvzgqztzklm76v3erzdpogmssyd4fxvl2cgy";

const configuration = OneSignal.createConfiguration({
  userKey: kUserKey,
  appKey: kAPIKey,
});
const client = new OneSignal.DefaultApi(configuration);
const user = new OneSignal.User();
const axios = require("axios");

exports.addUser = functions.https.onCall(async (data, context) => {
  if (context.auth.uid != data.user_id) {
    return "Unauthenticated calls are not allowed.";
  }
  try {
    user.identity = {
      external_id: data.user_id,
    };
    user.properties = {
      tags: data.tags,
    };
    user.subscriptions = data.subscriptions;
    const createdUser = await client.createUser(
      "f68de5e2-0441-44f5-b8c2-f2d91e0f0159",
      user,
    );
    if (createdUser.identity["onesignal_id"] == null) {
      throw new functions.https.HttpsError(
        "aborted",
        "Could not create OneSignal user",
      );
    }
    return createdUser;
  } catch (err) {
    console.error(
      `Unable to create user ${context.auth.uid}.
            Error ${err}`,
    );
    throw new functions.https.HttpsError(
      "aborted",
      "Could not create OneSignal user",
    );
  }
});

exports.deleteUser = functions.https.onCall(async (data, context) => {
  if (context.auth.uid != data.user_id) {
    return "Unauthenticated calls are not allowed.";
  }

  const url = `https://api.onesignal.com/apps/f68de5e2-0441-44f5-b8c2-f2d91e0f0159/users/by/external_id/${data.user_id}`;

  try {
    await axios.delete(url, {
      headers: {
        Authorization: `Basic ${kAPIKey}`,
      },
    });
    return "User deleted";
  } catch (err) {
    console.error(
      `Unable to delete user ${context.auth.uid}. Error: ${err.message}`,
    );
    throw new functions.https.HttpsError(
      "aborted",
      "Could not delete OneSignal user",
    );
  }
});
