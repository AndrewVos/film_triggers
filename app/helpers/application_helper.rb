module ApplicationHelper
  def flash_class(level)
    "alert alert-#{BOOTSTRAP_NAMES_FOR_LEVELS.fetch level}"
  end

  BOOTSTRAP_NAMES_FOR_LEVELS = {
    notice: 'info',
    success: 'success',
    error: 'danger',
    alert: 'warning'
  }.with_indifferent_access
end
