
Marionette = require('backbone.marionette')

Entry = Marionette.LayoutView.extend(
  template: require('../templates/blog/item.pug')
  tagName: 'li'

  triggers:
    click: 'select:entry'
)

BlogList = Marionette.CollectionView.extend(
  childView: Entry
  tagName: 'ul'
  onChildviewSelectEntry: (child, options) ->
    @triggerMethod('select:entry', child.model)
)

module.exports = BlogList