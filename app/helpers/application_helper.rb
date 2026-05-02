module ApplicationHelper
  THEME_TRANSLATION_KEYS = {
    "Which Renoir work best characterizes his artistic style?" => "themes.renoir",
    "Which Picasso work best characterizes his artistic style?" => "themes.picasso",
    "Which Matisse work best characterizes his artistic style?" => "themes.matisse"
  }.freeze

  def locale_switch_path(locale)
    url_for(
      request.path_parameters
        .merge(request.query_parameters)
        .merge(locale: locale, only_path: true)
    )
  end

  def flash_class(type)
    case type.to_sym
    when :notice
      "alert-success"
    when :alert
      "alert-warning"
    else
      "alert-info"
    end
  end

  def localized_theme_name(theme)
    translation_key = THEME_TRANSLATION_KEYS[theme.name]
    return theme.name unless translation_key

    t(translation_key, default: theme.name)
  end

  def localized_theme_options_for_select(themes, selected_theme)
    options_for_select(
      themes.map { |theme| [ localized_theme_name(theme), theme.id ] },
      selected_theme&.id
    )
  end
end
