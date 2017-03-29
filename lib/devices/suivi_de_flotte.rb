# Copyright © Mapotempo, 2017
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
class SuiviDeFlotte < DeviceBase
  def definition
    {
      device: 'suivi_de_flotte',
      label: 'SuiviDeFlotte',
      label_small: 'SuiviDeFlotte',
      route_operations: [:send],
      has_sync: false,
      help: false,
      forms: {
        settings: {
          username: :text,
          password: :password
        },
        vehicle: {
          ref: :text
        },
      }
    }
  end
end
