# Copyright © Mapotempo, 2013-2015
#
# This file is part of Mapotempo.
#
# Mapotempo is free software. You can redistribute it and/or
# modify since you respect the terms of the GNU Affero General
# Public License as published by the Free Software Foundation,
# either version 3 of the License, or (at your option) any later version.
#
# Mapotempo is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
# or FITNESS FOR A PARTICULAR PURPOSE.  See the Licenses for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with Mapotempo. If not, see:
# <http://www.gnu.org/licenses/agpl.html>
#
class Layer < ApplicationRecord
  nilify_blanks
  auto_strip_attributes :name, :url, :attribution, :urlssl, :source
  validates :source, presence: true
  validates :name, presence: true
  validates :url, presence: true
  validates :urlssl, presence: true
  validates :attribution, presence: true

  def map_attribution
    I18n.t("all.map_attribution.#{source}", attribution: attribution)
  end
end
