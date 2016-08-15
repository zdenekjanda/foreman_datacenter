module ForemanDatacenter
  module SharedHelper
    def racks_list_for_site(site = nil)
      if site
        collection = ForemanDatacenter::Rack.select(:id, :name).where(site: site)
      else
        collection = []
      end
      select_tag :rack_id,
                 options_from_collection_for_select(collection, 'id', 'name'),
                 { :include_blank => 'Choose a rack', :class => 'form-control',
                   :'data-url' => for_rack_devices_path,
                   :onchange => 'connectionsNewRackSelected(this)' }
    end

    def devices_list_for_rack(rack = nil)
      collection = rack ? rack.devices.select(:id, :name) : []
      select_tag :device_id,
                 options_from_collection_for_select(collection, :id, :name),
                 { include_blank: 'Choose a device', class: 'form-control',
                   :onchange => 'newDeviceSelected(this)' }
    end

    def rack_device_select(site, options)
      render partial: 'foreman_datacenter/shared/rack_device_select',
             locals: { site: site, options: options }
    end
  end
end
