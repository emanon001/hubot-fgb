{Promise} = require 'es6-promise'
GitHub = require 'github'

class PullRequestManager
  constructor: ({ token } = {}) ->
    @github = new GitHub version: '3.0.0'
    @github.authenticate
      type: 'oauth'
      token: token

  create: (user, repo, title, base, head) ->
    new Promise (resolve, reject) =>
      options = { user, repo, title, base, head }
      @github.pullRequests.create options, (err, ret) ->
        if err?
          reject err
        else
          resolve ret

  get: (user, repo, number) ->
    new Promise (resolve, reject) =>
      @github.pullRequests.get { user, repo, number }, (err, ret) ->
        if err?
          reject err
        else
          resolve ret

  list: (user, repo) ->
    new Promise (resolve, reject) =>
      @github.pullRequests.getAll { user, repo }, (err, ret) ->
        if err?
          reject err
        else
          resolve ret

  merge: (user, repo, number) ->
    new Promise (resolve, reject) =>
      @github.pullRequests.merge { user, repo, number }, (err, ret) ->
        if err?
          reject err
        else
          resolve ret

module.exports.PullRequestManager = PullRequestManager
