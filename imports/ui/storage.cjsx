{ Meteor }          = require 'meteor/meteor'
React               = require 'react'

module.exports = React.createClass
  displayName: 'Storage'

  propTypes:
    buckets: React.PropTypes.array.isRequired
    onDelete: React.PropTypes.func
    onCopy: React.PropTypes.func
    authenticated: React.PropTypes.bool.isRequired

  copy: (bucket) -> (e) =>
    e.preventDefault()
    @props.onCopy bucket.name, @refs.bucketName.value

  render: ->
    <div className="list-group">
      {for bucket in @props.buckets
        <div className="list-group-item" key={bucket._id}>
          <span>{bucket.name}</span>
          {if @props.authenticated
            <span>
              <span>
                <a href='#' className="dropdown-toggle" data-toggle="dropdown">
                  <i className="pull-right material-icons">delete_forever</i>
                </a>
                <form onClick={@dontClose} role="form" className="dropdown-menu dropdown-menu-right" style={padding:'1em'}>
                    <div className="form-group" style={width:'25em'}>
                      <h4>Delete data bucket '{bucket.name}'</h4>
                      <div className="alert alert-warning" role="alert">
                        All data inside the bucket will be removed. This operation is irreversible.<br />
                        <strong>Do you really want to delete this data bucket?</strong>
                      </div>

                    </div>
                    <button type="button" onClick={@props.onDelete?.bind(bucket)} className="clear-instance btn btn-mini btn-danger pull-right">Yes, destroy the data in this bucket!</button>
                </form>
              </span>
              <span>
                <a href='#' className="dropdown-toggle" data-toggle="dropdown">
                  <i className="pull-right material-icons">content_copy</i>
                </a>
                <form id="start-app-form" role="form" className="dropdown-menu dropdown-menu-right" style={padding:'1em'}>
                    <div class="form-group" style={width:'30em'}>
                        <label>Bucket name</label>
                        <input ref='bucketName' required pattern="/?[a-zA-Z0-9_-]+" type="text"
                          className="form-control bucket-name"
                          placeholder="A unique name. Must match /?[a-zA-Z0-9_-]+." />
                    </div>
                    <button type="submit" onClick={@copy(bucket)} className="start-app btn btn-mini">Copy</button>
                </form>
              </span>

            </span>
          }
        </div>
      }
    </div>
