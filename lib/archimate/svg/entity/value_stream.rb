# frozen_string_literal: true

module Archimate
  module Svg
    module Entity
      class ValueStream < RoundedRectEntity
        def initialize(child, bounds_offset)
          super
          @badge = "#archimate-value-stream-badge"
        end
      end
    end
  end
end
