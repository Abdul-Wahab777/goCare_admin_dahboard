'use strict';

const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();




exports.allAdminNotification = functions.firestore.document('/notifications/adminnotifications')
    .onUpdate(async(change, context) => {
        const message = change.after.data();

        if (message['action'] === 'NOPUSH') {
            return console.log('Skipped Notification as it is not meant to be PUSHED');
        } else if (message['action'] === 'PUSH') {
            let payload;
            // Notification details.

            if (message['imageurl'] == null) {
                payload = {
                    notification: {
                        title: message['title'],
                        body: message['desc'],

                        click_action: 'FLUTTER_NOTIFICATION_CLICK',
                        priority: "high",
                        sound: 'default',
                    },
                    data: {
                        "body": message['desc'],
                        "title": message['title'],

                        "click_action": "FLUTTER_NOTIFICATION_CLICK",
                    },
                }
            } else {
                payload = {
                    notification: {
                        title: message['title'],
                        body: message['desc'],
                        image: message['imageurl'],
                        click_action: 'FLUTTER_NOTIFICATION_CLICK',
                        priority: "high",
                        sound: 'default',
                    },
                    data: {
                        "body": message['desc'],
                        "title": message['title'],
                        "image": message['imageurl'],
                        "click_action": "FLUTTER_NOTIFICATION_CLICK",
                    },
                }
            }

            var options = {
                priority: 'high',
                contentAvailable: true,

            };
            // Send notifications to all tokens.
            await admin.messaging().sendToTopic('ADMIN', payload, options);

        }
    });




exports.allUsersNotification = functions.firestore.document('/notifications/usersnotifications')
    .onUpdate(async(change, context) => {
        const message = change.after.data();

        if (message['action'] === 'NOPUSH') {
            return console.log('Skipped Notification as it is not meant to be PUSHED');
        } else if (message['action'] === 'PUSH') {
            let payload;
            // Notification details.
            if (message['imageurl'] == null) {
                payload = {
                    notification: {
                        title: message['title'],
                        body: message['desc'],

                        click_action: 'FLUTTER_NOTIFICATION_CLICK',
                        priority: "high",
                        sound: 'default',
                    },
                    data: {
                        "body": message['desc'],
                        "title": message['title'],

                        "click_action": "FLUTTER_NOTIFICATION_CLICK",
                    },
                }
            } else {
                payload = {
                    notification: {
                        title: message['title'],
                        body: message['desc'],
                        image: message['imageurl'],
                        click_action: 'FLUTTER_NOTIFICATION_CLICK',
                        priority: "high",
                        sound: 'default',
                    },
                    data: {
                        "body": message['desc'],
                        "title": message['title'],
                        "image": message['imageurl'],
                        "click_action": "FLUTTER_NOTIFICATION_CLICK",
                    },
                }
            }

            var options = {
                priority: 'high',
                contentAvailable: true,

            };
            // Send notifications to all tokens.
            await admin.messaging().sendToTopic('USERS', payload, options);

        }
    });