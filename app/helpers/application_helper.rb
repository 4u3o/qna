# frozen_string_literal: true

module ApplicationHelper
  def dt_format(datetime)
    datetime.strftime('%b %e, %Y at %H:%M')
  end
end
