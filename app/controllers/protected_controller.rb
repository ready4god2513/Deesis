class ProtectedController < ApplicationController
  before_filter :require_login
end