# frozen_string_literal: true

module Archimate
  module Svg
    module Entity
      class Equipment < BaseEntity
        include NodeShape

        def initialize(child, bounds_offset)
          super
          @badge = "#archimate-equipment-badge"
        end

	def entity_shape(xml, bounds)
            @badge = "#archimate-equipment-badge"
            node_path(xml, bounds)
        end
      end
    end
  end
end
