Meteor.publish 'applicationDefs', -> ApplicationDefs.find()
Meteor.publish 'latestNotice', -> Messages.find {$or: [{type: 'info'}, {type: 'warning'}]}, limit: 1, sort: date: -1
Meteor.publish 'instances', -> Instances.find()
Meteor.publish 'instanceByName', (name)-> Instances.find name: name
Meteor.publish 'services', -> Services.find()
Meteor.publish 'appstore', -> AppStore.find {}, {sort: name: 1}
Meteor.publish 'events', -> Events.find {}, limit: 20, sort: timestamp: -1
Meteor.publish 'storage', -> StorageBuckets.find {}, sort: name: 1

Meteor.publish 'allUsers', ->
  loggedInUser = @userId
  if loggedInUser and Roles.userIsInRole(loggedInUser, ["admin"], Roles.GLOBAL_GROUP)
    Meteor.users.find {}
  else if loggedInUser
    Meteor.users.find { _id: @userId }
  else
    @stop()

Meteor.publish 'myRoles', ->
  loggedInUser = @userId
  if loggedInUser and Roles.userIsInRole(loggedInUser, ['admin'], Roles.GLOBAL_GROUP)
    Roles.getAllRoles()

Meteor.publish 'APIKey', -> APIKeys.find { owner: this.userId }, { fields: { key: 1}}
