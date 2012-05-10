require "mustache"
require "haml"
require "active_support"

module SmtRails
  module Mustache
    def self.call(template)
      if template.locals.include?(SmtRails.action_view_key.to_s) || template.locals.include?(SmtRails.action_view_key.to_sym)
        "Mustache.render(Haml::Engine.new(#{template.source.inspect}).render, #{SmtRails.action_view_key.to_s}).html_safe"
      else
        "Haml::Engine.new(#{template.source.inspect}).render().html_safe"
      end
    end
  end
end

ActiveSupport.on_load(:action_view) do
  ActionView::Template.register_template_handler(::SmtRails.template_extension.to_sym, ::SmtRails::Mustache)
end