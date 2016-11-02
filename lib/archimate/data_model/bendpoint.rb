# frozen_string_literal: true
module Archimate
  module DataModel
    class Bendpoint < Dry::Struct
      include DataModel::With

      attribute :parent_id, Strict::String
      attribute :start_x, Coercible::Float.optional
      attribute :start_y, Coercible::Float.optional
      attribute :end_x, Coercible::Float.optional
      attribute :end_y, Coercible::Float.optional

      def to_s
        "Bendpoint(start_x: #{start_x}, start_y: #{start_y}, end_x: #{end_x}, end_y: #{end_y})"
      end

      def comparison_attributes
        [:@start_x, :@start_y, :@end_x, :@end_y]
      end
    end

    Dry::Types.register_class(Bendpoint)
    BendpointList = Strict::Array.member(Bendpoint)
  end
end
